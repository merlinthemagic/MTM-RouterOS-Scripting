:set ($s->"getPrimitives") do={
	:global MtmFacts;
	:local sysId "tool-parsing-primis";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Tools/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Tools/Parsing/Primitives/Part1.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Tools/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}
:set ($s->"getDateTime") do={
	:global MtmFacts;
	:local sysId "tool-parsing-date-time";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Tools/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Tools/Parsing/DateTime/Part1.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Tools/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}
:set ($s->"getIPv4") do={
	:global MtmFacts;
	:local sysId "tool-parsing-ipv4";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Tools/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Tools/Parsing/IPv4/Part1.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Tools/Parsing/IPv4/Part2.rsc");
		:set ($paths->3) ([($MtmFacts->"getMtmPath")]."Tools/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}
:set ($s->"getIPv6") do={
	:global MtmFacts;
	:local sysId "tool-parsing-date-time";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Tools/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Tools/Parsing/IPv6/Part1.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Tools/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}
:set ($s->"getJsonEncode") do={
	:global MtmFacts;
	:local sysId "tool-parsing-json-enc";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Tools/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Tools/Parsing/JsonEncode/Part1.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Tools/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}
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