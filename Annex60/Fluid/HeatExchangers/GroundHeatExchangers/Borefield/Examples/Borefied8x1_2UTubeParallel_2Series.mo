within Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Examples;
model Borefied8x1_2UTubeParallel_2Series
  extends
    Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Examples.Borefield8x1
    ( redeclare
      Data.BorefieldData.SandStone_Bentonite_c8x1_h110_b5_d600_T283_2UTubeParallel_2Series
                                                                                                          bfData,
      redeclare MultipleBoreHoles2UTube borFie(dp_nominal=1000, dynFil=false));
  annotation (experiment(StopTime=3.1536e+007), __Dymola_experimentSetupOutput(
        events=false));
end Borefied8x1_2UTubeParallel_2Series;
