:set ($s->"getValues") do={
	:global MtmFacts;
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local toolObj [($MtmFacts->"execute") nsStr="getTools()->getInterfaces()->getEthernet()"];
	:return [($toolObj->"getAttributes") [($self->"getName")]];
}
:set ($s->"monitorOnce") do={
	:global MtmFacts;
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local toolObj [($MtmFacts->"execute") nsStr="getTools()->getInterfaces()->getEthernet()"];
	:return [($toolObj->"monitorOnce") [($self->"getName")]];
}
:set ($s->"monitorPoeOnce") do={
	:global MtmFacts;
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local toolObj [($MtmFacts->"execute") nsStr="getTools()->getInterfaces()->getEthernet()"];
	:return [($toolObj->"monitorPoeOnce") [($self->"getName")]];
}