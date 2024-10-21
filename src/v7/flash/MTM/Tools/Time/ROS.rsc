:local cPath "MTM/Tools/Time/ROS.rsc";
:local s [:toarray ""];

:set ($s->"getMiliFromFormat") do={

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
:set ($s->"getGmtOffset") do={

	##src: https://forum.mikrotik.com/viewtopic.php?t=124999
	:local cPath "MTM/Tools/Time/ROS.rsc/getGmtOffset";
	
	:local mVal [/system clock get gmt-offset];
	:if (($mVal ~ "^-[0-9]{0,5}\$") = false && ($mVal ~ "^[0-9]{0,5}\$") = false) do={
		
		:set mVal [:totime ([/system clock get gmt-offset ] - (2147483647 * 2) - 2)];
		:local mIsNeg true;
		:if (($mVal ~ "^-[0-9]{2}:[0-9]{2}:[0-9]{2}\$") = false) do={
			:set mVal [:totime ([/system clock get gmt-offset ])];
			:if (($mVal ~ "^[0-9]{2}:[0-9]{2}:[0-9]{2}\$") = false) do={
				:error ($cPath.": Failed to produce GMT offset '".$mVal."', for timezone '".([/system clock get time-zone-name])."'");
			}
			:set mIsNeg false;
		}
		
		:global MtmToolTime1;
		:local self ($MtmToolTime1->"ros");
		
		:if ($mIsNeg = false) do={
			:return ([($self->"getSecondsFromFormat") [:tostr $mVal] "h:i:s"]);
		} else={
			:return ([($self->"getSecondsFromFormat") [:tostr [:pick $mVal 1 ([:len $mVal] - 1)]] "h:i:s"] * -1);
		}
		
	} else={
		:return $mVal;
	}
}
:set ($s->"getSecondsFromFormat") do={

	:local cPath "MTM/Tools/Time/ROS.rsc/getSecondsFromFormat";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input time has invalid type '".[:typeof $0]."'");
	}
	:if ([:typeof $1] != "str") do={
		:error ($cPath.": Input format has invalid type '".[:typeof $1]."'");
	}
	:local rVal $0;
	:local mVal 0;
	:local pos 0;
	
	:if ($1 = "WDh:i:s") do={
		#e.g. uptime=67w1d18:43:21
		:set pos [:find $rVal "w"];
		:if ([:typeof $pos] = "num") do={
			:set mVal ($mVal + ([:tonum [:pick $rVal 0 $pos]] * 604800));
			:set rVal [:pick $rVal ($pos + 1) [:len $rVal]];
		}
		:set pos [:find $rVal "d"];
		:if ([:typeof $pos] = "num") do={
			:set mVal ($mVal + [:tonum [:pick $rVal 0 $pos]] * 86400);
			:set rVal [:pick $rVal ($pos + 1) [:len $rVal]];
		}
		:set pos [:find $rVal ":"];
		:if ([:typeof $pos] = "num") do={
			:set mVal ($mVal + [:tonum [:pick $rVal 0 $pos]] * 3600);
			:set rVal [:pick $rVal ($pos + 1) [:len $rVal]];
		}
		:set pos [:find $rVal ":"];
		:if ([:typeof $pos] = "num") do={
			:set mVal ($mVal + [:tonum [:pick $rVal 0 $pos]] * 60);
			:set rVal [:pick $rVal ($pos + 1) [:len $rVal]];
		}
		:if ([:len $rVal] = 2) do={
			:set mVal ($mVal + [:tonum $rVal]);
		}
	}
	:if ($1 = "h:i:s") do={
		#uptime=18:43:21
		:set pos [:find $rVal ":"];
		:if ([:typeof $pos] = "num") do={
			:if ($pos != 2) do={
				:set rVal [:pick $rVal ($pos - 2) [:len $rVal]];
			}
			
			:set mVal ($mVal + [:tonum [:pick $rVal 0 $pos]] * 3600);
			:set rVal [:pick $rVal ($pos + 1) [:len $rVal]];
		}
		:set pos [:find $rVal ":"];
		:if ([:typeof $pos] = "num") do={
			:set mVal ($mVal + [:tonum [:pick $rVal 0 $pos]] * 60);
			:set rVal [:pick $rVal ($pos + 1) [:len $rVal]];
		}
		:if ([:len $rVal] = 2) do={
			:set mVal ($mVal + [:tonum $rVal]);
		}
	}
	:if (($mVal ~ "^[0-9]+\$") = true) do={
		:return $mVal;
	} else={
		:error ($cPath.": Failed to produce valid return '".$mVal."' from input time: '".$0."' and format: '".$1."'");
	}
}
:set ($s->"getCurrentHour") do={

	:local cPath "MTM/Tools/Time/ROS.rsc/getCurrentHour";
	:return [:tonum [:pick [/system clock get time] 0 2]];
}
:global MtmToolTime1;
:set ($MtmToolTime1->"ros") $s;