within Annex60.Fluid.Interfaces;
model StaticMultiPortConservationEquation
  "Partial model for static energy and mass conservation equations"

  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal mass flow rate"
    annotation(Dialog(group = "Nominal condition"));
  parameter Modelica.SIunits.MassFlowRate m_flow_small(min=0) = 1E-4*abs(m_flow_nominal)
    "Small mass flow rate for regularization of zero flow"
    annotation(Dialog(tab = "Advanced"));
    // Port definitions
  parameter Integer nPorts(min=3)=3 "Number of ports"
    annotation(Evaluate=true, Dialog(connectorSizing=true, tab="General",group="Ports"));

  constant Boolean simplify_mWat_flow = true
    "Set to true to cause port_a.m_flow + port_b.m_flow = 0 even if mWat_flow is non-zero";

  constant Boolean prescribedHeatFlowRate = false
    "Set to true if the heat flow rate is not a function of a temperature difference to the fluid temperature";

  parameter Boolean use_mWat_flow = false
    "Set to true to enable input connector for moisture mass flow rate"
    annotation(Evaluate=true, Dialog(tab="Advanced"));

  parameter Boolean use_C_flow = false
    "Set to true to enable input connector for trace substance"
    annotation(Evaluate=true, Dialog(tab="Advanced"));

  constant Modelica.SIunits.MassFlowRate eps = 1e-10
    "Constant for regularising mass flow rates";

  parameter Modelica.SIunits.HeatFlowRate Q_flow_small = deltaReg * cp_default/1E3
    "Small heat flow rate for checkign conservation of energy";

  Modelica.Blocks.Interfaces.RealInput Q_flow(unit="W")
    "Sensible plus latent heat flow rate transferred into the medium"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput mWat_flow(final quantity="MassFlowRate",
                                                 unit="kg/s") if
       use_mWat_flow "Moisture mass flow rate added to the medium"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput[Medium.nC] C_flow if
       use_C_flow "Trace substance mass flow rate added to the medium"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));

  // Outputs that are needed in models that extend this model
  Modelica.Blocks.Interfaces.RealOutput hOut(unit="J/kg",
                                             start=Medium.specificEnthalpy_pTX(
                                                     p=Medium.p_default,
                                                     T=Medium.T_default,
                                                     X=Medium.X_default))
    "Leaving specific enthalpy of the component"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,110})));

  Modelica.Blocks.Interfaces.RealOutput XiOut[Medium.nXi](each unit="1",
                                                          each min=0,
                                                          each max=1)
    "Leaving species concentration of the component"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,110})));
  Modelica.Blocks.Interfaces.RealOutput COut[Medium.nC](each min=0)
    "Leaving trace substances of the component"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,110})));

protected
  final parameter Boolean use_m_flowInv=
    (prescribedHeatFlowRate or use_mWat_flow or use_C_flow)
    "Flag, true if m_flowInv is used in the model"
    annotation (Evaluate=true);
  final parameter Real s[Medium.nXi] = {if Modelica.Utilities.Strings.isEqual(string1=Medium.substanceNames[i],
                                            string2="Water",
                                            caseSensitive=false)
                                            then 1 else 0 for i in 1:Medium.nXi}
    "Vector with zero everywhere except where species is";
  final parameter Medium.ThermodynamicState state_default = Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default[1:Medium.nXi]) "Medium state at default values";
  // Density at medium default values, used to compute the size of control volumes
  final parameter Modelica.SIunits.SpecificHeatCapacity cp_default=Medium.specificHeatCapacityCp(
    state=state_default) "Density, used to compute fluid mass";

  Real m_flowInv(unit="s/kg") "Regularization of 1/m_flow of port_a";

  Modelica.SIunits.MassFlowRate mXi_flow[Medium.nXi]
    "Mass flow rates of independent substances added to the medium";
  Modelica.SIunits.MassFlowRate m_flow "Total inlet mass flow rates";

  // Parameters for inverseXRegularized.
  // These are assigned here for efficiency reason.
  // Otherwise, they would need to be computed each time
  // the function is invocated.
  final parameter Real deltaReg = m_flow_small/1E3
    "Smoothing region for inverseXRegularized";

   final parameter Real deltaInvReg = 1/deltaReg
    "Inverse value of delta for inverseXRegularized";
   final parameter Real aReg = -15*deltaInvReg
    "Polynomial coefficient for inverseXRegularized";
   final parameter Real bReg = 119*deltaInvReg^2
    "Polynomial coefficient for inverseXRegularized";
   final parameter Real cReg = -361*deltaInvReg^3
    "Polynomial coefficient for inverseXRegularized";
   final parameter Real dReg = 534*deltaInvReg^4
    "Polynomial coefficient for inverseXRegularized";
   final parameter Real eReg = -380*deltaInvReg^5
    "Polynomial coefficient for inverseXRegularized";
   final parameter Real fReg = 104*deltaInvReg^6
    "Polynomial coefficient for inverseXRegularized";

  // Conditional connectors
  Modelica.Blocks.Interfaces.RealInput mWat_flow_internal(unit="kg/s")
    "Needed to connect to conditional connector";
  Modelica.Blocks.Interfaces.RealInput C_flow_internal[Medium.nC]
    "Needed to connect to conditional connector";
