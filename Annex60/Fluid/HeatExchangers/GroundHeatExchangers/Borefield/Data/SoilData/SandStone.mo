within Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.SoilData;
record SandStone
  extends Records.Soil(
    pathMod=
        "Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.SoilData.SandStone",
    pathCom=Modelica.Utilities.Files.loadResource(
        "modelica://Annex60/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/Data/SoilData/SandStone.mo"),
    k=2.8,
    d=540,
    c=1210);

end SandStone;
