:local s [:toarray ""];
:set ($s->"getId") do={
	:return "|MTMD|";
}
:set ($s->"getInterfaceName") do={
	:return [/interface dot1x server get "|MTMD|" interface];
}
:set ($s->"isInterfaceList") do={
	:global MtmFacts;
	:global MtmO;
	:local self ($MtmO->"|MTMC|");
	:if ([/interface list find where name=[($self->"getInterfaceName")]] != "") do={
		:return true;
	} else={
		:return false;
	}
}