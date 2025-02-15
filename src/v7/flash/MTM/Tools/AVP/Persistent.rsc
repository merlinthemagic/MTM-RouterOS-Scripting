:local cPath "MTM/Tools/AVP/Persistent.rsc";

:global MtmAvpPersist;
:global MtmFacts;
:local mVal "";
:local mVals [:toarray ""];
:set mVal [($MtmFacts->"getEnv") "mtm.root.path"]; ##Using MTM root path because it must be persistent
:local dirTool [($MtmFacts->"get") "getTools()->getFileSystem()->getDirectories()"];
:local dirPath ($mVal."/AVPs/Persist");
:set mVal [($dirTool->"create") $dirPath (false)];
:set mVals [($dirTool->"list") $dirPath];

##Se predefined Attribute value pairs
:local avps [:toarray ""];
:set ($avps->"avp.file.dir") $dirPath;

:if ([:len $mVals] > 0) do={
	:local fileTool [($MtmFacts->"get") "getTools()->getFileSystem()->getFiles()"];
	:local strTool [($MtmFacts->"get") "getTools()->getTypes()->getStrings()"];
	:local rObj [:toarray ""];
	:local mPos 0;
	:local mAttr "";
	:foreach item in=$mVals do={
		:if (($item->"name") ~ "^avps") do={
			:set mVal [($fileTool->"getContent") ($dirPath."/".($item->"name"))]; ##empty files return nil
			:if ([:len $mVal] > 0) do={
				:set mVal [($strTool->"split") $mVal ("\n")];
				:foreach avp in=$mVal do={
					:if ([:len $avp] > 0) do={
						:set mPos [:find $avp "="];
						:if ([:typeof $mPos] = "num") do={
							
							:set mAttr [:pick $avp 0 $mPos];
							
							:set rObj [:toarray ""];
							:set ($rObj->"key") $mAttr;
							:set ($rObj->"val") [:pick $avp ($mPos + 1) [:len $avp]];
							:set ($rObj->"file") ($item->"name");

							:set ($avps->$mAttr) $rObj;
						}
					}
				}
			}
		}
	}
}
:set MtmAvpPersist $avps;


:local s [:toarray ""];

