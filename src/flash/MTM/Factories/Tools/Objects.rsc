:local classId "fact-tool-objs";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmT;
:if (($MtmT->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getInstanceV3") do={
	
		##templates
		:global MtmFacts;
		:local method "Facts->Tools->Objects->getInstanceV3";
		
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Paths are mandatory"];
		}
		:if ($1 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Instance id is mandatory"];
		}
		:if ($2 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Object id is mandatory"];
		}
		:if ($3 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Store obj is mandatory"];
		}
		:if ($4 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Store name is mandatory"];
		}
		:local paths $0;
		:local instanceId $1;
		:local objId $2;
		:local storeObj $3;
		:local storeName $4;
		
		:if (($storeObj->$instanceId) = nil) do={
			:local tData "";
			:local fsTool [($MtmFacts->"execute") nsStr="getTools()->getFiles()"];
			:foreach path in=$paths do={
				##add a line break after each file, makes our life easier than tons or errors because file ends in a "}"
				:set tData ($tData."\n".([($fsTool->"getContent") $path]));
			}
			:global MtmCache;
			:set tData [($MtmCache->"strReplace") str=$tData find="|MTMD|" replace=$objId];
			:set tData [($MtmCache->"strReplace") str=$tData find="|MTMC|" replace=$instanceId];
			:set tData [($MtmCache->"strReplace") str=$tData find="|MTMS|" replace=$storeName];
			:local jobId [:execute script=$tData file=([($MtmFacts->"getMtmObjFile")])];
			
			:if ($MtmFacts->"debug" = true) do={
				[($MtmFacts->"setDebugMsg") ("Waiting for object: ".$instanceId)];
			}
			:local tCount 50;
			:while ($tCount > 0) do={
			
				:if ([($MtmCache->"isEmpty") ($storeObj->$instanceId)] = false) do= {
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
		:local method "Facts->Tools->Objects->getStoreByHash";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Input class unique id is mandatory"];
		}
		:local hashTool [($MtmFacts->"execute") nsStr="getTools()->getHashing()->getMD5()"];
		:local oHash [($hashTool->"hash") $0];
		
		:local stores {"0"=0;"1"=1;"2"=2;"3"=3;"4"=4;"5"=5;"6"=6;"7"=7;"8"=8;"9"=9;"a"=10;"b"=11;"c"=12;"d"=13;"e"=14;"f"=15};
		:local sId ($stores->([:pick $oHash 1]));
		:local rObj [:toarray ""];
		:set ($rObj->"hash") $oHash;
		:set ($rObj->"name") ("MtmOs".$sId);
		
		:if ($sId = 0) do={
			:global MtmOs0;
			:if ($MtmOs0 = nil) do={
				:set MtmOs0 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs0;
			:return $rObj;
		}
		:if ($sId = 1) do={
			:global MtmOs1;
			:if ($MtmOs1 = nil) do={
				:set MtmOs1 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs1;
			:return $rObj;
		}
		:if ($sId = 2) do={
			:global MtmOs2;
			:if ($MtmOs2 = nil) do={
				:set MtmOs2 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs2;
			:return $rObj;
		}
		:if ($sId = 3) do={
			:global MtmOs3;
			:if ($MtmOs3 = nil) do={
				:set MtmOs3 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs3;
			:return $rObj;
		}
		:if ($sId = 4) do={
			:global MtmOs4;
			:if ($MtmOs4 = nil) do={
				:set MtmOs4 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs4;
			:return $rObj;
		}
		:if ($sId = 5) do={
			:global MtmOs5;
			:if ($MtmOs5 = nil) do={
				:set MtmOs5 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs5;
			:return $rObj;
		}
		:if ($sId = 6) do={
			:global MtmOs6;
			:if ($MtmOs6 = nil) do={
				:set MtmOs6 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs6;
			:return $rObj;
		}
		:if ($sId = 7) do={
			:global MtmOs7;
			:if ($MtmOs7 = nil) do={
				:set MtmOs7 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs7;
			:return $rObj;
		}
		:if ($sId = 8) do={
			:global MtmOs8;
			:if ($MtmOs8 = nil) do={
				:set MtmOs8 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs8;
			:return $rObj;
		}
		:if ($sId = 9) do={
			:global MtmOs9;
			:if ($MtmOs9 = nil) do={
				:set MtmOs9 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs9;
			:return $rObj;
		}
		:if ($sId = 10) do={
			:global MtmOs10;
			:if ($MtmOs10 = nil) do={
				:set MtmOs10 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs10;
			:return $rObj;
		}
		:if ($sId = 11) do={
			:global MtmOs11;
			:if ($MtmOs11 = nil) do={
				:set MtmOs11 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs11;
			:return $rObj;
		}
		:if ($sId = 12) do={
			:global MtmOs12;
			:if ($MtmOs12 = nil) do={
				:set MtmOs12 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs12;
			:return $rObj;
		}
		:if ($sId = 13) do={
			:global MtmOs13;
			:if ($MtmOs13 = nil) do={
				:set MtmOs13 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs13;
			:return $rObj;
		}
		:if ($sId = 14) do={
			:global MtmOs14;
			:if ($MtmOs14 = nil) do={
				:set MtmOs14 [:toarray ""];
			}
			:set ($rObj->"obj") $MtmOs14;
			:return $rObj;
		}
		:if ($sId = 15) do={
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
	:set ($MtmT->$classId) $s;
}

