:global MtmFacts;
#:set MtmFacts;

/import flash/MTM/Facts.rsc;
:global MtmFacts;

[($MtmFacts->"setDebug") true];

##remove specific tool from cache
#:local sysId "tool-time-epoch";
#:local objFact [($MtmFacts->"getObjects")];
#:local sObj [($objFact->"getStore") $sysId];
#:set ($sObj->"obj"->($sObj->"hash"));

#:local result [($MtmFacts->"get") "getTools()->getTime()->getEpoch()->getCurrent()"];
#:put ("Current Epoch: ".$result); #epoch time

