:set ($s->"monitorOnce") do={
	:global MtmFacts;
	:local toolObj [($MtmFacts->"execute") nsStr="getTools()->getRadius()->getClients()"];
	:return [($toolObj->"monitorOnce") |MTMD|];
}