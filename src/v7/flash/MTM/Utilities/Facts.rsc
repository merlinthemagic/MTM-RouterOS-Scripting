:local cPath "MTM/Utilities/Facts.rsc";
:local mVal "";

:global MtmUtilitiesLoaded;
:if ([:typeof $MtmUtilitiesLoaded] = "nothing") do={
	##Load the Enable.rsc file before using Facts
	:local hintFile "mtmUtilitiesRoot.hint";
	:local mVal [/file/find name~$hintFile];
	:if ([:len $mVal] != 1) do={
	    :error ($cPath.": Hint file: '".$hintFile."' is invalid");
	}
	:set mVal [/file/get $mVal name];
	:set mVal [/import file-name=([:pick $mVal 0 ([:len $mVal] - (([:len $hintFile]) + 1))]."/Enable.rsc") verbose=no];
}

:global MtmFacts;
:if ([:typeof $MtmFacts] = "nothing") do={

	#static "objects"
	:global MtmFaObjs;
	:set MtmFaObjs [:toarray ""];
	
	:global MtmEnvs;
	:set MtmEnvs [:toarray ""];
	:set ($MtmEnvs->"mtm.debug.enabled") false; ##pre loading env file default value, if MTM fails to load at all set to true
	
	:global MtmId;
	:set MtmId [:nothing];
	
	:global MtmIds1;
	:set MtmIds1 [:toarray ""];
	
	:global MtmIds2;
	:set MtmIds2 [:toarray ""];
	
	##Setup function
	:local s [:toarray ""];

	:set ($s->"setDebug") do={
		:local cPath "MTM/Utilities/Facts.rsc/setDebug";
		:if ([:typeof $0] != "bool") do={
			:error ($cPath.": Parameter must be true or false");
		}
		:global MtmFacts;
		:local mVal [($MtmFacts->"setEnv") "mtm.debug.enabled" ($0)];
		:if ($0 = true) do={
			:set mVal [($MtmFacts->"echo") ("Debug set ON")];
		} else={
			:set mVal [($MtmFacts->"echo") ("Debug set OFF")];
		}
		:return true;
	}
	:set ($s->"getDebug") do={
		:local cPath "MTM/Utilities/Facts.rsc/getDebug";
		:global MtmFacts;
		:return [($MtmFacts->"getEnv") "mtm.debug.enabled"];
	}
	:set ($s->"loadEnvFile") do={
		:local cPath "MTM/Utilities/Facts.rsc/loadEnvFile";
		:if ([:len $0] = 0 || [:typeof $0] != "str") do={
			:error ($cPath.": File path is mandatory, must be string value, not: '".[:typeof $1]."'");
		}
		:if ([:len [/file/find name=$0]] = 0) do={
			:error ($cPath.": Environment file does not exist: '".$0."'");
		}
		:local filePath $0;
		:local override true;
		:if ([:typeof $1] = "bool") do={
			##if this is failing for you call this method with the bool in parentheses e.g. (false)
			:set override $1;
		}
		
		:global MtmFacts;
		:local fileTool [($MtmFacts->"get") "getTools()->getFileSystem()->getFiles()"];
		:local strTool [($MtmFacts->"get") "getTools()->getTypes()->getStrings()"];

		:local mVal "";
		:local mAttr "";
		:local mValue "";
		:local pos 0;
		:local raw [($fileTool->"getContent") $filePath];
		:local lines [($strTool->"split") $raw ("\n")];

		:foreach line in=$lines do={
			:set line [($strTool->"trim") $line];
			:if ([:len $line] > 0 && [:pick $line 0 1] != "#") do={
			
				:set pos [:find $line "=" 0];
				:if ([:typeof $pos] = "num") do={
					:set mAttr [:pick $line 0 $pos];
					:set mValue [:pick $line ($pos + 1) ([:len $line])];
					
					:if ([:typeof $mValue] = "str") do={
						##string bool from env files should be converted to boolean
						:if ($mValue = "true") do={
							:set mValue true;
						} else={
							:if ($mValue = "false") do={
								:set mValue false;
							}
						}
					}
					:if ($override = true || [:typeof [($MtmFacts->"getEnv") $mAttr (false)]] = "nil") do={
						:set mVal [($MtmFacts->"setEnv") $mAttr $mValue];
					}
				}
			}
		}
		:return true;
	}
	:set ($s->"setEnv") do={
		:local cPath "MTM/Utilities/Facts.rsc/setEnv";
		:global MtmEnvs;
		:if ([:len $0] = 0 || [:typeof $0] != "str") do={
			:error ($cPath.": Key is mandatory, must be string value, not: '".[:typeof $1]."'");
		}
		:if ([:typeof $1] != "str" && [:typeof $1] != "num" && [:typeof $1] != "bool") do={
			:error ($cPath.": Value for key: '".$0."' must be a string, number or boolean value, not: '".[:typeof $1]."'");
		}
		:set ($MtmEnvs->$0) $1;
		:return true;
	}
	:set ($s->"getEnv") do={
		:local cPath "MTM/Utilities/Facts.rsc/getEnv";
		:global MtmEnvs;
		:if ([:len $0] = 0 || [:typeof $0] != "str") do={
			:error ($cPath.": Key is mandatory, must be string value");
		}
		:local mVal ($MtmEnvs->$0);
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
		:local cPath "MTM/Utilities/Facts.rsc/getNullFile";
		:local fName "mtmNull.txt";
		:if ([:len [/file/find where name=$fName]] < 1) do= {
			##Cannot use file tool as it depends on this file
			:local mVal [/file/print file=$fName];
			:local isDone false;
			:local mCount 0;
			:while ($isDone = false) do={
				:if ([:len [/file/find where name=$fName]] < 1) do= {
					:if ($mCount < 6) do= {
						:delay 0.5s;
					} else={
						:error ($cPath.": Failed to create null file");
					}
				} else={
					:set isDone true;
				}
				:set mCount ($mCount + 1);
			}
		}
		:return $fName;
	}
	:set ($s->"importFile") do={
		:local cPath "MTM/Utilities/Facts.rsc/importFile";
		:if ([:len $0] = 0 || [:typeof $0] != "str") do={
			:error ($cPath.": File path is mandatory, must be string value");
		}
		:global MtmFacts;
		:local isDebug [($MtmFacts->"getDebug")];
		:local mVal "";
		
		:if ($isDebug = true) do={
			#debugging mode
			:set mVal [($MtmFacts->"echo") ("Starting file import: '".$0."'")];
		}
		:if ([:len [/file/find where name=$0]] = 0) do={
			:if ($isDebug = true) do={
				:set mVal [($MtmFacts->"echo") ("File: '".$0."' does not exist locally")];
			}
			:set mVal [($MtmFacts->"getEnv") "mtm.remote.enabled" (false)];
			:if ($mVal != true) do={
				:error ($cPath.": Cannot import '".$0."' file does not exist locally and remote fetching is not enabled");
			} else={
				##file does not exist locally, try a remote load
				:set mVal [($MtmFacts->"importRemoteFile") $0];
			}
			
		} else= {
			:if ($isDebug = true) do={
				##dont do verbose or it will print the script
				/import file-name=$0 verbose=no;
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
		
		:if ($isDebug = true) do={
			#debugging mode
			:set mVal [($MtmFacts->"echo") ("Completed file import: '".$0."'")];
		}
		:return true;
	}
	:set ($s->"importRemoteFile") do={
		:local cPath "MTM/Utilities/Facts.rsc/importRemoteFile";
		:global MtmFacts;
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

		:set mVal [($MtmFacts->"getEnv") "mtm.remote.save.enabled" (false)];
		:if ($mVal = true) do={
			:set dstPath [($MtmFacts->"getEnv") "mtm.remote.save.path" (false)];
			:set dstPath ($dstPath."/".$0);
		} else={
			:set dstPath "remoteLoad.rsc";
		}
		
		:if ($dstPath = "remoteLoad.rsc" || [:len [/file/find where name=$dstPath]] = 0) do={
			#file does not exist in the local cache, get it
			:set mVal [:tostr [($MtmFacts->"getEnv") "mtm.remote.port" (false)]];
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
				:set mVal [($MtmFacts->"getEnv") "mtm.remote.cert.valid" (false)];
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
				:set mVal [/tool/fetch check-certificate=$chkCert url=$url mode=$mode port=$port user=$user password=$pass http-method=get output=file as-value dst-path=$dstPath];
				#success
			} on-error={
				##there is no error catching possible..
				:error ($cPath.": Failed to load remote file '".$0."'");
			}
		} else={
			#file exists on the system in the remove save folder
		}
		:set mVal [($MtmFacts->"importFile") $dstPath];
		:return true;
	}
	:set ($s->"get") do={
		:local cPath "MTM/Utilities/Facts.rsc/get";
		:global MtmFacts;
		:if ([:typeof $0] != "str") do={
			:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
		}
		:local curObj $MtmFacts;
		:if ([:typeof $1] = "array") do={
			:set curObj $1;
		}
		
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
		:local cPath "MTM/Utilities/Facts.rsc/parseCall";
		:global MtmFacts;
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
		:local cPath "MTM/Utilities/Facts.rsc/lock";
		:if ([:typeof $0] != "str"  || [:len $0] < 1) do={
			:error ($cPath.": Input lock name invalid type '".[:typeof $0]."'");
		}
		
		:local hold 0;
		:if ([:typeof $1] = "num") do={
			:set hold $1;
		} else={
			:if ([:typeof $1] = "str" && [:len $1] > 0) do={
				:set hold [:tonum $1];
			}
		}
		:if ($hold < 2) do={
			:error ($cPath.": Input lock duration for lock name '".$0."' too short");
		}
		
		:local wait 0;
		:if ([:typeof $2] = "num") do={
			:set wait $1;
		} else={
			:if ([:typeof $2] = "str" && [:len $2] > 0) do={
				:set wait [:tonum $2];
			}
		}
		:if ($hold < 0) do={
			:error ($cPath.": Input lock wait for lock name '".$0."' cannot be negative");
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
		:local cPath "MTM/Utilities/Facts.rsc/extendlock";
		:global MtmFacts;
		:global MtmLocks;
		:if ([:typeof $0] != "str"  || [:len $0] < 1) do={
			:error ($cPath.": Input lock name invalid type '".[:typeof $0]."'");
		}
		:if ([:typeof $1] != "str"  || [:len $1] < 1) do={
			:error ($cPath.": Input lock key invalid for lock name '".$0."'");
		}
		
		:local hold 0;
		:if ([:typeof $2] = "num") do={
			:set hold $2;
		} else={
			:if ([:typeof $2] = "str" && [:len $2] > 0) do={
				:set hold [:tonum $2];
			}
		}
		:if ($hold < 2) do={
			:error ($cPath.": Input lock duration for lock name '".$0."' too short");
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
			:set ($MtmLocks->$0) {expire=($cTime + $hold);key=$1};
			
		} else={
			:error ($cPath.": Failed to extend lock name '".$0."', lock does not exist");
		}
		:return true;
	}
	:set ($s->"lockremain") do={
		:local cPath "MTM/Utilities/Facts.rsc/lockremain";
		:global MtmLocks;
		:if ([:typeof $0] != "str"  || [:len $0] < 1) do={
			:error ($cPath.": Input lock name invalid type '".[:typeof $0]."'");
		}
		:local remain 0;
		:local lock ($MtmLocks->$0);
		:if ([:typeof $lock] != "nothing") do={
			:global MtmFacts;
			:local timeTool [($MtmFacts->"get") "getTools()->getTime()->getEpoch()"];
			:set remain (($lock->"expire") - [($timeTool->"getCurrent")]);
		}
		:return $remain;
	}
	:set ($s->"unlock") do={
		:local cPath "MTM/Utilities/Facts.rsc/unlock";
		:global MtmLocks;
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

	#set the current ROS version
	
	:local mVal "";
	:set mVal [($MtmFacts->"setEnv") "major" 0];
	:set mVal [($MtmFacts->"setEnv") "minor" 0];
	:set mVal [($MtmFacts->"setEnv") "patch" 0];
	:set mVal [($MtmFacts->"setEnv") "preInfo" ""]; #pre release info
	
	:local mVer [/system/resource/get version];
	:local mPos 0;
	:local found 0;
	
	##find channel
	:set mPos [:find $mVer "("];
	:if ([:typeof $mPos] = "num") do={
		:set mVal [($MtmFacts->"setEnv") "channel" ([:pick $mVer ($mPos + 1) ([:len $mVer] - 1)])];
		:set mVer [:pick $mVer 0 ($mPos - 1)]; #-1 to get rid of the space
	}
	
	##find pre release type
	:if ($found = 0) do={
		:set mPos [:find $mVer "rc"];
		:if ([:typeof $mPos] = "num") do={
			:set mVal [($MtmFacts->"setEnv") "preInfo" ([:pick $mVer $mPos ([:len $mVer])])];
			:set mVer [:pick $mVer 0 $mPos];
			:set found 1;
		}
	}
	:if ($found = 0) do={
		:set mPos [:find $mVer "beta"];
		:if ([:typeof $mPos] = "num") do={
			:set mVal [($MtmFacts->"setEnv") "preInfo" ([:pick $mVer $mPos ([:len $mVer])])];
			:set mVer [:pick $mVer 0 $mPos];
			:set found 1;
		}
	}
	:if ($found = 0) do={
		:set mPos [:find $mVer "alpha"];
		:if ([:typeof $mPos] = "num") do={
			:set mVal [($MtmFacts->"setEnv") "preInfo" ([:pick $mVer $mPos ([:len $mVer])])];
			:set mVer [:pick $mVer 0 $mPos];
			:set found 1;
		}
	}
	
	:set mPos [:find $mVer "."];
	:if ([:typeof $mPos] = "num") do={
		:set mVal [($MtmFacts->"setEnv") "major" ([:tonum [:pick $mVer 0 $mPos]])];
		:set mVer [:pick $mVer ($mPos + 1) [:len $mVer]];
		:set mPos [:find $mVer "."];
		:if ([:typeof $mPos] = "num") do={
			:set mVal [($MtmFacts->"setEnv") "minor" ([:tonum [:pick $mVer 0 $mPos]])];
			:set mVer [:pick $mVer ($mPos + 1) [:len $mVer]];
			:if ([:len $mVer] > 0) do={
				:set mVal [($MtmFacts->"setEnv") "patch" ([:tonum $mVer])];
			}
		} else={
			:if ([:len $mVer] > 0) do={
				:set mVal [($MtmFacts->"setEnv") "minor" ([:tonum $mVer])];
			}
		}
	}
}
