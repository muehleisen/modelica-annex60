within Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.BoreHoles.BaseClasses.Examples;
model SingleBoreHole2UTUbe "Test for the SingleBoreHole model"
  extends BaseClasses.BoreholeSegment;

  Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.BoreHoles.BaseClasses.SingleBoreHole2UTube
    seg(
    redeclare package Medium = Medium,
    soi=Data.SoilData.SandStone(),
    fil=Data.FillingData.Bentonite(),
    gen=Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.GeneralData.c8x1_h110_b5_d600_T283_2UTubeParallel_2Series(),
    m_flow_nominal=seg.gen.m_flow_nominal_bh,
    dp_nominal=1000,
    show_T=true)
            annotation (Placement(transformation(
        extent={{-13,-13},{13,13}},
        rotation=270,
        origin={29,35})));

equation
  connect(senTem_in.port_b, seg.port_a)
    annotation (Line(points={{0,50},{29,50},{29,48}}, color={0,127,255}));
  connect(senTem_out.port_a, seg.port_b)
    annotation (Line(points={{0,20},{29,20},{29,22}}, color={0,127,255}));
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
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/BaseClasses/BoreHoles/Examples/SingleBoreHole2UTube.mos"
        "simulate and plot"));
end SingleBoreHole2UTUbe;
