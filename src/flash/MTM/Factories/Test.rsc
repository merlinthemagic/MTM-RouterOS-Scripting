:if ([:len [/system script environment find]] > 0) do={
	/system script environment remove [ find ];
}
/import flash/MTM/Facts.rsc;
:global MtmFacts;

:local result [($MtmFacts->"execute") nsStr="getTools()->getTime()->getEpoch()->getCurrent()"];
:put ("Current Epoch: ".$result); #epoch time