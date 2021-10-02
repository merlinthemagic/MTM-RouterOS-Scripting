:global MtmFacts;
:set MtmFacts;
/import flash/MTM/Facts.rsc;

:local nsStr "getTools()->getTime()->getEpoch()->getCurrent()";
:local result [($MtmFacts->"execute") nsStr=$nsStr];
:put ("Current Epoch: ".$result); #epoch time