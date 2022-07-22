:set ($s->"getApnProfileNames") do={
	:return [/interface lte get |MTMD| apn-profiles];
}
:set ($s->"getInfo") do={
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local toolObj [($MtmFacts->"execute") nsStr=("getTools()->getInterfaces()->getLTE()")];
	:return [($toolObj->"infoOnce") ([($self->"getName")])];
}
