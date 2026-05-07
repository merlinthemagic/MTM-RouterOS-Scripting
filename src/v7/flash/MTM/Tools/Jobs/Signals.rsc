:local cPath "MTM/Tools/Jobs/Signals.rsc";
:local s [:toarray ""];
:set ($s->"sigint") do={

	:local cPath "MTM/Tools/Jobs/Signals.rsc/sigint";
	:if ([:typeof $0] != "id") do={
		:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
	}
	:local mVal [/system/script/job/get $0 type];
	:if ([:typeof $mVal] != "nil") do={
		:set mVal [/system/script/job/remove $0];
		:set mVal [/system/script/job/get $0 type];
		:if ([:typeof $mVal] = "nil") do={
			:return true;
		} else={
			:error ($cPath.": Failed to Sigint job");
		}
	} else={
		:error ($cPath.": Job does not exist");
	}
}

:global MtmToolJobs1;
:set ($MtmToolJobs1->"signal") $s;