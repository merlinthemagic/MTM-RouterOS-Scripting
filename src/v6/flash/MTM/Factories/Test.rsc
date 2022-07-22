:if (
[:len [/system script environment find]] > 0) do={
	#/system script environment remove [ find ];
}
/import flash/MTM/Facts.rsc;
:global MtmFacts;

##remove specific tool from cache
:local sysId "tool-time-epoch";
:local objFact [($MtmFacts->"getObjects")];
:local sObj [($objFact->"getStore") $sysId];
#:set ($sObj->"obj"->($sObj->"hash"));

:local result [($MtmFacts->"execute") nsStr="getTools()->getTime()->getEpoch()->getCurrent()"];
:put ("Current Epoch: ".$result); #epoch time