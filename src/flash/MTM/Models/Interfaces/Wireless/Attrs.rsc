:set ($s->"monitorOnce") do={
	:global MtmFacts;
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local toolObj [($MtmFacts->"execute") nsStr="getTools()->getInterfaces()->getWireless()"];
	:return [($toolObj->"monitorOnce") [($self->"getName")]];
}
:set ($s->"scanOnce") do={
	:global MtmFacts;
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local toolObj [($MtmFacts->"execute") nsStr="getTools()->getInterfaces()->getWireless()"];
	:return [($toolObj->"scanOnce") [($self->"getName")]];
}