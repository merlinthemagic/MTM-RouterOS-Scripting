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

			[:execute script=$tData file=([($MtmFacts->"getMtmObjFile")])];
			
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
						:local log ("Waiting for class to instanciate: '$instanceId' did not finish in time");
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
			:set oHash [:pick $oHash 0 $hashLen];
			
			##Consider checking the store size and allocating based on that metric rather than using the hash
			:local stores {"0"=0;"1"=1;"2"=2;"3"=3;"4"=4;"5"=5;"6"=6;"7"=7;"8"=8;"9"=9;"a"=10;"b"=11;"c"=12;"d"=13;"e"=14;"f"=15};
			:set ($MtmOFC->$0) {"hash"=$oHash;"sid"=($stores->([:pick $oHash 1]))};
			
			:if ($MtmFacts->"debug" = true) do={
				[($MtmFacts->"setDebugMsg") ("ID: '".$0."' assigned hash: '".($rObj->"hash")."' in store: '".($rObj->"name")."'")];
			}
		}
	
		:local rObj [:toarray ""];
		:set ($rObj->"hash") ($MtmOFC->$0->"hash");
		:set ($rObj->"sid") ($MtmOFC->$0->"sid");
		:set ($rObj->"name") ("MtmOs".($MtmOFC->$0->"sid"));

		##Consider using [:parse ] below in the future, this will allow us to set an arbirary store count
		
		:if (($rObj->"sid") = 0) do={
			:global MtmOs0;
			:if ($MtmOs0 = nil) do={
				:set MtmOs0 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs0;
			:return $rObj;
		}
		:if (($rObj->"sid") = 1) do={
			:global MtmOs1;
			:if ($MtmOs1 = nil) do={
				:set MtmOs1 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs1;
			:return $rObj;
		}
		:if (($rObj->"sid") = 2) do={
			:global MtmOs2;
			:if ($MtmOs2 = nil) do={
				:set MtmOs2 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs2;
			:return $rObj;
		}
		:if (($rObj->"sid") = 3) do={
			:global MtmOs3;
			:if ($MtmOs3 = nil) do={
				:set MtmOs3 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs3;
			:return $rObj;
		}
		:if (($rObj->"sid") = 4) do={
			:global MtmOs4;
			:if ($MtmOs4 = nil) do={
				:set MtmOs4 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs4;
			:return $rObj;
		}
		:if (($rObj->"sid") = 5) do={
			:global MtmOs5;
			:if ($MtmOs5 = nil) do={
				:set MtmOs5 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs5;
			:return $rObj;
		}
		:if (($rObj->"sid") = 6) do={
			:global MtmOs6;
			:if ($MtmOs6 = nil) do={
				:set MtmOs6 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs6;
			:return $rObj;
		}
		:if (($rObj->"sid") = 7) do={
			:global MtmOs7;
			:if ($MtmOs7 = nil) do={
				:set MtmOs7 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs7;
			:return $rObj;
		}
		:if (($rObj->"sid") = 8) do={
			:global MtmOs8;
			:if ($MtmOs8 = nil) do={
				:set MtmOs8 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs8;
			:return $rObj;
		}
		:if (($rObj->"sid") = 9) do={
			:global MtmOs9;
			:if ($MtmOs9 = nil) do={
				:set MtmOs9 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs9;
			:return $rObj;
		}
		:if (($rObj->"sid") = 10) do={
			:global MtmOs10;
			:if ($MtmOs10 = nil) do={
				:set MtmOs10 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs10;
			:return $rObj;
		}
		:if (($rObj->"sid") = 11) do={
			:global MtmOs11;
			:if ($MtmOs11 = nil) do={
				:set MtmOs11 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs11;
			:return $rObj;
		}
		:if (($rObj->"sid") = 12) do={
			:global MtmOs12;
			:if ($MtmOs12 = nil) do={
				:set MtmOs12 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs12;
			:return $rObj;
		}
		:if (($rObj->"sid") = 13) do={
			:global MtmOs13;
			:if ($MtmOs13 = nil) do={
				:set MtmOs13 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs13;
			:return $rObj;
		}
		:if (($rObj->"sid") = 14) do={
			:global MtmOs14;
			:if ($MtmOs14 = nil) do={
				:set MtmOs14 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs14;
			:return $rObj;
		}
		:if (($rObj->"sid") = 15) do={
			:global MtmOs15;
			:if ($MtmOs15 = nil) do={
				:set MtmOs15 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs15;
			:return $rObj;
		}
		
		##catch all if the hash is moronic
		:set ($rObj->"name") "MtmOsCA";
		:global MtmOsCA;
		:if ($MtmOsCA = nil) do={
			:set MtmOsCA [:toarray ""];
		}
		:set ($rObj->"obj") $MtmOsCA;
		:return $rObj;
	}
	:set ($MtmF->$classId) $s;
}

