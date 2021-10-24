:set ($s->"getMonitorData") do={
	:global MtmFacts;
	:local sysId "tool-parsing-mon-data";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Tools/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Tools/Parsing/MonitorData/Part1.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Tools/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}
:set ($s->"getPing") do={
	:global MtmFacts;
	:local sysId "tool-parsing-ping";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Tools/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Tools/Parsing/Ping/Part1.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Tools/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}
:set ($s->"getWlanScan") do={
	:global MtmFacts;
	:local sysId "tool-parsing-wlan-scan";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Tools/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Tools/Parsing/WlanScan/Part1.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Tools/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}