within Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.BorefieldData;
record BorefieldDataTrtUTube =
                          Records.BorefieldData (
    pathMod = "Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.BorefieldData.BorefieldDataTrtUTube",
    pathCom = Modelica.Utilities.Files.loadResource("modelica://Annex60/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/Data/BorefieldData/BorefieldDataTrtUTube.mo"),
    redeclare replaceable record Soi =
        SoilData.SoilTrt,
    redeclare replaceable record Fil =
        FillingData.FillingTrt,
    redeclare replaceable record Gen =
        GeneralData.GeneralTrtUTube)
  "BorefieldData record for bore field validation using thermal response test";