public
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports[nPorts](
      redeclare each final package Medium = Medium) "Fluid inlets and outlets"
    annotation (Placement(transformation(extent={{-40,-10},{40,10}},
      origin={0,-100},
        rotation=0)));
initial equation
  // Assert that the substance with name 'water' has been found.
  assert(Medium.nXi == 0 or abs(sum(s)-1) < 1e-5,
      "If Medium.nXi > 1, then substance 'water' must be present for one component.'"
         + Medium.mediumName + "'.\n"
         + "Check medium model.");

equation
  // Conditional connectors
  connect(mWat_flow, mWat_flow_internal);
  if not use_mWat_flow then
    mWat_flow_internal = 0;
  end if;

  connect(C_flow, C_flow_internal);
  if not use_C_flow then
    C_flow_internal = zeros(Medium.nC);
  end if;

  // Species flow rate from connector mWat_flow
  mXi_flow = mWat_flow_internal * s;

  // Total inlet mass flow rate
  m_flow=sum({ max(eps, ports[i].m_flow) for i in 1:nPorts});

  // Regularization of m_flow around the origin to avoid a division by zero
  // m_flowInv is only used if prescribedHeatFlowRate == true, or
  // if the input connectors mWat_flow or C_flow are enabled.
  if use_m_flowInv then
    m_flowInv = Annex60.Utilities.Math.Functions.inverseXRegularized(
                       x=m_flow,delta=deltaReg,  deltaInv=deltaInvReg,
                        a=aReg, b=bReg, c=cReg, d=dReg, e=eReg, f=fReg);
  else
    // m_flowInv is not used.
    m_flowInv = 0;
  end if;

    hOut =  ports[1].h_outflow;
    XiOut = ports[1].Xi_outflow;
    COut =  ports[1].C_outflow;

  //////////////////////////////////////////////////////////////////////////////////////////
  // Energy balance and mass balance

    // Mass balance (no storage)
    sum(ports.m_flow) = if simplify_mWat_flow then 0 else -mWat_flow_internal;

    assert(use_m_flowInv or use_mWat_flow == false, "Wrong implementation for forward flow.");
    assert(not use_C_flow or use_m_flowInv, "Wrong implementation of trace substance balance for forward flow.");

    for i in 1:nPorts loop
      for k in 1:Medium.nXi loop
      // Substance balance
        ports[i].Xi_outflow[k] = (sum({ inStream(ports[j].Xi_outflow[k]) * max(eps,ports[j].m_flow) for j in cat(1,1:i-1, i+1:nPorts)})+ (if use_m_flowInv then mXi_flow[k] else 0)) * m_flowInv;
      end for;
    end for;

    for i in 1:nPorts loop
      // Energy balance.
      // This equation is approximate since m_flow = port_a.m_flow is used for the mass flow rate
      // at both ports. Since mWat_flow_internal << m_flow, the error is small.
      if prescribedHeatFlowRate then
        assert(abs(Q_flow)<Q_flow_small or max(ports.m_flow)>deltaReg, "Model does not conserve energy since heat flow rate Q = " + String(Q_flow) + " exists when m_flow = " + String(m_flow)+ " is small");
        ports[i].h_outflow = (sum({ inStream(ports[j].h_outflow) * max(eps,ports[j].m_flow) for j in cat(1,1:i-1, i+1:nPorts)})+ Q_flow) * m_flowInv;
      else
        // Case with prescribedHeatFlowRate == false.
        // port_b.h_outflow is known and the equation needs to be solved for Q_flow.
        // Hence, we cannot use m_flowInv as for m_flow=0, any Q_flow would satisfiy
        // Q_flow * m_flowInv = 0.
        // The same applies for port_b.Xi_outflow and mXi_flow.
        m_flow*ports[i].h_outflow = sum({ inStream(ports[j].h_outflow) * max(eps,ports[j].m_flow) for j in cat(1,1:i-1, i+1:nPorts)})+ Q_flow;
      end if;

      // Transport of trace substances
      for k in 1:Medium.nC loop
        ports[i].C_outflow[k] = sum({ inStream(ports[j].C_outflow[k]) * max(eps,ports[j].m_flow) for j in cat(1,1:i-1, i+1:nPorts)})+ (if use_m_flowInv and use_C_flow then C_flow_internal[k] else 0) * m_flowInv;
      end for;
  end for;

  ////////////////////////////////////////////////////////////////////////////
  // No pressure drop in this model
  for i in 2:nPorts loop
    ports[i].p = ports[1].p;
  end for;

  annotation (
    preferredView="info",
    Documentation(info="<html>
<p>
This model transports fluid between its ports, without storing mass or energy.
It implements a steady-state conservation equation for energy and mass fractions.
The model has zero pressure drop between its ports.
</p>

<h4>Typical use and important parameters</h4>
<p>
Set the parameter <code>use_mWat_flow_in=true</code> to enable an
input connector for <code>mWat_flow</code>.
Otherwise, the model uses <code>mWat_flow = 0</code>.
</p>
<p>
If the constant <code>simplify_mWat_flow = true</code>, which is its default value,
then the equation
</p>
<pre>
  sum(ports[:].m_flow) = - mWat_flow;
</pre>
<p>
is simplified as
</p>
<pre>
  sum(ports[:].m_flow) = 0;
</pre>
<p>
This causes an error in the mass balance of about <i>0.5%</i>, but generally leads to
simpler equations because the pressure drop equations are then decoupled from the
mass exchange in this component.
</p>

<p>
To increase the numerical robustness of the model, the constant
<code>prescribedHeatFlowRate</code> can be set.
Use the following settings:
</p>
<ul>
<li>Set <code>prescribedHeatFlowRate=true</code> if the <i>only</i> means of heat transfer
at the <code>heatPort</code> is a prescribed heat flow rate that
is <i>not</i> a function of the temperature difference
between the medium and an ambient temperature. Examples include an ideal electrical heater,
a pump that rejects heat into the fluid stream, or a chiller that removes heat based on a performance curve.
If the <code>heatPort</code> is not connected, then set <code>prescribedHeatFlowRate=true</code> as
in this case, <code>heatPort.Q_flow=0</code>.
When <code>prescribedHeatFlowRate=true</code> 
an assert is added that checks if <code>heatPort.Q_flow=0</code> 
when all mass flow rates equal zero, 
since otherwise energy is not conserved.
</li>
<li>Set <code>prescribedHeatFlowRate=false</code> if there is heat flow at the <code>heatPort</code>
computed as <i>K * (T-heatPort.T)</i>, for some temperature <i>T</i> and some conductance <i>K</i>,
which may itself be a function of temperature or mass flow rate.<br/>
If there is a combination of <i>K * (T-heatPort.T)</i> and a prescribed heat flow rate,
for example a solar collector that dissipates heat to the ambient and receives heat from
the solar radiation, then set <code>prescribedHeatFlowRate=false</code>.
</li>
</ul>
<p>
If <code>prescribedHeatFlow=true</code>, then energy and mass balance
equations are formulated to guard against numerical problems near
zero flow that can occur if <code>Q_flow</code> or <code>m_flow</code>
are the results of an iterative solver.
</p>
<h4>Implementation</h4>
<p>
Input connectors of the model are
</p>
<ul>
<li>
<code>Q_flow</code>, which is the sensible plus latent heat flow rate added to the medium,
</li>
<li>
<code>mWat_flow</code>, which is the moisture mass flow rate added to the medium, and
</li>
<li>
<code>C_flow</code>, which is the trace substance mass flow rate added to the medium.
</li>
</ul>

<p>
The model can only be used as a steady-state model with multiple fluid ports.
For a model with a dynamic balance, use
<a href=\"modelica://Annex60.Fluid.Interfaces.ConservationEquation\">
Annex60.Fluid.Interfaces.ConservationEquation</a>.
For a model with a static balance and two ports, use
<a href=\"modelica://Annex60.Fluid.Interfaces.StaticTwoPortConservationEquation\">
Annex60.Fluid.Interfaces.StaticTwoPortConservationEquation</a>.
</p>
</html>",
revisions="<html>
<ul>
<li>
May 3, 2016 by Filip Jorissen:<br/>
First implementation for <a href=\"https://github.com/iea-annex60/modelica-annex60/issues/445\">
issue 445</a>.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-93,72},{-58,89}},
          lineColor={0,0,127},
          textString="Q_flow"),
        Text(
          extent={{-93,37},{-58,54}},
          lineColor={0,0,127},
          textString="mWat_flow"),
        Text(
          extent={{-41,103},{-10,117}},
          lineColor={0,0,127},
          textString="hOut"),
        Text(
          extent={{10,103},{41,117}},
          lineColor={0,0,127},
          textString="XiOut"),
        Text(
          extent={{61,103},{92,117}},
          lineColor={0,0,127},
          textString="COut"),
        Line(points={{-42,55},{-42,-84}}, color={255,255,255}),
        Polygon(
          points={{-42,67},{-50,45},{-34,45},{-42,67}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{87,-73},{65,-65},{65,-81},{87,-73}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-56,-73},{81,-73}}, color={255,255,255}),
        Line(points={{6,14},{6,-37}},     color={255,255,255}),
        Line(points={{54,14},{6,14}},     color={255,255,255}),
        Line(points={{6,-37},{-42,-37}},  color={255,255,255})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})));
end StaticMultiPortConservationEquation;
