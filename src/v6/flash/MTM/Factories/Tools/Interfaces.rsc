:set ($s->"getEthernet") do={
	:global MtmFacts;
	:local sysId "tool-ifs-eth";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Tools/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Tools/Interfaces/Common/Part1.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Tools/Interfaces/Ethernet/Part1.rsc");
		:set ($paths->3) ([($MtmFacts->"getMtmPath")]."Tools/Interfaces/Ethernet/Part2.rsc");
		:set ($paths->4) ([($MtmFacts->"getMtmPath")]."Tools/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}
:set ($s->"getWireless") do={
	:global MtmFacts;
	:local sysId "tool-ifs-wlan";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Tools/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Tools/Interfaces/Common/Part1.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Tools/Interfaces/Wireless/Part1.rsc");
		:set ($paths->3) ([($MtmFacts->"getMtmPath")]."Tools/Interfaces/Wireless/Part2.rsc");
		:set ($paths->4) ([($MtmFacts->"getMtmPath")]."Tools/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}
:set ($s->"getBridge") do={
	:global MtmFacts;
	:local sysId "tool-ifs-brd";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Tools/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Tools/Interfaces/Common/Part1.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Tools/Interfaces/Bridge/Part1.rsc");
		:set ($paths->3) ([($MtmFacts->"getMtmPath")]."Tools/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}
:set ($s->"getLTE") do={
	:global MtmFacts;
	:local sysId "tool-ifs-lte";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Tools/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Tools/Interfaces/Common/Part1.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Tools/Interfaces/LTE/Part1.rsc");
		:set ($paths->3) ([($MtmFacts->"getMtmPath")]."Tools/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}