:local cPath "MTM/Tools/Interfaces/Wlans.rsc";
:local s [:toarray ""];

:set ($s->"getAntennaGain") do={
	:local cPath "MTM/Tools/Interfaces/Wlans.rsc/getAntennaGain";
	:if ([:typeof $0] != "id") do={
		:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
	}
	:return [:tonum [/interface wireless get $0 antenna-gain]];
}

:global MtmToolIfs1;
:set ($MtmToolIfs1->"wlans") $s;