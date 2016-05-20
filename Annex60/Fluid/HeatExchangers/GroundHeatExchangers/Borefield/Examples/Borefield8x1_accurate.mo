within Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Examples;
model Borefield8x1_accurate
  "Model of a borefield in a 8x1 boreholes line configuration and a constant heat injection rate"
  extends
    Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Examples.Borefield8x1
    ( redeclare
      Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.BorefieldData.SandStone_Bentonite_c8x1_h110_b5_d600_T283
                                                                                                          bfData);
end Borefield8x1_accurate;
