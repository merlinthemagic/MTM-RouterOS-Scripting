:local classId "tool-traceroute";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmT;
:if (($MtmT->$classId) = nil) do={
	
	:local s [:toarray ""];
	
	:set ($s->"ipv4ICMP") do={
	
		:global MtmFacts;
		:local method "Tools->Traceroute->ipv4ICMP";
		:local param1; #ipv4 address
		:local param2 "00:00:00.500"; #timeout
		:local param3 32; #max hops
		:local param4 "main"; #routing table
		:local param5 5; #max timeouts in a row
		:if ($0 != nil) do={
			:set param1 $0;
		} else={
			[($MtmFacts->"throwException") method=$method msg="IPv4 address is mandatory"];
		}
		:if ($1 != nil) do={
			:local param2 $1;
		}
		:if ($2 != nil) do={
			:local param3 $2;
		}
		:if ($3 != nil) do={
			:local param4 $3;
		}
		:if ($4 != nil) do={
			:local param5 $4;
		}
		:local pingTool [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getPing()"];
		:local fileTool [($MtmFacts->"execute") nsStr="getTools()->getFiles()"];
		:local tmpFile [($MtmFacts->"getMtmTempFile") true];
		
		:local params [:toarray ""];
		:set ($params->"address") $param1;
		:set ($params->"timeout") $param2;
		:set ($params->"table") $param4;
		:set ($params->"rounds") 0;
		:set ($params->"initTtl") 1;
		
		:local rHops $param3; #remaining hops
		:local hopLoop 10; #hops per loop, limited by he 4k file size and most destinations being reachable in 10 or less hops
		:local hopCount 0;
		:local exeId;
		:local expSize;
		:local jobType;
		:local isDone;
		:local rObjs [:toarray ""];
		:local rObj [:toarray ""];
		:local rCount 0;
		:local raw;
		:local tmoCount 0;
		:local tCount 50;
		:while ($rHops > 0) do={
			:set ($params->"initTtl") (($params->"initTtl") + $hopCount);
			:if ($rHops > $hopLoop) do={
				:set hopCount $hopLoop;
				:set rHops ($rHops - $hopLoop);
			} else={
				:set hopCount $rHops;
				:set rHops 0;
			}
			:set ($params->"rounds") $hopCount;
			[($MtmFacts->"setMtmTempVar") $params];
			
			:local scr (":global MtmFacts;\r\n");
			:set scr ($scr.":local params [(\$MtmFacts->\"getMtmTempVar\")];\r\n");
			:set scr ($scr.":do {\r\n");
				:set scr ($scr.":local addr (\$params->\"address\");\r\n");
				:set scr ($scr.":local timeout (\$params->\"timeout\");\r\n");
				:set scr ($scr.":local ttl (\$params->\"initTtl\");\r\n");
				:set scr ($scr.":local rounds (\$params->\"rounds\");\r\n");
				:set scr ($scr.":local table (\$params->\"table\");\r\n");
				:set scr ($scr.":for x from=1 to=\$rounds do={\r\n");
					:set scr ($scr."/ping address=\$addr ttl=\$ttl interval=\$timeout routing-table=\$table count=1;\r\n");
					:set scr ($scr.":set ttl (\$ttl + 1);\r\n");
				:set scr ($scr."}\r\n");

			:set scr ($scr."} on-error={\r\n");
			:set scr ($scr."}\r\n");
			:set scr ($scr.":error \"\";\r\n");

			:set tmpFile [($MtmFacts->"getMtmTempFile") true];
			:set exeId [:execute script=$scr file=$tmpFile];
			
			:set expSize (200 * $hopCount); #estimate of the file size when done 200 bytes per ping
			:set isDone false;
			:set tCount 50;
			:while ($isDone = false) do={
				:set tCount ($tCount - 1);
				:if ($tCount > 0) do={
					:delay 0.1s;
				} else={
					[($MtmFacts->"throwException") method=$method msg="Script failed to complete"];
				}
				:if ([($fileTool->"getSize") $tmpFile] >= $expSize) do={
					:set isDone true;
				}
			}

			:set raw [($fileTool->"getContent") $tmpFile];
			:foreach ping in=[($pingTool->"asArray") $raw] do={
				:set rObj [:toarray ""];
				:set ($rObj->"hop") $rCount;

				:if (($ping->"status") != "timeout") do={
					:set tmoCount 0;
					:set ($rObj->"ip") ($ping->"host");
				} else={
					:set tmoCount ($tmoCount + 1);
					:set ($rObj->"ip") "timeout";
				}
				
				:set ($rObj->"rtt") ($ping->"rtt");
				:set ($rObjs->$rCount) $rObj;
				:if ($ping->"host" = $param1 && ($ping->"status") = [:nothing]) do={
					:return $rObjs;
				}
				:if ($tmoCount = $param5) do={
					##too many timeouts
					:return $rObjs;
				}
				:set rCount ($rCount + 1);
			}
		}
		:return $rObjs;
	}
	:set ($MtmT->$classId) $s;
}
