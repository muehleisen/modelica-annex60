within Annex60.Fluid.MixingVolumes.Validation;
model MixingVolumeZeroFlowMultiPort
  extends Modelica.Icons.Example;
  package Medium = Annex60.Media.Water;
  Annex60.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    V=1,
    nPorts=4,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Steady state mixing volume with 4 ports"
              annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={0,-90})));
  Annex60.Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=2) "Boundary"
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={86,30})));
  Annex60.Fluid.Movers.BaseClasses.IdealSource idealSource(
    redeclare package Medium = Medium,
    control_m_flow=true,
    m_flow_small=0.001) "Mass flow source"
    annotation (Placement(transformation(extent={{-38,-90},{-58,-70}})));
  Modelica.Blocks.Sources.SawTooth
                                doubleRamp(period=1, amplitude=1e-6)
    "Step function for mass flow source"
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Annex60.Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    V=1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    nPorts=2) "Steady state mixing volume with 2 ports"
              annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-90,-70})));
  Modelica.Blocks.Sources.Cosine cosine1(freqHz=1, offset=273.15)
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  Annex60.Fluid.Movers.BaseClasses.IdealSource idealSource1(
    redeclare package Medium = Medium,
    control_m_flow=true,
    m_flow_small=0.001) "Mass flow source"
    annotation (Placement(transformation(extent={{-40,-30},{-60,-10}})));
  Annex60.Fluid.MixingVolumes.MixingVolume vol2(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    V=1,
    nPorts=3,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Steady state mixing volume with 3 ports"
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,-90})));
  Annex60.Fluid.MixingVolumes.MixingVolume vol3(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    V=1,
    nPorts=4,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    prescribedHeatFlowRate=true) "Steady state mixing volume with 4 ports"
              annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={0,-30})));
  Annex60.Fluid.MixingVolumes.MixingVolume vol4(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    V=1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    nPorts=2) "Steady state mixing volume with 2 ports"
              annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-90,0})));
  Annex60.Fluid.MixingVolumes.MixingVolume vol5(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    V=1,
    nPorts=3,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Steady state mixing volume with 3 ports"
              annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={60,30})));
  Annex60.Fluid.Movers.BaseClasses.IdealSource idealSource2(
    redeclare package Medium = Medium,
    control_m_flow=true,
    m_flow_small=0.001) "Mass flow source"
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Annex60.Fluid.Movers.BaseClasses.IdealSource idealSource3(
    redeclare package Medium = Medium,
    control_m_flow=true,
    m_flow_small=0.001) "Mass flow source"
    annotation (Placement(transformation(extent={{22,-60},{42,-40}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-34,-40},{-14,-20}})));
equation
  connect(doubleRamp.y, idealSource.m_flow_in)
    annotation (Line(points={{-59,40},{-42,40},{-42,-72}}, color={0,0,127}));
  connect(idealSource.port_a, vol.ports[1]) annotation (Line(points={{-38,-80},
          {-38,-80},{-3,-80}},color={0,127,255}));
  connect(cosine1.y, bou.T_in)
    annotation (Line(points={{81,70},{90,70},{90,42}}, color={0,0,127}));
  connect(idealSource.port_b, vol1.ports[1]) annotation (Line(points={{-58,-80},
          {-80,-80},{-80,-68}}, color={0,127,255}));
  connect(vol1.ports[2], vol.ports[2]) annotation (Line(points={{-80,-72},{-80,-72},
          {-80,-50},{-1,-50},{-1,-80}}, color={0,127,255}));
  connect(idealSource1.m_flow_in, doubleRamp.y)
    annotation (Line(points={{-44,-12},{-44,40},{-59,40}}, color={0,0,127}));
  connect(bou.ports[1], vol2.ports[1]) annotation (Line(points={{88,20},{88,20},
          {88,-80},{52.6667,-80}}, color={0,127,255}));
  connect(vol2.ports[2], vol.ports[3])
    annotation (Line(points={{50,-80},{24,-80},{1,-80}}, color={0,127,255}));
  connect(vol3.ports[1], idealSource1.port_a) annotation (Line(points={{-3,-20},
          {-20,-20},{-40,-20}}, color={0,127,255}));
  connect(vol3.ports[2], vol2.ports[3]) annotation (Line(points={{-1,-20},{-1,
          -20},{47.3333,-20},{47.3333,-80}},
                                        color={0,127,255}));
  connect(vol4.ports[1], idealSource1.port_b)
    annotation (Line(points={{-80,2},{-80,-20},{-60,-20}}, color={0,127,255}));
  connect(vol4.ports[2], vol3.ports[3]) annotation (Line(points={{-80,-2},{-80,20},
          {1,20},{1,-20}}, color={0,127,255}));
  connect(idealSource2.m_flow_in, doubleRamp.y)
    annotation (Line(points={{24,28},{24,40},{-59,40}}, color={0,0,127}));
  connect(vol.ports[4], idealSource3.port_a) annotation (Line(points={{3,-80},{
          2,-80},{2,-50},{22,-50}},
                                  color={0,127,255}));
  connect(idealSource3.port_b, vol5.ports[1]) annotation (Line(points={{42,-50},
          {62.6667,-50},{62.6667,20}}, color={0,127,255}));
  connect(vol5.ports[2], bou.ports[2])
    annotation (Line(points={{60,20},{86,20},{84,20}}, color={0,127,255}));
  connect(idealSource2.port_a, vol3.ports[4]) annotation (Line(points={{20,20},{
          4,20},{4,-20},{3,-20}}, color={0,127,255}));
  connect(idealSource2.port_b, vol5.ports[3])
    annotation (Line(points={{40,20},{57.3333,20}}, color={0,127,255}));
  connect(idealSource3.m_flow_in, doubleRamp.y) annotation (Line(points={{26,
          -42},{26,-42},{26,40},{-59,40}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, vol3.heatPort)
    annotation (Line(points={{-14,-30},{-12,-30},{-10,-30}}, color={191,0,0}));
  connect(prescribedHeatFlow.Q_flow, doubleRamp.y)
    annotation (Line(points={{-34,-30},{-34,40},{-59,40}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=10),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This model illustrates the use of a steady state mixing volume that is connected to more than two ports.</p>
<p>Its main goal is to prove that the model behaves well for zero flow when multiple ports are connected to the model.</p>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/MixingVolumes/Validation/MixingVolumeZeroFlowMultiPort.mos"
        "Simulate and plot"));
end MixingVolumeZeroFlowMultiPort;
