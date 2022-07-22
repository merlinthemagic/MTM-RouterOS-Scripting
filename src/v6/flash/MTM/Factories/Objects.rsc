:local classId "fact-objs";
:global MtmF;
:if (($MtmF->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getInstance") do={
	
		##templates
		:global MtmFacts;
		:local method "Facts->Objects->getInstance";

		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Store obj is mandatory"];
		}
		:if ($1 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Store name is mandatory"];
		}
		:if ($2 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Paths are mandatory"];
		}
		:if ($3 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="system id is mandatory"];
		}
		:if ($4 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Instance id is mandatory"];
		}

		:local storeObj $0;
		:local storeName $1;
		:local paths $2;
		:local objId $3;
		:local instanceId $4;

		:if (($storeObj->$instanceId) = nil) do={
			
			##cant use any of the tools, as they will be stood up by this function
			:local tData "";
			:foreach path in=$paths do={
			
				:if ([:len [/file find where name=$path]] > 0) do={
					:if ([/file get [find where name=$path] size] < 4096) do={
						##add a line break after each file, makes our life easier than tons or errors because file ends in a "}"
						:set tData ($tData."\n".[/file get [find where name=$path] content]);
					} else={
						[($MtmFacts->"throwException") method=$method msg=("File: '".$path."', is ".[/file get [find where name=$path] size]." bytes, exceeds maximum of 4095 bytes")];
					}
				} else={
					[($MtmFacts->"throwException") method=$method msg=("Path does not exist: '".$path."'")];
				}
			}

			:local rData "";
			:local isDone;
			:local fLen;
			:local rLen;
			:local pos;
			:local result;
			:local log "";
			
			:local strReps [:toarray ""];
			:set ($strReps->"|MTMD|") $objId;
			:set ($strReps->"|MTMC|") $instanceId;
			:set ($strReps->"|MTMS|") $storeName;
			
			:foreach find,replace in=$strReps do={
				:set isDone 0;
				:set rLen [:len $tData];
				:set fLen [:len $find];
				:set rData "";
				:while ($isDone = 0) do={
					:set pos [:find $tData $find];
					:if ([:typeof $pos] = "num") do={
						:set rData ($rData.[:pick $tData 0 $pos].$replace);
						:set tData [:pick $tData ($pos + $fLen) $rLen];
						:set rLen [:len $tData];
					} else={
						:set rData ($rData.$tData);
						:set isDone 1;
					}
				}
				:set tData $rData;
			}

			:set result [:execute script=$tData file=([($MtmFacts->"getMtmObjFile")])];
			
			:if ($MtmFacts->"debug" = true) do={
				[($MtmFacts->"setDebugMsg") ("Waiting for object: ".$instanceId.", in store: ".$storeName)];
			}
			:local tCount 50;
			:while ($tCount > 0) do={
			
				:if (($storeObj->$instanceId) != nil) do= {
					:set tCount 0;
				} else={
					:if ($tCount > 1) do={
						:set tCount ($tCount - 1);
						:delay 0.25s;
					} else={
						:set log ("Waiting for class to instanciate: '$instanceId' did not finish in time");
						:if ($MtmFacts->"debug" = true) do={
							[($MtmFacts->"setDebugMsg") $log];
						}
						[($MtmFacts->"throwException") method=$method msg=$log];
					}
				}
			}
			:if ($MtmFacts->"debug" = true) do={
				[($MtmFacts->"setDebugMsg") ("Object is ready: ".$instanceId)];
			}
		} else={
			:if ($MtmFacts->"debug" = true) do={
				[($MtmFacts->"setDebugMsg") ("Object exists: ".$instanceId)];
			}
		}
		
		:return ($storeObj->$instanceId);
	}
	:set ($s->"getStore") do={
		
		##get stores from here if you want to distribute objects across a bunch of globals
		##once a global gets to ~$40-70Kb overflows seem to happen and unpredictable results ensue
		:global MtmFacts;
		:local method "Facts->Objects->getStore";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Input class unique id is mandatory"];
		}

		:global MtmOFC;
		:if (($MtmOFC->$0) = nil) do={
			:local oHash "";
			:if ($0 = "fact-tools" || $0 = "fact-tool-hashing" || $0 = "tool-strings") do={
				##these hashes are in the path for getting the hash tool
				##cant use the hash tool, as the intermediaries will be stood up by this function
				:if ($0 = "fact-tools") do={
					:set oHash "6d731b135858b24c62ab7d595f9af669";
				}
				:if ($0 = "fact-tool-hashing") do={
					:set oHash "9782a6f3a3b12b734e36716516125898";
				}
				:if ($0 = "tool-strings") do={
					:set oHash "e3e5d224eac0aed9590c9c86bfddce29";
				}
			} else={
				:local hashTool [($MtmFacts->"execute") nsStr="getTools()->getHashing()->getMD5()"];
				:set oHash [($hashTool->"hash") $0];
			}
			## dont want to waste memory, also don want collisions. 16M "should" be a big enough keyspace?
			:local hashLen 6;
			:local storChars 1;
			:set oHash [:pick $oHash 0 $hashLen];
			
			##Consider checking the store size and allocating based on that metric rather than just using the hash
			:set ($MtmOFC->$0) {"hash"=$oHash;"sid"=([:pick $oHash 0 $storChars])};
			:if ($MtmFacts->"debug" = true) do={
				[($MtmFacts->"setDebugMsg") ("ID: '".$0."' assigned hash: '".($MtmOFC->$0->"hash")."' in store ID: '".($MtmOFC->$0->"sid")."'")];
			}
		}
	
		:local rObj [:toarray ""];
		:set ($rObj->"hash") ($MtmOFC->$0->"hash");
		:set ($rObj->"sid") ($MtmOFC->$0->"sid");
		:set ($rObj->"name") ("MtmOs".($MtmOFC->$0->"sid"));

		##By Using [:parse ] below it allows us to set an arbirary store count in the future
		:local gName ($rObj->"name");
		:local gObj [:parse (":global ".$gName."; :if (\$".$gName." = nil) do={ :set ".$gName." [:toarray \"\"] }; :return \$".$gName)];
		:set ($rObj->"obj") [$gObj];
		:return $rObj;
	}
	:set ($MtmF->$classId) $s;
}

