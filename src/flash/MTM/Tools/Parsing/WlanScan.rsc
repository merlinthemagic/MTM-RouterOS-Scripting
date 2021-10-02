:local classId "tool-parsing-wlan-scan";
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
		:local method "Tools->Parsing->WlanScan->getV1";
		:local param1;
		:if ($0 != nil) do={
			:set param1 $0;
		} else={
			[($MtmFacts->"throwException") method=$method msg="Data is mandatory"];
		}
		
		:local strTool [($MtmFacts->"execute") nsStr="getTools()->getStrings()"];
		:local lineBreak "\n";
		:local lines [($strTool->"split") str=$param1 delimitor=$lineBreak];
		
		:local rObjs [:toarray ""];
		:local rObj [:toarray ""];
		:local rCount 0;
		:local rLine "";
		:local cIndex 0;
		:local cellBreak ",";
		:local cells;
		:local ssid;
		:foreach i,line in=$lines do={
			:set rLine [($strTool->"trim") str=$line ];
			:if ($rLine != "") do={
				:set cells [($strTool->"split") str=$rLine delimitor=$cellBreak];
				:set cIndex [:len $cells];
				:if ($cIndex < 7) do={
					[($MtmFacts->"throwException") method=$method msg=("Invalid data row: '".$line."'")];
				}
				:set rObj [:toarray ""];
				:set ($rObj->"address") ($cells->0);
				:set cIndex ($cIndex - 2);
				:set ($rObj->"privacy") ($cells->$cIndex);
				:set cIndex ($cIndex - 1);
				:set ($rObj->"protocol") ($cells->$cIndex);
				:set cIndex ($cIndex - 1);
				:set ($rObj->"signal") ($cells->$cIndex);
				:set cIndex ($cIndex - 1);
				:set ($rObj->"channel") ($cells->$cIndex);
				:set cIndex ($cIndex - 1);
				
				#this complicated in case the ssid contains the cell delimitor
				:set ssid "";
				:for x from=1 to=$cIndex do={
					:set ssid ($ssid.($cells->$x));
				}
				#remove quotes around ssid
				:set ssid [:pick $ssid 1 [:len $ssid]];
				:set ssid [:pick $ssid 0 ([:len $ssid] - 1)];
				
				:set ($rObj->"ssid") $ssid;
				:set ($rObjs->$rCount) $rObj;
				:set rCount ($rCount + 1);
			}
		}
		:return $rObjs;			
	}
	:set ($MtmT->$classId) $s;
}
