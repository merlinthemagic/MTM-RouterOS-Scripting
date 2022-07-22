:set ($s->"getInterfaceName") do={
	:return [/ip dhcp-client get |MTMD| interface];
}
:set ($s->"getScript") do={
	:return [/ip dhcp-client get |MTMD| script];
}
:set ($s->"setScript") do={
	:local value "";
	:if ($0 != nil) do={
		:set value $0;
	}
	/ip dhcp-client set |MTMD| script=$value;
	:return true;
}
:set ($s->"getAddress") do={
	:local addr [/ip dhcp-client get |MTMD| address];
	:if ([:typeof $addr] = "str") do={
		:global MtmFacts;
		:local toolObj [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getIPv4()"];
		:return [($toolObj->"getAddress") $addr];
	}
	:return $addr;
}
:set ($s->"getCidr") do={
	:local addr [/ip dhcp-client get |MTMD| address];
	:if ([:typeof $addr] = "str") do={
		:global MtmFacts;
		:local toolObj [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getIPv4()"];
		:return [($toolObj->"getCidr") $addr];
	}
	:return $addr;
}
:set ($s->"getGateway") do={
	:return [/ip dhcp-client get |MTMD| gateway];
}
:set ($s->"getServer") do={
	:return [/ip dhcp-client get |MTMD| dhcp-server];
}