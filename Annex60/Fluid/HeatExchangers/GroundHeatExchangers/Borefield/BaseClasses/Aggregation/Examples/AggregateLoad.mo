within Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.Aggregation.Examples;
model AggregateLoad
  "Test for the function aggregateLoad, cellWidth, nbOfLevelAgg, nbPulseAtEndEachLevel and previousCellIndex."
  extends Modelica.Icons.Example;
  parameter Integer n_max=14 "Number of load steps to aggregate";
  parameter Integer p_max=2 "Number of cells by level";
  parameter Integer q_max=BaseClasses.nbOfLevelAgg(n_max, p_max) "Number of levels";
  discrete Modelica.SIunits.Power QNew "New load element";
  discrete Modelica.SIunits.Power[q_max,p_max] QAgg(start=fill(
        0,
        q_max,
        p_max)) "Aggregated load matrix form the previous time step";
  parameter Integer[q_max] rArr=BaseClasses.cellWidth(q_max);
  parameter Integer[q_max,p_max] nuMat=BaseClasses.nbPulseAtEndEachLevel(
      q_max,
      p_max,
      rArr);
  Modelica.Blocks.Sources.Cosine cos(freqHz=0.1)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
algorithm
  when sample(0, 1) then
    QNew := cos.y;
    QAgg := Aggregation.aggregateLoad(
      q_max=q_max,
      p_max=p_max,
      rArr=rArr,
      nuMat=nuMat,
      QNew=QNew,
      QAggOld=pre(QAgg));
  end when;
  annotation (
    Documentation(info="<html>
<p>
This functions tests
<a href=\"modelica://Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.Aggregation.aggregateLoad\">
Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.Aggregation.aggregateLoad</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
July 2014, by Damien Picard:<br>
First implementation.
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    experiment(StopTime=10),
    __Dymola_experimentSetupOutput,
    __Dymola_Commands(file="Resources/Scripts/Dymola/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/BaseClasses/Aggregation/Examples/AggregateLoad.mos"
        "simulate and plot"));
end AggregateLoad;
