:local cPath "MTM/Tools/Time/Epoch.rsc";
:local s [:toarray ""];
:set ($s->"getCurrent") do={

	:local cPath "MTM/Tools/Time/Epoch.rsc/getCurrent";
	:global MtmToolTime1;
	:local self ($MtmToolTime1->"epoch");
	:return [($self->"getFromFormat") [:tostr ([/system clock get date]." ".[/system clock get time])] "m/d/Y h:i:s"];
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
	:local d "";
	
	:if ($1 = "m/d/Y h:i:s") do={
		#Logic stolen from: https://forum.mikrotik.com/viewtopic.php?t=75555
		
		:if ([:pick $0 7 11] < 2000) do={
			:error ($cPath.": Cannot handle dates before the year 2000");
		}
		:local m [:pick $0 0 3];
		#days elapsed since beginning of year at start of month
		:set d {"jan"=0;"feb"=31;"mar"=60;"apr"=91;"may"=121;"jun"=152;"jul"=182;"aug"=213;"sep"=244;"oct"=274;"nov"=305;"dec"=335}
		:set d ($d->$m);
		:if (($m != "jan" && $m != "feb") && (([:pick $0 9 11] - 1) / 4) = ([:pick $0 9 11] / 4)) do={
			##its past feb in a non leap year, so feb only had 28 days
			:set d ($d - 1);
		}
		#add up all the days
		:set d ($d + ([:pick $0 9 11] * 365) + (([:pick $0 9 11] - 1) / 4) +[:pick $0 4 6]);
		#convert to seconds
		:set d ($d * 24 * 60 * 60);
		#add the hours, min and secs
		:set d ($d + ([:pick $0 12 14] * 60 * 60) + ([:pick $0 15 17] * 60) + [:pick $0 18 20]);
		#add jan 1st 2000 in unix, and subtract the offset to gmt for our timezone
		:set d ($d + 946684800 - ([($MtmFacts->"get") "getTools()->getTime()->getRos()->getGmtOffset()"]));
		:if ($d > 946684799) do={
			##Epoch greater than the year 2000, cool!
			:return $d;
		}
	}
	:error ($cPath.": Failed to produce valid epoch '".$d."' from input time: '".$0."' and format: '".$1."'");
}

:global MtmToolTime1;
:set ($MtmToolTime1->"epoch") $s;