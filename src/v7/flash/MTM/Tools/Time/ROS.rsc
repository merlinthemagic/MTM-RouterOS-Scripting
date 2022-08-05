:local cPath "MTM/Tools/Time/ROS.rsc";
:local s [:toarray ""];

:set ($s->"getMiliFromFormat") do={

	:global MtmFacts;
	:local cPath "MTM/Tools/Time/ROS.rsc/getMiliFromFormat";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input time has invalid type '".[:typeof $0]."'");
	}
	:if ([:typeof $1] != "str") do={
		:error ($cPath.": Input format has invalid type '".[:typeof $1]."'");
	}
	:local rd 0;
	:local ilen [:len $0];
	:if ($1 = "h:i:s.u") do={
		:if ($ilen > 1) do={
			:set rd ($rd + [:tonum [:pick $0 0 2]] * 3600 * 1000);
		}
		:if ($ilen > 4) do={
			:set rd ($rd + [:tonum [:pick $0 3 5]] * 60 * 1000);
		}
		:if ($ilen > 7) do={
			:set rd ($rd + [:tonum [:pick $0 6 8]] * 1000);
		}
		:if ($ilen > 11) do={
			:set rd ($rd + [:tonum [:pick $0 9 12]]);
		}
		:return $rd;
	}
	:error ($cPath.": Failed to produce valid time '".$rd."' from input time: '".$0."' and format: '".$1."'");
}
:global MtmToolTime1;
:set ($MtmToolTime1->"ros") $s;