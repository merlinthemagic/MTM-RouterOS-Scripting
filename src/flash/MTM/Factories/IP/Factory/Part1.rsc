:set ($s->"getAddresses") do={
	:global MtmFacts;
	:local sysId "fact-ip-addrs";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Factories/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Factories/IP/Addresses.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Factories/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}
:set ($s->"getDhcpServers") do={
	:global MtmFacts;
	:local sysId "fact-ip-dhcp-servers";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Factories/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Factories/IP/DhcpServers.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Factories/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}
:set ($s->"getDhcpClients") do={
	:global MtmFacts;
	:local sysId "fact-ip-dhcp-clients";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Factories/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Factories/IP/DhcpClients.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Factories/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}