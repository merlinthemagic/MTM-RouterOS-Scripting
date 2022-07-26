:local cPath "MTM/Tools/Jobs/Status.rsc";
:local s [:toarray ""];
:set ($s->"getRunning") do={

	:local cPath "MTM/Tools/Jobs/Status.rsc/getRunning";
	:if ([:typeof $0] != "id") do={
		:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
	}
	:local mVal [/system script job get $0 type];
	:if ([:typeof $mVal] = "nil") do={
		:return false;
	} else={
		:return true;
	}
}

:global MtmToolJobs1;
:set ($MtmToolJobs1->"status") $s;