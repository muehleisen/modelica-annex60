within Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.BoreHoles.BaseClasses.Examples;
model BoreholeSegment "Test for the boreholeSegment model"
  extends BaseClasses.BoreholeSegment;

  BoreHoleSegmentFourPort seg(
    redeclare package Medium = Medium,
    dp_nominal=5,
    soi=Data.SoilData.SandStone(),
    fil=Data.FillingData.Bentonite(),
    gen=Data.GeneralData.c8x1_h110_b5_d3600_T283(),
    m1_flow_nominal=m_flow_nominal,
    m2_flow_nominal=m_flow_nominal)                 annotation (Placement(transformation(
        extent={{-13,-13},{13,13}},
        rotation=270,
        origin={11,-1})));

equation
  connect(seg.port_b1, seg.port_a2) annotation (Line(
      points={{18.8,-14},{3.2,-14}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem_in.port_b, seg.port_a1) annotation (Line(points={{0,50},{20,50},
          {20,12},{18.8,12}}, color={0,127,255}));
 connect(seg.port_b2, senTem_out.port_a)
    annotation (Line(points={{3.2,12},{3.2,20},{0,20}}, color={0,127,255}));

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
    __Dymola_Commands(file="Resources/Scripts/Dymola/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/BaseClasses/BoreHoles/Examples/boreholeSegment.mos"
        "simulate and plot"));
end BoreholeSegment;
