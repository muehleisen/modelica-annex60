within Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Examples;
model Borefield8x8_accurate
  "Model of a borefield in a 8x8 boreholes square configuration and a constant heat injection rate"
  extends
    Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Examples.Borefield8x1
    (                                                                                      redeclare
      Data.BorefieldData.SandStone_Bentonite_c8x8_h110_b5_d600_T283                                                                                                bfData);
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end Borefield8x8_accurate;
