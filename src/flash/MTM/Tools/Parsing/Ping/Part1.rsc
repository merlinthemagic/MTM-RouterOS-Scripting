:set ($s->"asArray") do={
	
	:global MtmFacts;
	:local method "Tools->Parsing->Ping->asArray";
	:local param1;
	:if ($0 != nil) do={
		:set param1 $0;
	} else={
		[($MtmFacts->"throwException") method=$method msg="Input string is mandatory"];
	}
	
	:local strTool [($MtmFacts->"execute") nsStr="getTools()->getStrings()"];
	:local rObjs [:toarray ""];
	:local rCount 0;
	:local rObj [:toarray ""];
	:local state;
	:local heads;
	:local label;
	:local labels [:toarray "SEQ,HOST,SIZE,TTL,TIME,STATUS"];
	:local indexes [:toarray "seq,host,size,ttl,rtt,status"];
	:local val;
	:local pos 0;
	:local sPos 0;
	:local ePos 0;
	:local lineBreak "\r\n";
	:local lines [($strTool->"split") str=$param1 delimitor=$lineBreak];
	:foreach line in=$lines do={
		:if ([:len $line] > 0) do={
			:set pos [:find $line "  SEQ HOST"];
			:if ([:typeof $pos] = "num" && $pos = 0) do={
				:set state "getready";
				:if ($heads = nil) do={
					:set heads [:toarray ""];
					:foreach id,head in=$labels do={
						:set label ($indexes->$id);
						:set ($heads->$label) [:toarray ""];
						:set ($heads->$label->"s") $sPos;
						:set ePos ([:find $line $head] + [:len $head]);
						:if ($head = "HOST") do={
							:set ePos ($ePos + 25);
						}
						:if ($head = "STATUS") do={
							:set ePos [:len $line];
						}
						:set ($heads->$label->"e") $ePos;
						:set sPos ($ePos + 1);
					}
				}
			} else={
				:set pos [:find $line "    sent="];
				:if ([:typeof $pos] = "num" && $pos = 0) do={
					:set state "status";
				}
			}
			:if ($state = "parse") do={
				:set rObj [:toarray ""];
				:foreach label,limits in=$heads do={
					:set val [:pick $line ($limits->"s") ($limits->"e")];
					:set val [($strTool->"trim") $val];
					:if ($val = "") do={
						:set val [:nothing];
					}
					:if ($label = "rtt" && $val = [:nothing]) do={
						:set val "timeout";
					}
					:set ($rObj->$label) $val;
				}
				:set ($rObjs->$rCount) $rObj;
				:set rCount ($rCount + 1);

			} else={
				:if ($state = "getready") do={
					:set state "parse";
				}
			}
		}
	}
	:return $rObjs;
}