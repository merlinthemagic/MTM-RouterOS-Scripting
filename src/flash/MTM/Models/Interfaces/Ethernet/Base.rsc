:set ($s->"isAutoNegotiating") do={
	:return [/interface ethernet get |MTMD| auto-negotiation];
}
:set ($s->"getLinkSpeed") do={
	:return [/interface ethernet get |MTMD| speed];
}
:set ($s->"getDot1xServerStateStatus") do={
	:global MtmFacts;
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local id [/interface dot1x server state find interface=[($self->"getName")]];
	:if ([:len $id] > 0) do={
		:return [/interface dot1x server state get ($id->0) status ];
	} else={
		:return [($MtmFacts->"getNull")];
	}
}
:set ($s->"getLastLinkDownTime") do={
	:global MtmFacts;
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local toolObj [($MtmFacts->"execute") nsStr="getTools()->getInterfaces()->getCommon()"];
	:return [($toolObj->"getLastLinkDownTime") [($self->"getName")]];
}
:set ($s->"getLastLinkUpTime") do={
	:global MtmFacts;
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local toolObj [($MtmFacts->"execute") nsStr="getTools()->getInterfaces()->getCommon()"];
	:return [($toolObj->"getLastLinkUpTime") [($self->"getName")]];
}