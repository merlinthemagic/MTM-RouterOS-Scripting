:local classId "fact-system-os";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmS;
:if (($MtmS->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getVersion") do={
		:return [/system package get [find name=system] version];
	}
	:set ($s->"getMajorVersion") do={
		:local var [/system package get [find name=system] version];
		:return ([:pick $var 0 [:find $var "."]]);
	}
	:set ($s->"getMinorVersion") do={
		:local var [/system package get [find name=system] version];
		:set var [:pick $var ([:find $var "."] + 1) [:len $var]];
		:return ([:pick $var 0 [:find $var "."]]);
	}
	:set ($s->"getPatchVersion") do={
		:local var [/system package get [find name=system] version];
		:set var [:pick $var ([:find $var "."] + 1) [:len $var]];
		:return ([:pick $var ([:find $var "."] + 1) [:len $var]]);
	}
	:set ($MtmS->$classId) $s;
}
