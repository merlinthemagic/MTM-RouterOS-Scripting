:local classId "tool-routing-ipv4";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:if (($MtmFacts->"c"->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getActiveGatewayAddress") do={
		:return [/ip route get [find dst-address="0.0.0.0/0" && active=yes && routing-mark=[:nothing]] gateway];
	}
	:set ($MtmFacts->"c"->$classId) $s;
}
