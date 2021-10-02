:local classId "tool-time-ros";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmT3;
:if (($MtmT3->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"fromSecondsV1") do={
		
		## returns in format "86d 05:10:44". if no days then only "05:10:44".
		## this method does not return weeks. used for e.g. dhcp-server lease-time
		:global MtmFacts;
		:local method "Tools->Time->ROS->fromSecondsV1";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Seconds are mandatory"];
		}
		:local rData "";
		:local rSecs $0;
		:local count 0;
		:if ($rSecs > 86400) do={
			:set count ($rSecs / 86400);
			:set rData ($rData.$count."d ");
			:set rSecs ($rSecs % 86400);
		}
		:if ($rSecs > 3600) do={
			:set count ($rSecs / 3600);
			:if ($count < 10) do={
				:set count ("0".$count);
			}
			:set rData ($rData.$count.":");
			:set rSecs ($rSecs % 3600);
		} else={
			:set rData ($rData."00:");
		}
		:if ($rSecs > 60) do={
			:set count ($rSecs / 60);
			:if ($count < 10) do={
				:set count ("0".$count);
			}
			:set rData ($rData.$count.":");
			:set rSecs ($rSecs % 60);
		} else={
			:set rData ($rData."00:");
		}
		
		:set count $rSecs;
		:if ($count < 10) do={
			:set count ("0".$count);
		}
		:set rData ($rData.$count);
		
		:return $rData;
	}
	:set ($s->"toMsV1") do={
		
		## returns in format "1340". if input is "1s340ms".
		## used for converting radis rtt
		:global MtmFacts;
		:local method "Tools->Time->ROS->toMsV1";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Input is mandatory"];
		}

		:local count 0;
		:local pos;
		:local val;
		:local rVal $0;
		:set pos [:find $rVal "s"];
		:if ([:typeof $pos] = "num") do={
			:set val [:pick $rVal ($pos - 1)];
			:if ($val != "m") do={
				##the input has seconds
				:set val ([:pick $rVal 0 $pos] * 1000);
				:set rVal [:pick $rVal ($pos + 1) [:len $rVal]];
				:set count ($count + $val);
			}
		}
		:set pos [:find $rVal "ms"];
		:if ([:typeof $pos] = "num") do={
			##the input has milisecs
			:set val [:pick $rVal 0 $pos];
			:set rVal [:pick $rVal ($pos + 1) [:len $rVal]];
			:set count ($count + $val);
		}
		:return $count;
	}
	:set ($MtmT3->$classId) $s;
}
