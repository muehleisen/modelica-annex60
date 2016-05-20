within Annex60.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.GroundHX.BaseClasses.Examples;
model IntegrandBf_bt "Test for the integrand function"
  extends Modelica.Icons.Example;

  parameter Integer lim=5;
  Real int;
  Real lb;

algorithm
  lb :=1/sqrt(4*(4.2*10^(-6))*(time + 1000));
  if time < 0.00785 then
    int :=0;
  else
    int :=BaseClasses.integrandBf_bt(
      D=100,
      rBor=0.1,
      u=time*lim,
      nbBh=2,
      cooBh={{0,0},{1,1}});
  end if;

  annotation (experiment(
      __Dymola_NumberOfIntervals=100,
      Tolerance=1e-005,
      __Dymola_Algorithm="Dassl"), __Dymola_experimentSetupOutput, Documentation(info="<html>
        <p>Test implementation of IntegrandBf_bt function.</p>
</html>", revisions="<html>
<ul>
<li>
July 2014, by Damien Picard:<br>
First implementation.
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/BaseClasses/GroundHX/BaseClasses/Examples/IntegrandBf_bt.mos"
        "simulate and plot"));
end IntegrandBf_bt;
