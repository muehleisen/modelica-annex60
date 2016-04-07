within Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.BoreHoles.BaseClasses.Examples;
model SingleBoreHolesInSerie "FIXME: this does not compile while 
  Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Examples.borefield8x1 does. I don't know why."
  extends BaseClasses.BoreholeSegment;

  Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.BoreHoles.SingleBoreHolesInSerie
    seg(
    redeclare package Medium = Medium,
    soi=Data.SoilData.SandStone(),
    fil=Data.FillingData.Bentonite(),
    gen=Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.GeneralData.c8x1_h110_b5_d3600_T283(),
    m_flow_nominal=m_flow_nominal,
    dp_nominal=100)
            annotation (Placement(transformation(
        extent={{-13,-13},{13,13}},
        rotation=270,
        origin={27,35})));

equation
  connect(senTem_in.port_b, seg.port_a)
    annotation (Line(points={{0,50},{27,50},{27,48}}, color={0,127,255}));
  connect(senTem_out.port_a, seg.port_b) annotation (Line(points={{0,20},{28,20},
          {28,22},{27,22}}, color={0,127,255}));
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
end SingleBoreHolesInSerie;
