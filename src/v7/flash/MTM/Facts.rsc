:local cPath "MTM/Facts.rsc";
:global MtmFacts;
:if ($MtmFacts = nil) do={

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
			##file does not exist locally, try a remote load?
			:set mVal [($MtmFacts->"importRemoteFile") $0];
		} else= {
			:set mVal [($MtmFacts->"getEnv") "mtm.debug.enabled" false];
			:if ($mVal = true) do={
				#debugging mode
				[($MtmFacts->"echo") ("Starting file import: '".$0)];
				/import file-name=$0 verbose=no;
				[($MtmFacts->"echo") ("Completed file import: '".$0)];
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
		
		:set mVal [($MtmFacts->"getEnv") "mtm.remote.enabled" false];
		:if ($mVal != true) do={
			:error ($cPath.": Cannot import '".$0."' file does not exist locally and remote fetching is not enabled");
		}
		
		:local url "";
		:set url ($url.[($MtmFacts->"getEnv") "mtm.remote.host"]);
		:set url ($url.[($MtmFacts->"getEnv") "mtm.remote.url"]);
		:set url ($url."/".$0);
		
	#	$cmdStr		= "/tool fetch url=\"https://".$dacHost."/api/v1/Provisioning/Get/RouterOSv7/RpsInitial/".$devObj->getGuid()."/\"";
#							$cmdStr		.= " port=".$dacPort." mode=https user=\"".getenv("dd-dac.api.user")."\"";
#							$cmdStr		.= " password=\"".getenv("dd-dac.api.pass")."\"";
#							$cmdStr		.= " http-method=get output=file as-value dst-path=flash/RPS/primary.rsc";


		:put ($url);
			:put ([:typeof $url]);
			
			:error ($cPath.": Cannot import '".$0."' file does not exist locally and remote fetching is not enabled");
		:if ([:len [/file find where name=$0]] = 0) do={
			##file does not exist locally, are we allowed to fetch from a remote host?
			:set mVal [($MtmFacts->"getEnv") "mtm.remote.enabled" false];
			:put ($mVal);
			:put ([:typeof $mVal]);
			:if ($mVal = true) do={
				:put ("Contains Merlin");
			} else={
				:error ($cPath.": Cannot import '".$0."' file does not exist locally and remote fetching is not enabled");
			}
		}
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
	
	:set MtmFacts $s;
	
	:local mVal "";
	##import the environment variables
	:set mVal [($MtmFacts->"importFile") $envFile];
	
	#static "objects"
	:global MtmFaObjs;
	:set $MtmFaObjs [:toarray ""];
}
