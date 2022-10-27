:local cPath "MTM/Facts.rsc";
:global MtmFacts;
:if ([:typeof $MtmFacts] = "nothing") do={

	:local s [:toarray ""];
	:set ($s->"env") [:toarray ""];
	
	:local envFile "MtmEnv.rsc";
	:set envFile [/file/find where name~$envFile];
	:if ([:len $envFile] > 0) do={
		:if ([:typeof $envFile] = "array") do={
			:set envFile ($envFile->0);
		}
		:set envFile [/file/get $envFile name];
		
	} else={
		:error ($cPath.": Cannot find environment file 'MtmEnv.rsc'");
	}
	:set ($s->"setDebug") do={
		:local cPath "MTM->Facts->setDebug";
		:global MtmFacts;
		:if ($0 != "true" && $0 != "false") do={
			:error ($cPath.": Parameter must be true or false");
		}
		:local mVal [($MtmFacts->"setEnv") "mtm.debug.enabled" $0];
		:if ($0 = true) do={
			:set mVal [($MtmFacts->"echo") ("Debug set ON")];
		} else={
			:set mVal [($MtmFacts->"echo") ("Debug set OFF")];
		}
		:return $MtmFacts;
	}
	:set ($s->"setEnv") do={
		:local cPath "MTM->Facts->setEnv";
		:global MtmFacts;
		:if ([:len $0] = 0 || [:typeof $0] != "str") do={
			:error ($cPath.": Key is mandatory, must be string value");
		}
		:if ([:typeof $1] != "str") do={
			:error ($cPath.": Value must be string value");
		}
		:set ($MtmFacts->"env"->$0) $1;
		:return $MtmFacts;
	}
	:set ($s->"getEnv") do={
		:local cPath "MTM->Facts->getEnv";
		:global MtmFacts;
		:if ([:len $0] = 0 || [:typeof $0] != "str") do={
			:error ($cPath.": Key is mandatory, must be string value");
		}
		:local mVal ($MtmFacts->"env"->$0);
		:if ([:typeof $mVal] = "nothing" && $1 != false) do={
			:error ($cPath.": Key '".$0."' does not exist");
		}
		:return $mVal;
	}
	:set ($s->"echo") do={
		:put ($0."\n");
		:return true;
	}
	:set ($s->"getNullFile") do={
		:local mVal "mtmNull.txt";
		:if ([:len [/file find where name=$mVal]] < 1) do= {
			/file print file=$mVal;
			:delay 2s;
		}
		:return $mVal;
	}
	:set ($s->"importFile") do={
		:global MtmFacts;
		:local cPath "MTM/Facts.rsc/importFile";
		:if ([:len $0] = 0 || [:typeof $0] != "str") do={
			:error ($cPath.": File path is mandatory, must be string value");
		}
		:local mVal "";
		
		:if ([:len [/file find where name=$0]] = 0) do={
			
			:set mVal [($MtmFacts->"getEnv") "mtm.remote.enabled" false];
			:if ($mVal != true) do={
				:error ($cPath.": Cannot import '".$0."' file does not exist locally and remote fetching is not enabled");
			} else={
				##file does not exist locally, try a remote load
				:set mVal [($MtmFacts->"importRemoteFile") $0];
			}
			
		} else= {
			:set mVal [($MtmFacts->"getEnv") "mtm.debug.enabled" false];
			:if ($mVal = true) do={
				#debugging mode
				[($MtmFacts->"echo") ("Starting file import: '".$0."'")];
				/import file-name=$0 verbose=no;
				[($MtmFacts->"echo") ("Completed file import: '".$0."'")];
			} else={
			
				#delegate job to sub process
				:local scr (":put ".$0."; /import file-name=".$0." verbose=no");
				:local jobId [:execute script=$scr file=([($MtmFacts->"getNullFile")])];
				
				:local tCount 150; ##need more than 30 secs to run an import?
				:local jobType "";
				:while ($tCount > 0) do={
					:set jobType [/system script job get $jobId type];
					:if ([:typeof $jobType] = "nil") do={
						:set tCount 0;
						##validate job done?
					} else={
						:if ($tCount > 0) do={
							:set tCount ($tCount - 1);
							:delay 0.2s;
						} else={
							:error ($cPath.": Importing '".$0."' resulted in timeout");
						}
					}
				}
			}
		}
		:return $MtmFacts;
	}
	:set ($s->"importRemoteFile") do={
		:global MtmFacts;
		:local cPath "MTM/Facts.rsc/importRemoteFile";
		:if ([:len $0] = 0 || [:typeof $0] != "str") do={
			:error ($cPath.": File path is mandatory, must be string value");
		}
		:local mVal "";		
		:local dstPath "";
		:local user "";
		:local pass "";
		:local url "";
		:local port "";
		:local mode "";
		:local chkCert "";
		
		:set user ([($MtmFacts->"getEnv") "mtm.remote.user"]);
		:set pass ([($MtmFacts->"getEnv") "mtm.remote.pass"]);
		
		:set url ($url.[($MtmFacts->"getEnv") "mtm.remote.host"]);
		:set url ($url."/".[($MtmFacts->"getEnv") "mtm.remote.url"]);
		:set url ($url."/".$0);
		
		:set mVal [($MtmFacts->"getEnv") "mtm.remote.save.enabled" false];
		:if ($mVal = true) do={
			:set dstPath [($MtmFacts->"getEnv") "mtm.remote.save.path" false];
			:set dstPath ($dstPath.$0);
		} else={
			:set dstPath "remoteLoad.rsc";
		}
		
		:if ($dstPath = "remoteLoad.rsc" || [:len [/file find where name=$dstPath]] = 0) do={
			#file does not exist in the local cache, get it
			:set mVal [:tostr [($MtmFacts->"getEnv") "mtm.remote.port" false]];
			:if ($mVal = "") do={
				:if (([($MtmFacts->"getEnv") "mtm.remote.host"]) ~ "^https") do={
					:set port 443;
				} else={
					:set port 80;
				}
			} else={
				:set port $mVal;
			}
			:if (([($MtmFacts->"getEnv") "mtm.remote.host"]) ~ "^https") do={
				
				:set mode "https";
				:set mVal [($MtmFacts->"getEnv") "mtm.remote.cert.valid" false];
				:if ($mVal = true) do={
					:set chkCert "yes";
				} else={
					:set chkCert "no";
				}

			} else={
				:set mode "http";
				:set chkCert "no";
			}
			
			:do {
				:set mVal [/tool fetch check-certificate=$chkCert url=$url mode=$mode port=$port user="$user" password="$pass" http-method=get output=file as-value dst-path=$dstPath];
				#success
			} on-error={
				##there is no error catching possible..
				:error ($cPath.": Fetching '".$url."' to import file '".$0."' failed");
			}
		}
		:return [($MtmFacts->"importFile") $dstPath];
	}
	:set ($s->"get") do={
		
		:global MtmFacts;
		:local cPath "MTM/Facts.rsc/get";
		:if ([:typeof $0] != "str") do={
			:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
		}
		:local curObj $MtmFacts;
		:local pos;
		:local pMethod;
		:local rMethod;
		:local rCmd;
		:local rPath $0;
		:local rLen [:len $rPath];
		:local aLen;
		:local args;
		:local fCall;
		:local isDone 0;
		:while ($isDone = 0) do={
			:set pos [:find $rPath "->"];
			:if ([:typeof $pos] = "num") do={
				:set pMethod [($MtmFacts->"parseCall") [:pick $rPath 0 $pos]];
				:set rPath [:pick $rPath ($pos + 2) $rLen];
				:set rLen [:len $rPath];
			} else={
				:set pMethod [($MtmFacts->"parseCall") $rPath];
				:set isDone 1;
			}
			:if ($curObj = "") do={
				:error ($cPath.": Cannot call: '".($pMethod->"method")."' in '".$0."', previous call failed");
			}
			:set rMethod ($pMethod->"method");
			:if ($curObj->"$rMethod" = nil) do={
				:error ($cPath.": Cannot call: '".($pMethod->"method")."' in '".$0."', method does not exist");
			}

			#super hackish, but there does not seem to be a way to pass parameters as a string or array
			:set aLen [:len ($pMethod->"args")];
			:if ($aLen < 1) do={
				#no parameters
				:set curObj [($curObj->"$rMethod")];
			} else={
				:set args ($pMethod->"args");
				:if ($aLen < 2) do={
					:set curObj [($curObj->"$rMethod") ($args->0->"value")];
				} else={
					:if ($aLen < 3) do={
						:set curObj [($curObj->"$rMethod") ($args->0->"value") ($args->1->"value")];
					} else={
						:if ($aLen < 4) do={
							:set curObj [($curObj->"$rMethod") ($args->0->"value") ($args->1->"value") ($args->2->"value")];
						} else={
							:if ($aLen < 5) do={
								:set curObj [($curObj->"$rMethod") ($args->0->"value") ($args->1->"value") ($args->2->"value") ($args->3->"value")];
							} else={
								:error ($cPath.": Cannot complete '".$0."', only support upto 4 parameters");
							}
						}
					}
				}
			}
		}
		:return $curObj;
	}
	:set ($s->"parseCall") do={
		
		:global MtmFacts;
		:local cPath "MTM/Facts.rsc/parseCall";
		:if ([:typeof $0] != "str") do={
			:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
		}
		
		:local rData [:toarray ""];
		:set ($rData->"method") "";
		:set ($rData->"args") [:toarray ""];

		:local strTool [($MtmFacts->"getTools")];
		:set strTool [($strTool->"getTypes")];
		:set strTool [($strTool->"getStrings")];
		:local rStr [($strTool->"trim") [:tostr $0]];
		
		:local pos;
		:local len;
		:local attr;
		:local val;
		
		:set pos [:find $rStr "("]; #returns nil when not found, but a compare with nil does not work as expected
		:if ([:typeof $pos] = "num") do={
			#open parentheses means there may be arguments/parameters in the call
			:set ($rData->"method") [:pick $rStr 0 $pos];
			:set len [:len $rStr];
			:if ([:pick $rStr ($len - 1) $len] != ")") do={
				:error ($cPath.": Malformed method in '".$0."'");
			}
			:set rStr [:pick $rStr ($pos + 1) ($len - 1)];
			:set rStr [($strTool->"trim") [:tostr $rStr]];
			:set len [:len $rStr];
			:if ($len > 0) do={
				#there is arguments in the method call
				:local argCount 0;
				:local isDone 0;
				:while ($isDone = 0) do={
					:set pos [:find $rStr "='"];
					:if ([:typeof $pos] = "num") do={
						:set attr [:pick $rStr 0 $pos];
						:set attr [($strTool->"trim") [:tostr $attr]];
						:set rStr [:pick $rStr ($pos + 2) $len];
						:set pos [:find $rStr "'"];
						:if ([:typeof $pos] = "num") do={
							:set len [:len $rStr];
							:set val [:pick $rStr 0 $pos];
							:set val [($strTool->"trim") [:tostr $val]];
							
							:set ($rData->"args"->$argCount) [:toarray ""];
							:set ($rData->"args"->$argCount->"index") $argCount;
							:set ($rData->"args"->$argCount->"name") $attr;
							:set ($rData->"args"->$argCount->"value") $val;
							:set argCount ($argCount + 1);
							:set rStr [:pick $rStr ($pos + 1) $len];
							
						} else={
							:error ($cPath.": Malformed arguments in '".$0."'");
						}
					} else={
						:set isDone 1;
					}
				}
			}

		} else={
			:set ($rData->"method") $rStr;
		}
		:return $rData;
	}
	:set ($s->"lock") do={
		
		:local cPath "DCS/Facts.rsc/lock";
		:if ([:typeof $0] != "str"  || [:len $0] < 1) do={
			:error ($cPath.": Input lock name invalid type '".[:typeof $0]."'");
		}
		:if ([:typeof $1] != "str" || [:len $1] < 1) do={
			:error ($cPath.": Input lock duration for lock name '".$0."'");
		}
		:local hold [:tonum $1];
		:local wait 2; ##minimum 2 seconds
		:if ([:typeof $2] = "str" && [:len $2] > 0) do={
			:set wait [:tonum $2];
		}
		
		:global MtmFacts;
		:global MtmLocks;
		
		:local key ([/certificate scep-server otp generate minutes-valid=0 as-value]->"password");
		:local timeTool [($MtmFacts->"get") "getTools()->getTime()->getEpoch()"];
		:local cTime [($timeTool->"getCurrent")];
		:local tTime ($cTime + $wait);
		:local lock [:toarray ""];
		:local isDone 0;
		
		:while ($isDone = 0) do={
			:set lock ($MtmLocks->$0);
			:if ([:typeof $lock] = "nothing") do={
				:set ($MtmLocks->$0) {expire=($cTime + $hold);key=$key};
				:set isDone 1;
			} else={
				:if (($lock->"expire") < $cTime) do={
					:set ($MtmLocks->$0);
				} else={
					:if ($tTime > $cTime) do={
						:delay 0.2s;
						:set cTime [($timeTool->"getCurrent")];
					} else={
						:set isDone 1;
					}
				}
			}
		}
		:set lock ($MtmLocks->$0);
		:if ($key = ($lock->"key")) do={
			:return ($lock->"key");
		} else={
			:error ($cPath.": Failed to obtain lock name '".$0."'");
		}
	}
	:set ($s->"extendlock") do={

		:global MtmFacts;
		:global MtmLocks;
		:local cPath "DCS/Facts.rsc/extendlock";
		:if ([:typeof $0] != "str"  || [:len $0] < 1) do={
			:error ($cPath.": Input lock name invalid type '".[:typeof $0]."'");
		}
		:if ([:typeof $1] != "str"  || [:len $1] < 1) do={
			:error ($cPath.": Input lock key invalid for lock name '".$0."'");
		}
		:if ([:typeof $2] != "str" || [:len $2] < 1) do={
			:error ($cPath.": Input lock duration for lock name '".$0."'");
		}
		
		:local lock ($MtmLocks->$0);
		:if ([:typeof $lock] != "nothing") do={
			
			:local timeTool [($MtmFacts->"get") "getTools()->getTime()->getEpoch()"];
			:local cTime [($timeTool->"getCurrent")];
		
			:if ($1 != ($lock->"key")) do={
				:error ($cPath.": Failed to extend lock name '".$0."' key does not match");
			}
			:if ((($lock->"expire") - 2) < $cTime) do={
				:error ($cPath.": Failed to extend lock name '".$0."' expires in less than 2 seconds");
			}
			:set ($MtmLocks->$0) {expire=($cTime + [:tonum $2]);key=$1};
			
		} else={
			:error ($cPath.": Failed to extend lock name '".$0."', lock does not exist");
		}
		:return true;
	}
	:set ($s->"unlock") do={
		:global MtmLocks;
		:local cPath "DCS/Facts.rsc/unlock";
		:if ([:typeof $0] != "str"  || [:len $0] < 1) do={
			:error ($cPath.": Input lock name invalid type '".[:typeof $0]."'");
		}
		:if ([:typeof $1] != "str"  || [:len $1] < 1) do={
			:error ($cPath.": Input lock key invalid for lock name '".$0."'");
		}
		:local lock ($MtmLocks->$0);
		:if ([:typeof $lock] != "nothing") do={
			:if ($1 != ($lock->"key")) do={
				:error ($cPath.": Failed to unlock name '".$0."' key does not match");
			}
			:set ($MtmLocks->$0);
		}
		:return true;
	}

	##factories
	:set ($s->"getTools") do={
		:global MtmFaObjs;
		:if ([:typeof ($MtmFaObjs->"tools")] = "nothing") do={
			:global MtmFacts;
			:local mVal "";
			:set mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Facts/Tools.rsc");
			:set mVal [($MtmFacts->"importFile") $mVal];
		}
		:return ($MtmFaObjs->"tools");
	}
	:set ($s->"getModels") do={
		:global MtmFaObjs;
		:if ([:typeof ($MtmFaObjs->"models")] = "nothing") do={
			:global MtmFacts;
			:local mVal "";
			:set mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Facts/Models.rsc");
			:set mVal [($MtmFacts->"importFile") $mVal];
		}
		:return ($MtmFaObjs->"models");
	}
	:set MtmFacts $s;
	
	:local mVal "";
	##import the environment variables
	:set mVal [($MtmFacts->"importFile") $envFile];
	
	#static "objects"
	:global MtmFaObjs;
	:set MtmFaObjs [:toarray ""];
	
	:global MtmId;
	:set MtmId [:nothing];
	
	:global MtmIds1;
	:set MtmIds1 [:toarray ""];
	
	:global MtmIds2;
	:set MtmIds2 [:toarray ""];
}