:set ($s->"get") do={

	:local cPath "MTM/Tools/AVP/Persistent.rsc/get";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input key must be string, but has invalid type '".[:typeof $0]."'");
	}
	:if ([:typeof [:find $0 "="]] = "num") do={
		:error ($cPath.": Input key cannot contain '=' sign: '".$0."'");
	}
	:local mThrow false;
	:if ([:typeof $1] != "nothing") do={
		:if ([:typeof $1] = "bool") do={
			:set mThrow $1;
		} else={
			:error ($cPath.": Throw on not set must be boolean, but has invalid type '".[:typeof $1]."'");
		}
	}
	:global MtmAvpPersist;
	:if ([:typeof ($MtmAvpPersist->$0)] != "nothing") do={
		:return ($MtmAvpPersist->$0->"val");
	} else={
		:if ($mThrow = true) do={
			:error ($cPath.": Attribute: '".$0."' does not exist");
		} else={
			:return [:nothing];
		}
	}
}
:set ($s->"set") do={

	:local cPath "MTM/Tools/AVP/Persistent.rsc/set";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input key must be string, but has invalid type '".[:typeof $0]."'");
	}
	:if ([:typeof [:find $0 "="]] = "num") do={
		:error ($cPath.": Input key cannot contain '=' sign: '".$0."'");
	}
	:if ([:typeof $1] != "str") do={
		:error ($cPath.": Input value must be string, but has invalid type '".[:typeof $1]."'");
	}
	
	##Check if key exists
	:global MtmAvpPersist;
	:if ([:typeof ($MtmAvpPersist->$0)] != "nothing") do={
		:if (($MtmAvpPersist->$0->"val") = $1) do={
			##no change in value
			:return true;
		}
	}

	#AVP does not exist, create it
	:global MtmFacts;
	:local fileTool [($MtmFacts->"get") "getTools()->getFileSystem()->getFiles()"];
	:local strTool [($MtmFacts->"get") "getTools()->getTypes()->getStrings()"];

	:local iAttr [($strTool->"trim") $0];
	:local iVal [($strTool->"trim") $1];
	
	:local mVal "";
	:local mPos 0;
	:local mAttr "";
	:local mLine ($iAttr."=".$iVal);
	:local mLen [:len $mLine];
	:local fileName "";
	
	##Get a lock so only a single process writes at any given time
	:local lockHold "10";
	:local lockWait "2";
	:local procName "setAvpPersist";
	:local lockKey [($MtmFacts->"lock") $procName $lockHold $lockWait];
	
	##Check again now that we have a lock
	:global MtmAvpPersist;
	:if ([:typeof ($MtmAvpPersist->$iAttr)] != "nothing") do={
		:if (($MtmAvpPersist->$iAttr->"val") = $iVal) do={
			##no change in value
			:set mVal [($MtmFacts->"unlock") $procName $lockKey];
			:return true;
		} else={
			##need to check if the current file will accommodate the size of the new value
			:set fileName ($MtmAvpPersist->$iAttr->"file");
		}
	}
	

	:local dirPath (($MtmAvpPersist->"avp.file.dir")."/");
	:local filePath "";
	:local nextFile ""; ##file slot that is open, if we need it
	:if ($fileName = "") do={
	
		:local curFile "";
		:for x from=1 to=10 do={
			:if ($fileName = "") do={
				:set curFile ("avps".$x.".txt");
				:set filePath ($dirPath.$curFile);
				:if ([($fileTool->"getExists") $filePath] = true) do={
					:if (([($fileTool->"getSize") $filePath] + $mLen) < 4000) do={
						##Existing file is small enough that we can use it to store this AVP
						:set fileName $curFile;
					}
				} else={
					:if ($nextFile = "") do={
						##File does not exist, we can use it if needed
						:set nextFile $curFile;
					}
				}
			}
		}
	}
	
	:if ($fileName = "") do={
		:if ($nextFile != "") do={
			##create a new file and use it
			:set filePath ($dirPath.$nextFile);
			:set mVal [($fileTool->"create") $filePath];
			:set fileName $nextFile;
		} else={
			:error ($cPath.": No suitable AVP file available/all full on path: '".$dirPath."'");
		}
	}
	##Should check for free disk space, but that gets complicated depending on mount point
	
	:set filePath ($dirPath.$fileName);
	:local mData $mLine;
	
	:do {
	
		:set mVal [($fileTool->"getContent") $filePath];
		:if ([:len $mVal] > 0) do={
			:set mVal [($strTool->"split") $mVal ("\n")];
			:foreach avp in=$mVal do={
				:if ([:len $avp] > 0) do={
					:set mPos [:find $avp "="];
					:if ([:typeof $mPos] = "num") do={
						:set mAttr [:pick $avp 0 $mPos];
						:if ($mAttr != $iAttr) do={
							:set mData ($mData."\n".$avp);
						}
					}
				}
			}
		}
		
		:set mVal [($fileTool->"setContent") $filePath $mData];
	
		:local rObj [:toarray ""];
		:set ($rObj->"key") $iAttr;
		:set ($rObj->"val") $iVal;
		:set ($rObj->"file") $fileName;
		:set ($MtmAvpPersist->$iAttr) $rObj;
	
		:set mVal [($MtmFacts->"unlock") $procName $lockKey];
		:return true;
	
	} on-error={
		:set mVal [($MtmFacts->"unlock") $procName $lockKey];
		:if ([($fileTool->"getExists") $filePath] = false) do={
			##If any of the AVP files are deleted seperate from this class we fail each time the cache is used, need this check so a missing file does not permanetly block
			:set ($MtmAvpPersist->$iAttr);
			:error ($cPath." AVP file: '".$filePath."' was deleted by someone outside this class");
		} else={
			:log/error ($cPath. ": Encountered an error");
		}
	}
}
:set ($s->"delete") do={

	:local cPath "MTM/Tools/AVP/Persistent.rsc/delete";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input key must be string, but has invalid type '".[:typeof $0]."'");
	}
	:if ([:typeof [:find $0 "="]] = "num") do={
		:error ($cPath.": Input key cannot contain '=' sign: '".$0."'");
	}
	:local mThrow false;
	:if ([:typeof $1] != "nothing") do={
		:if ([:typeof $1] = "bool") do={
			:set mThrow $1;
		} else={
			:error ($cPath.": Throw on not set must be boolean, but has invalid type '".[:typeof $1]."'");
		}
	}
	
	##Check if key exists
	:global MtmAvpPersist;
	:if ([:typeof ($MtmAvpPersist->$0)] = "nothing") do={
		:if ($mThrow = true) do={
			:error ($cPath.": Attribute: '".$0."' does not exist");
		}
		:return true;
	}

	#AVP does exist
	:global MtmFacts;
	
	##Get a lock so only a single process writes at any given time
	:local lockHold "10";
	:local lockWait "2";
	:local procName "setAvpPersist";
	:local lockKey [($MtmFacts->"lock") $procName $lockHold $lockWait];
	
	:local strTool [($MtmFacts->"get") "getTools()->getTypes()->getStrings()"];
	:local iAttr [($strTool->"trim") $0];
	:local mVal "";
	:local mAttr "";
	
	##Check again now that we have a lock
	:global MtmAvpPersist;
	:if ([:typeof ($MtmAvpPersist->$iAttr)] = "nothing") do={
		:set mVal [($MtmFacts->"unlock") $procName $lockKey];
		:if ($mThrow = true) do={
			:error ($cPath.": Attribute: '".$0."' does not exist");
		}
		:return true;
	}
	
	##AVP still exists
	:local dirPath (($MtmAvpPersist->"avp.file.dir")."/");
	:local rObj ($MtmAvpPersist->$iAttr);
	:local filePath ($dirPath.($rObj->"file"));
	:local fileTool [($MtmFacts->"get") "getTools()->getFileSystem()->getFiles()"];
	
	:local mData "";
	:local mPos 0;

	:do {
	
		:set mVal [($fileTool->"getContent") $filePath];
		:if ([:len $mVal] > 0) do={
			:set mVal [($strTool->"split") $mVal ("\n")];
			:foreach avp in=$mVal do={
				:if ([:len $avp] > 0) do={
					:set mPos [:find $avp "="];
					:if ([:typeof $mPos] = "num") do={
						:set mAttr [:pick $avp 0 $mPos];
						:if ($mAttr != $iAttr) do={
							:set mData ($mData.$avp."\n");
						}
					}
				}
			}
		}
		:if ([:len $mData] > 0) do={
			:set mVal [($fileTool->"setContent") $filePath $mData];
		} else={
			:set mVal [($fileTool->"delete") $filePath];
		}
		:set ($MtmAvpPersist->$iAttr);
		:set mVal [($MtmFacts->"unlock") $procName $lockKey];
		:return true;
	
	} on-error={
		:set mVal [($MtmFacts->"unlock") $procName $lockKey];
		:if ([($fileTool->"getExists") $filePath] = false) do={
			##If any of the AVP files are deleted seperate from this class we fail each time the cache is used, need this check so a missing file does not permanetly block
			:set ($MtmAvpPersist->$iAttr);
			:error ($cPath." AVP file: '".$filePath."' was deleted by someone outside this class");
		} else={
			:log/error ($cPath.": Encountered an error");
		}
	}
}
:global MtmToolAvps1;
:set ($MtmToolAvps1->"persist") $s;