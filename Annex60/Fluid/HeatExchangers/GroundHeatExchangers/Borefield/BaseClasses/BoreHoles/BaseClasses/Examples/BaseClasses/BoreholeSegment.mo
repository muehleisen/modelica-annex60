within Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.BoreHoles.BaseClasses.Examples.BaseClasses;
partial model BoreholeSegment "Test for the boreholeSegment model"
  extends Modelica.Icons.Example;
  package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 1
    "Nominal mass flwo rate";

  Annex60.Fluid.Sources.MassFlowSource_T sou_1(
    redeclare package Medium = Medium,
    use_T_in=false,
    m_flow=m_flow_nominal,
    T=303.15,
    nPorts=1) annotation (Placement(transformation(extent={{-60,40},{-40,
            60}}, rotation=0)));
  Annex60.Fluid.Sources.Boundary_pT sin_2(
    redeclare package Medium = Medium,
    use_p_in=false,
    use_T_in=false,
    p=101330,
    T=283.15,
    nPorts=1) annotation (Placement(transformation(extent={{-60,10},{-40,30}},
          rotation=0)));
  Sensors.TemperatureTwoPort senTem_in(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Sensors.TemperatureTwoPort senTem_out(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{0,10},{-20,30}})));
equation
  connect(senTem_in.port_a, sou_1.ports[1])
    annotation (Line(points={{-20,50},{-30,50},{-40,50}}, color={0,127,255}));
  connect(senTem_out.port_b, sin_2.ports[1])
    annotation (Line(points={{-20,20},{-30,20},{-40,20}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},
            {100,100}})),
    experimentSetupOutput,
    Diagram,
    Documentation(info="<html>
This example illustrates modeling a segment of a borehole heat exchanger.
It simulates the behavior of the borehole on a single horizontal section including the ground and the
boundary condition.
</html>", revisions="<html>
<ul>
<li>
August 30, 2011, by Pierre Vigouroux:<br>
First implementation.
</li>
</ul>
</html>"));
end BoreholeSegment;
