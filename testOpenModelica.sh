# Run this file from a directory that contains the Annex60 directory.

##export OPENMODELICALIBRARY=`pwd`:/usr/local/Modelica/Library:/usr/lib/omlibrary:/home/mwetter/proj/ldrd/bie/modeling/github/lbl-srg/modelica-buildings
export OPENMODELICALIBRARY=`pwd`:/usr/lib/omlibrary
# 9/10/13. removed flag: omc +d=scodeInstShortcut openmod.mos
#omc +d=initialization +maxMixedDeterminedIndex=4 openmod.mos
omc +d=nogen,initialization,backenddaeinfo,discreteinfo,stateselection openmod.mos
