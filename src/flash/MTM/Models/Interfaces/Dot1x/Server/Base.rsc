:set ($s->"getInterfaceName") do={
	:return [/interface dot1x server get "|MTMD|" interface];
}
:set ($s->"isInterfaceList") do={
	:global MtmFacts;
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:if ([/interface list find where name=[($self->"getInterfaceName")]] != "") do={
		:return true;
	} else={
		:return false;
	}
}