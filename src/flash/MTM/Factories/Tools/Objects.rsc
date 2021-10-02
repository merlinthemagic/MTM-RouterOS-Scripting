:local classId "fact-tool-objs";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmT;
:if (($MtmT->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"jobs") [:toarray ""];
	:set ($s->"busy") false;
	:set ($s->"count") 0;

	:set ($s->"getInstanceV1") do={
	
		:global MtmFacts;
		:global MtmCache;
		:local method "Facts->Tools->Objects->getInstanceV1";
		:if ($paths = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Paths are mandatory"];
		}
		:if ($id = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Id is mandatory"];
		}
		:if ($classId = nil) do={
			[($MtmFacts->"throwException") method=$method msg="ClassId is mandatory"];
		}
		
		:local storeId ""; ## default store
		:if ($objCacheId != nil) do={
			:set storeId $objCacheId;
		}
		:local objStore;
		:if ($storeId = "") do={
			:global MtmO;
			:set objStore $MtmO;
		}
		:if ($storeId = 1) do={
			:global MtmO1;
			:set objStore $MtmO1;
		}
		:if ($storeId = 2) do={
			:global MtmO2;
			:set objStore $MtmO2;
		}
		:if ($storeId = 3) do={
			:global MtmO3;
			:set objStore $MtmO3;
		}
		:if (($objStore->$classId) = nil) do={
		
			##setup the job
			:local self [($MtmFacts->"execute") nsStr="getTools()->getObjects()"];
			:local jObjs ($self->"jobs");
			:if ([($MtmCache->"isEmpty") ($jObjs->$classId)] = true) do= {
				
				:local jobObj [:toarray ""];
				:set ($jobObj->"paths") [:toarray ""];
				:set ($jobObj->"storeId") ("MtmO".$storeId);
				:set ($jobObj->"classId") $classId;
				:set ($jobObj->"id") $id;
				:set ($jobObj->"size") 0;
				
				:local mtmPath [($MtmFacts->"getMtmPath")];
				:local pCount 0;
				:foreach path in=$paths do={
					:set ($jobObj->"paths"->$pCount) ($mtmPath.$path);
					:set pCount ($pCount + 1);
				}
				:set ($jObjs->$classId) $jobObj;
				
				:if (($self->"busy") = false) do={
					:set ($self->"busy") true;
					:local scr (":global MtmFacts;\r\n");
					:set scr ($scr.":local sObj [(\$MtmFacts->\"execute\") nsStr=\"getTools()->getObjects()\"];\r\n");
					:set scr ($scr."[(\$sObj->\"doProcess\")];\r\n");
					[:execute script=$scr file=([($MtmFacts->"getMtmNullFile")])];
					
					##debug
					#[($self->"doProcess")];
				}
			}
			
			:if ($MtmFacts->"debug" = true) do={
				[($MtmFacts->"setDebugMsg") ("Waiting for object: ".$classId)];
			}
			:local tCount 50;
			:while ($tCount > 0) do={
			
				:if ([($MtmCache->"isEmpty") ($objStore->$classId)] = false) do= {
					:set tCount 0;
				} else={
					:if ($tCount > 1) do={
						:set tCount ($tCount - 1);
						:delay 0.25s;
					} else={
						:local log ("Waiting for class to instanciate: '$classId' did not finish in time");
						:if ($MtmFacts->"debug" = true) do={
							[($MtmFacts->"setDebugMsg") $log];
						}
						[($MtmFacts->"throwException") method=$method msg=$log];
					}
				}
			}
		}
		:if ($MtmFacts->"debug" = true) do={
			[($MtmFacts->"setDebugMsg") ("Object is ready: ".$classId.", ".[:typeof ($objStore->$classId)])];
		}
		:return ($objStore->$classId);
	}
	:set ($s->"getInstanceV2") do={
	
		:global MtmFacts;
		:global MtmCache;
		:local method "Facts->Tools->Objects->getInstanceV2";
		
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Paths are mandatory"];
		}
		:if ($1 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Object id is mandatory"];
		}
		:if ($2 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Instance id is mandatory"];
		}
		:if ($3 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Store obj is mandatory"];
		}
		:if ($4 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="store id is mandatory"];
		}
		
		:local paths $0;
		:local objId $1;
		:local instanceId $2;
		:local storeObj $3;
		:local storeId $4;
		
		:if (($storeObj->$instanceId) = nil) do={
		
			##setup the job
			:local self [($MtmFacts->"execute") nsStr="getTools()->getObjects()"];
			:local jObjs ($self->"jobs");
			:if ([($MtmCache->"isEmpty") ($jObjs->$instanceId)] = true) do= {
				
				:local jobObj [:toarray ""];
				:set ($jobObj->"paths") $paths;
				:set ($jobObj->"storeId") $storeId;
				:set ($jobObj->"classId") $instanceId;
				:set ($jobObj->"id") $objId;
				:set ($jobObj->"size") 0;

				:set ($jObjs->$instanceId) $jobObj;
				
				:if (($self->"busy") = false) do={
					:set ($self->"busy") true;
					:local scr (":global MtmFacts;\r\n");
					:set scr ($scr.":local sObj [(\$MtmFacts->\"execute\") nsStr=\"getTools()->getObjects()\"];\r\n");
					:set scr ($scr."[(\$sObj->\"doProcess\")];\r\n");
					[:execute script=$scr file=([($MtmFacts->"getMtmNullFile")])];
					
					##debug
					#[($self->"doProcess")];
				}
			}
			
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
		}
		:if ($MtmFacts->"debug" = true) do={
			[($MtmFacts->"setDebugMsg") ("Object is ready: ".$instanceId.", ".[:typeof ($storeObj->$instanceId)])];
		}
		:return ($storeObj->$instanceId);
	}
	:set ($s->"doProcess") do={

		:global MtmFacts;
		:local logHead (" RosEvent:");
		:local method "Facts->Tools->Objects->doProcess";
		
		:do {
			
			:local self [($MtmFacts->"execute") nsStr="getTools()->getObjects()"];
	
			#build a script that will loop over the instance files and add them all to a new bigger file
			:local scr (":global MtmFacts;\r\n");
			:set scr ($scr.":global MtmCache;\r\n");
			:set scr ($scr.":local jObj [(\$MtmFacts->\"getMtmTempVar\")];\r\n");
			:set scr ($scr.":do {\r\n");
			:set scr ($scr.":local fTool [(\$MtmFacts->\"execute\") nsStr=\"getTools()->getFiles()\"];\r\n");
			:set scr ($scr.":local size 0;\r\n");
			:set scr ($scr.":local content \"\";\r\n");
			:set scr ($scr.":foreach path in=(\$jObj->\"paths\") do={\r\n");
			:set scr ($scr.":set content ([(\$fTool->\"getContent\") path=\$path].\"\\n\");\r\n");
			:set scr ($scr.":set content [(\$MtmCache->\"strReplace\") str=\$content find=\"|MTMD|\" replace=(\$jObj->\"id\")];\r\n");
			:set scr ($scr.":set content [(\$MtmCache->\"strReplace\") str=\$content find=\"|MTMC|\" replace=(\$jObj->\"classId\")];\r\n");
			:set scr ($scr.":set content [(\$MtmCache->\"strReplace\") str=\$content find=\"|MTMS|\" replace=(\$jObj->\"storeId\")];\r\n");
			:set scr ($scr.":set size (\$size + [:len \$content] + 2);\r\n");
			:set scr ($scr.":put (\$content);\r\n");
			:set scr ($scr."}\r\n");
			:set scr ($scr.":set (\$jObj->\"size\") \$size;\r\n");
			:set scr ($scr."} on-error={\r\n");
			:set scr ($scr."/file set mtmErr.txt content=(\"Error instanciating class: \".(\$jObj->\"classId\"));\r\n");
			:set scr ($scr.":set (\$jObj->\"size\") -1;\r\n");
			:set scr ($scr."}\r\n");
			
			#load the tools so we dont get "Script file loaded and executed successfully" junk in the output
			:local fsTool [($MtmFacts->"execute") nsStr="getTools()->getFiles()"];
	
			:local tCount 0;
			:local cSize 0;
			:local tSize 0;
			:local isDone false;
			:local classId;
			:local jObjs;
			:local jobId;
			:local outFile [($MtmFacts->"getMtmObjFile")];
			
			:while ($isDone = false) do={
			
				:set jObjs ($self->"jobs");
				:if ([:len $jObjs] > 0) do={
				
					:foreach index,jobObj in=$jObjs do={
	
						##we have to jump through alot of hoops to make large objects
						#the file size limitation screws us unless we use the logging function of :execute to append a file
						:set classId ($jobObj->"classId");

						##set the script job data
						[($MtmFacts->"setMtmTempVar") $jobObj];

						## zero out the file
						[($fsTool->"setContent") $outFile ""];

						#trigger the script
						:set jobId [:execute script=$scr file=$outFile];

						#wait for the slow ass i/o to catch up
						:set tCount 75;
						:set cSize 0;
						:set tSize;
						:while ($tCount > 0) do={
						
							:set tCount ($tCount - 1);
							:if ($tCount > 0) do={
								:delay 0.2s;
							} else={
								[($MtmFacts->"throwException") method=$method msg=("Failed to instanciate object of class: '".$classId."' in time") logFile=true];
							}
							
							#did the script complete and give us the final size of the output file?
							:if ($tSize = nil && ($jobObj->"size") > 0) do={
								:set tSize ($jobObj->"size");
								:if ($tSize < 0) do={
									:local errMsg [($fsTool->"getContent") ([($MtmFacts->"getMtmErrFile")])];
									[($MtmFacts->"throwException") method=$method msg=("instanciating object of class: '".$classId."' ended in exception. Msg: '".$errMsg."'") logFile=true];
								}
							}
							:if ($tSize != nil) do={
								#wait for the file to grow to the right size
								:set cSize [($fsTool->"getSize") $outFile];
								:if ($tSize = $cSize) do={
									:set tCount 0; #success
								}
							}
						}

						#import the large instance file
						[($MtmFacts->"importFile") $outFile];
						:set ($self->"jobs"->$index);
					}
					
				} else={
					## done
					:set ($self->"busy") false;
					:set isDone true;
				}
			}
			
		} on-error={
			:set ($self->"busy") false;
			:log error ($logHead." '".$method."' ended in exception");
		}
		
		:return 0;
	}
	:set ($MtmT->$classId) $s;
}

