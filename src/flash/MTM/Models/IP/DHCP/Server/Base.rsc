:set ($s->"getName") do={
	:return [/ip dhcp-server get |MTMD| name];
}
:set ($s->"getRadiusUse") do={
	:return [/ip dhcp-server get |MTMD| use-radius];
}
:set ($s->"setRadiusUse") do={
	:if ($0 != "no" && $0 != "yes" && $0 != "accounting") do={
		:global MtmFacts;
		:local method "Models->IP->DHCP->Server->setRadiusUse";
		[($MtmFacts->"throwException") method=$method msg="Invalid input"];
	}
	/ip dhcp-server set |MTMD| use-radius=$0;
	:return true;
}
:set ($s->"getLeaseScript") do={
	:return [/ip dhcp-server get |MTMD| lease-script];
}
:set ($s->"setLeaseScript") do={
	:local value "";
	:if ($0 != nil) do={
		:set value $0;
	}
	/ip dhcp-server set |MTMD| lease-script=$value;
	:return true;
}
:set ($s->"getBootpSupport") do={
	:local val [/ip dhcp-server get |MTMD| bootp-support];
	:if ([:typeof $val] = "nil") do={
		:set val "static"; ##seems to be a bug on 6.48.4 powerpc at least
	}
	:return $val;
}
:set ($s->"setBootpSupport") do={
	:if ($0 != "dynamic" && $0 != "none" && $0 != "static") do={
		:global MtmFacts;
		:local method "Models->IP->DHCP->Server->setBootpSupport";
		[($MtmFacts->"throwException") method=$method msg="Invalid input"];
	}
	/ip dhcp-server set |MTMD| bootp-support=$0;
	:return true;
}
:set ($s->"getAuthoritative") do={
	:return [/ip dhcp-server get |MTMD| authoritative];
}
:set ($s->"setAuthoritative") do={
	:if ($0 != "after-2sec-delay" && $0 != "after-10sec-delay" && $0 != "no" && $0 != "yes") do={
		:global MtmFacts;
		:local method "Models->IP->DHCP->Server->setAuthoritative";
		[($MtmFacts->"throwException") method=$method msg="Invalid input"];
	}
	/ip dhcp-server set |MTMD| authoritative=$0;
	:return true;
}
:set ($s->"getLeaseTime") do={
	:return [/ip dhcp-server get |MTMD| lease-time];
}
:set ($s->"setLeaseTime") do={
	:global MtmFacts;
	:if ($0 = nil) do={
		:local method "Models->IP->DHCP->Server->setLeaseTime";
		[($MtmFacts->"throwException") method=$method msg="Invalid input"];
	}
	:local toolObj [($MtmFacts->"execute") nsStr="getTools()->getTime()->getRos()"];
	/ip dhcp-server set |MTMD| lease-time=([($toolObj->"fromSecondsV1") $0]);
	:return true;
}