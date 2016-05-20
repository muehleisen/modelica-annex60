within Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.Aggregation.BaseClasses;
function nbOfLevelAgg "nbOfLevelAgg returns the number of levels q_max necessary to aggregate the n_max pulses and the number of pulse v_max that the aggregation can contain.
  The size of the different levels increases exponentially."
  extends Modelica.Icons.Function;

  input Integer n_max "Number of load steps to aggregate";
  input Integer p_max "Number of cells by level";
  output Integer q_max "Number of levels";
  output Integer v_max
    "Number of pulses covered by aggregation. This should be higher than n_max";

protected
  Integer i_lev "Iteration variable for the level number";
  parameter Integer nbLevelMax = 100 "Maximum number of aggregation levels";
  parameter Integer[nbLevelMax] celWid = cellWidth(q_max=nbLevelMax)
    "cell width for each levels";
algorithm
  v_max := 0;
  i_lev := 0;

  while v_max < n_max and i_lev < nbLevelMax loop
    v_max := v_max + celWid[i_lev+1]*p_max;
    i_lev := i_lev + 1;
  end while;

  assert(i_lev < nbLevelMax,
    "Too many or zero levels. Increase the number of cells p_max per levels");

  q_max := i_lev;

    annotation (Documentation(info="<html>
    <p>Calculate the number of level necessary to aggregate the whole load and set the value of v_max, q_max and rArr.</p>
</html>", revisions="<html>
<ul>
<li>
July 2014, by Damien Picard:<br>
First implementation.
</li>
</ul>
</html>"));
end nbOfLevelAgg;
