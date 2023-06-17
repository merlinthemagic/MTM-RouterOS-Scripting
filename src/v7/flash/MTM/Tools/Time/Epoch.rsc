:local cPath "MTM/Tools/Time/Epoch.rsc";
:local s [:toarray ""];
:set ($s->"getCurrent") do={

	:local cPath "MTM/Tools/Time/Epoch.rsc/getCurrent";
	:global MtmFacts;
	:global MtmToolTime1;
	:local self ($MtmToolTime1->"epoch");
	:local format "";
	:if ([($MtmFacts->"getEnv") "minor"] > 9) do={
		:set format "Y-m-d H:i:s";
	} else={
		:set format "m/d/Y h:i:s";
	}
	:return [($self->"getFromFormat") [:tostr ([/system clock get date]." ".[/system clock get time])] $format];
}
:set ($s->"getFromFormat") do={

	:global MtmFacts;
	:local cPath "MTM/Tools/Time/Epoch.rsc/getCurrent";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input time has invalid type '".[:typeof $0]."'");
	}
	:if ([:typeof $1] != "str") do={
		:error ($cPath.": Input format has invalid type '".[:typeof $1]."'");
	}
	
	:local mVal "";
	:local mYear 0;
	:local mMonth 0;
	:local mDay 0;
	:local mHour 0;
	:local mMin 0;
	:local mSec 0;

	:if ($1 = "Y-m-d H:i:s") do={
		#date format starting 7.10
		:set mYear [:tonum [:pick $0 0 4]];
		:set mMonth [:tonum [:pick $0 5 7]];
		:set mDay [:tonum [:pick $0 8 10]];
		:set mHour [:tonum [:pick $0 11 13]];
		:set mMin [:tonum [:pick $0 14 16]];
		:set mSec [:tonum [:pick $0 17 19]];
	} else={
		:if ($1 = "m/d/Y h:i:s") do={
			##pre 7.10 default date format
			:set mVal {"jan"=1;"feb"=2;"mar"=3;"apr"=4;"may"=5;"jun"=6;"jul"=7;"aug"=8;"sep"=9;"oct"=10;"nov"=11;"dec"=12}
			:set mYear [:tonum [:pick $0 7 11]];
			:set mMonth [:tonum ($mVal->([:pick $0 0 3]))];
			:set mDay [:tonum [:pick $0 8 10]];
			:set mHour [:tonum [:pick $0 11 13]];
			:set mMin [:tonum [:pick $0 14 16]];
			:set mSec [:tonum [:pick $0 17 19]];
		}
	}

	:if ($mYear < 2000) do={
		:error ($cPath.": Cannot handle dates before the year 2000");
	}
	
	#days elapsed since beginning of year at start of month
	:set mVal {"1"=0;"2"=31;"3"=60;"4"=91;"5"=121;"6"=152;"7"=182;"8"=213;"9"=244;"10"=274;"11"=305;"12"=335}
	:local d ($mVal->([:tostr $mMonth]));
	:if ($mMonth > 2 && (($mYear - 1) / 4) = ($mYear / 4)) do={
		##its past feb in a non leap year, so feb only had 28 days
		:set d ($d - 1);
	}
	#add up all the days, including leap days
	:set d ($d + ($mYear * 365) + (($mYear - 1) / 4) + $mDay);
	#convert to seconds
	:set d ($d * 24 * 60 * 60);
	#add the hours, min and secs
	:set d ($d + ($mHour * 60 * 60) + ($mMin * 60) + $mSec);
	#subtract seconds from 0 - 1970 (including leap years)
	:set d ($d - 62168515200);
	#subtract the offset to gmt for our timezone
	:set d ($d - ([($MtmFacts->"get") "getTools()->getTime()->getRos()->getGmtOffset()"]));
	:if ($d > 946684799) do={
		##Epoch greater than the year 2000, cool!
		:return $d;
	}
	:error ($cPath.": Failed to produce valid epoch '".$d."' from input time: '".$0."' and format: '".$1."'");
}

:global MtmToolTime1;
:set ($MtmToolTime1->"epoch") $s;