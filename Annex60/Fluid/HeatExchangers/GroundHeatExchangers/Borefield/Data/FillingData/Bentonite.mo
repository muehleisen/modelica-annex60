within Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.FillingData;
record Bentonite
  extends Records.Filling(
    pathMod=
        "Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.FillingData.Bentonite",
    pathCom=Modelica.Utilities.Files.loadResource(
        "modelica://Annex60/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/Data/FillingData/Bentonite.mo"),
    k=1.15,
    d=1600,
    c=800);

end Bentonite;
