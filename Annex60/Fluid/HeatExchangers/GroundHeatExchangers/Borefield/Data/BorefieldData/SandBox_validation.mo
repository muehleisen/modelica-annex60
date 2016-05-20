within Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.BorefieldData;
record SandBox_validation=Records.BorefieldData (
    pathMod = "Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.BorefieldData.SandBox_validation",
    pathCom = Modelica.Utilities.Files.loadResource("modelica://Annex60/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/Data/BorefieldData/SandBox_validation.mo"),
    redeclare replaceable record Soi =
       Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.SoilData.WetSand_validation,
    redeclare replaceable record Fil =
        Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.FillingData.Bentonite_validation,
    redeclare replaceable record Gen =
        Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.GeneralData.SandBox_validation)
  "BorefieldData record for bore field validation using thermal response test";
