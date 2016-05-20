within Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.Records;
record Soil "Thermal properties of the ground"
  extends Annex60.HeatTransfer.Data.Soil.Generic;
  parameter String pathMod=
      "Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.Records.Soil"
    "Modelica path of the record";
  parameter String pathCom=Modelica.Utilities.Files.loadResource(
      "modelica://Annex60/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/Data/Records/Soil.mo")
    "Computer path of the record";
  final parameter Modelica.SIunits.DiffusionCoefficient alp=k/d/c;
  annotation (Documentation(info="<html>
  <p>Thermal properties of the ground and record path.</p>
</html>", revisions="<html>
<ul>
<li>
July 2014, by Damien Picard:<br>
First implementation.
</li>
</ul>
</html>"));
end Soil;
