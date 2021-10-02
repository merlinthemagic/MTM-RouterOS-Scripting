:local classId "tool-parsing-monitor-data";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmT;
:if (($MtmT->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"a") [:toarray ""];
	:set ($s->"c") [:toarray ""];
	
	:set ($s->"getV1") do={

		:global MtmFacts;
		:local method "Tools->Parsing->MonitorData->getV1";
		:local param1;
		:if ($0 != nil) do={
			:set param1 $0;
		} else={
			:if ($data != nil) do={
				:set param1 $data;
			} else={
				[($MtmFacts->"throwException") method=$method msg="Data is mandatory"];
			}
		}
		
		:local nsStr "getTools()->getStrings()";
		:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];
		
		:local lineBreak "\n";
		:local lines [($toolObj->"split") str=$param1 delimitor=$lineBreak];
		
		:local rData [:toarray ""];
		:local rLine "";
		:local rLen;
		:local pos;
		:local var1;
		:local var2;
		:local var3;
		
		:foreach line in=$lines do={
			:set rLine [($toolObj->"trim") str=$line ];
			:set var1 [:pick $rLine 0];
			:if ($var1 != "#" && $var1 != ";") do={
				:set pos [:find $rLine ": "];
				:if ([:typeof $pos] = "num") do={
					:set rLen [:len $rLine];
					:set $var3 [:pick $rLine 0 $pos]
					:set $var2 [:pick $rLine ($pos + 2) $rLen];
					:set rLen [:len $var2];
					:set var1 [:pick $var2 ($rLen - 1)];
					:if ($var1 = ",") do={
						#on lines with lists the file has an extra comma at the end, lets get rid of it
						:set $var2 [:pick $var2 0 ($rLen - 1)];
					}
					:set ($rData->$var3) $var2;
				}
				
			} else={
				#license or comment data, interface comments are added to monitoring files
			}
		}
		:return $rData;			
	}
	:set ($MtmT->$classId) $s;
}
