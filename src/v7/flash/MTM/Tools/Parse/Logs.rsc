:local cPath "MTM/Tools/Parse/Logs.rsc";
:local s [:toarray ""];

:set ($s->"getFromStr") do={
	
	:global MtmFacts;
	:local cPath "MTM/Tools/Parse/Logs.rsc/getFromStr";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
	}
	
	:local strTool [($MtmFacts->"get") "getTools()->getTypes()->getStrings()"];
	
	:local rObjs [:toarray ""];
	:local rObj [:toarray ""];
	
	:local mPos 0;
	:local mVal "";
	:local mData $0;
	:local delimitor "\n";
	
	:set mData [($strTool->"split") $mData $delimitor];
	:foreach line in=$mData do={
		:set mVal $line;
		
		:if ([:len $mVal] > 0) do={
		
			:set rObj [:toarray ""];
			:for i from=0 to=2 do={
				:set mPos [:find $mVal " "];
				:if ([:type $mPos] = "num") do={
					
					:if ($i = 0) do={
						:set ($rObj->"date") [:pick $mVal 0 $mPos];
					}
					:if ($i = 1) do={
						:set ($rObj->"time") [:pick $mVal 0 $mPos];
					}
					:if ($i = 2) do={
						:set ($rObj->"topics") [($strTool->"split") ([:pick $mVal 0 $mPos]) ","];
					}
					:set mVal [:pick $mVal ($mPos + 1) ([:len $mVal])];
				}
			}
			:set ($rObj->"message") $mVal;

			:if ([:type ($rObj->"date")] = "str" && [:type ($rObj->"time")] = "str" && [:type ($rObj->"topics")] = "array" && [:type ($rObj->"message")] = "str") do={
				:set ($rObjs->([:len $rObjs])) $rObj;
			} else={
				:error ($cPath.": Failed to parse line: '".$line."'");
			}
		}
	}
	:return $rObjs;
}
:global MtmToolParse1;
:set ($MtmToolParse1->"logs") $s;
