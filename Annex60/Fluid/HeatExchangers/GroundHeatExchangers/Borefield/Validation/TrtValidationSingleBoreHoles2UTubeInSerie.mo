within Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Validation;
model TrtValidationSingleBoreHoles2UTubeInSerie
  import Annex60;
  extends
    Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.BoreHoles.Examples.SingleBoreHole2UTubeSerStepLoadScript(
    redeclare
      Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.SoilData.SoilTrt
      soi,
    redeclare
      Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.FillingData.FillingTrt
      fil(k=2.5),
    redeclare
      Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.GeneralData.GeneralTrt2UTube
      gen);
end TrtValidationSingleBoreHoles2UTubeInSerie;
