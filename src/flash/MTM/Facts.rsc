:global MtmFacts;
:if ($MtmFacts = nil) do={

	:local s [:toarray ""];
	:set ($s->"apps") [:toarray ""];
	:set ($s->"debug") false;
	:set ($s->"a") [:toarray ""];
	:set ($s->"c") [:toarray ""];

	:if ([:len [/file find where name=flash/MTM/Facts.rsc]] > 0) do={
		:set ($s->"a"->"rootPath") "flash/";
		:set ($s->"a"->"mtmPath") "flash/MTM/";
		:set ($s->"a"->"mtmTempFile") "mtmTmp.txt";
		:set ($s->"a"->"mtmErrFile") "mtmErr.txt";
		:set ($s->"a"->"mtmExFile") "mtmException.txt";
		:set ($s->"a"->"mtmObjFile") "mtmObj.txt";
		:set ($s->"a"->"mtmNullFile") "mtmNull.txt";
		:set ($s->"a"->"mtmImportFile") "mtmImport.txt";
		:set ($s->"a"->"mtmTempVar") "";
	} else={
		:set MtmFacts;
		:error "MtmFacts: Cannot determine the root path";
	}
	
	#clear class stores, include "init" so status can seee if global was wiped
	
	#core factories
	:global MtmF;
	:set MtmF [:toarray ""];
	
	#Object factory cache
	:global MtmOFC;
	:set MtmOFC [:toarray ""];
	
	#static methods too large for partial loading, e.g. md5 hashing
	:global MtmSM0;
	:set MtmSM0 [:toarray ""];

	#apps
	:global MtmA;
	:set MtmA [:toarray ""];

	#system
	:global MtmS;
	:set MtmS [:toarray ""];

	:set ($s->"setDebug") do={
		:global MtmFacts;
		:local enable;
		:if ($0 = true) do={
			:set enable true;
		} else={
			:set enable false;
		}
		
		:if ($MtmFacts->"debug" != $enable) do={
			:set ($MtmFacts->"debug") $enable;
			:if ($enable = true) do={
				:put ("Debugging changed state to: enabled");
			} else={
				:put ("Debugging changed state to: disabled");
			}
		}
		:return true;
	}
	:set ($s->"getSystem") do={
		:global MtmS;
		:local classId "fact-system";
		:if ($MtmS->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Factories/System.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmS->$classId);
	}
	:set ($s->"getObjects") do={
		:global MtmF;
		:local classId "fact-objs";
		:if ($MtmF->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Factories/Objects.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmF->$classId);
	}
	:set ($s->"getInterfaces") do={
		:global MtmFacts;
		:local sysId "fact-ifs";
		:local objFact [($MtmFacts->"getObjects")];
		:local sObj [($objFact->"getStore") $sysId];
		:if ($sObj->"obj"->($sObj->"hash") = nil) do={
			:local paths [:toarray ""];
			:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Factories/Base.rsc");
			:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Factories/Interfaces/Factory/Part1.rsc");
			:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Factories/Interfaces/Factory/Part2.rsc");
			:set ($paths->3) ([($MtmFacts->"getMtmPath")]."Factories/Zstance.rsc");
			:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
		}
		:return ($sObj->"obj"->($sObj->"hash"));
	}
	:set ($s->"getTools") do={
		:global MtmFacts;
		:local sysId "fact-tools";
		:local objFact [($MtmFacts->"getObjects")];
		:local sObj [($objFact->"getStore") $sysId];
		:if ($sObj->"obj"->($sObj->"hash") = nil) do={
			:local paths [:toarray ""];
			:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Factories/Base.rsc");
			:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Factories/Tools/Factory/Part1.rsc");
			:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Factories/Tools/Factory/Part2.rsc");
			:set ($paths->3) ([($MtmFacts->"getMtmPath")]."Factories/Tools/Factory/Part3.rsc");
			:set ($paths->4) ([($MtmFacts->"getMtmPath")]."Factories/Zstance.rsc");
			:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
		}
		:return ($sObj->"obj"->($sObj->"hash"));
	}
	:set ($s->"getUtilities") do={
		:global MtmFacts;
		:local sysId "fact-utils";
		:local objFact [($MtmFacts->"getObjects")];
		:local sObj [($objFact->"getStore") $sysId];
		:if ($sObj->"obj"->($sObj->"hash") = nil) do={
			:local paths [:toarray ""];
			:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Factories/Base.rsc");
			:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Factories/Utilities/Factory/Part1.rsc");
			:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Factories/Zstance.rsc");
			:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
		}
		:return ($sObj->"obj"->($sObj->"hash"));
	}
	:set ($s->"getRadius") do={
		:global MtmFacts;
		:local sysId "fact-radius";
		:local objFact [($MtmFacts->"getObjects")];
		:local sObj [($objFact->"getStore") $sysId];
		:if ($sObj->"obj"->($sObj->"hash") = nil) do={
			:local paths [:toarray ""];
			:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Factories/Base.rsc");
			:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Factories/Radius/Factory/Part1.rsc");
			:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Factories/Zstance.rsc");
			:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
		}
		:return ($sObj->"obj"->($sObj->"hash"));
	}
	:set ($s->"getIP") do={
		:global MtmFacts;
		:local sysId "fact-ip";
		:local objFact [($MtmFacts->"getObjects")];
		:local sObj [($objFact->"getStore") $sysId];
		:if ($sObj->"obj"->($sObj->"hash") = nil) do={
			:local paths [:toarray ""];
			:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Factories/Base.rsc");
			:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Factories/IP/Factory/Part1.rsc");
			:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Factories/Zstance.rsc");
			:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
		}
		:return ($sObj->"obj"->($sObj->"hash"));
	}
	:set ($s->"getApp") do={
		:global MtmFacts;
		:global MtmA;
		:local method "MtmFacts->getApp";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="App name is mandatory"];
		}
		:if ($MtmA->$0 = nil) do={
			:local appObj [:toarray ""];
			:set ($appObj->"alive") false;
			:set ($appObj->"keepAlive") 0;
			:set ($appObj->"lastAlive") 0;
			:set ($MtmA->$0) $appObj;
		}
		:return ($MtmA->$0);
	}
	:set ($s->"execute") do={
		
		:global MtmFacts;
		:local method "MtmFacts->execute";
		:if ($nsStr = nil) do={
			##this is sometimes a problem if the script you are executing is not wrapped in { } 
			[($MtmFacts->"throwException") method=$method msg="Name space string is mandatory" logFile=true];
		}
		:local curObj $MtmFacts;
		:if ($baseObj != nil) do={
			:set curObj $baseObj;
		}
		:local pos;
		:local pMethod;
		:local rMethod;
		:local rCmd;
		:local rPath $nsStr;
		:local rLen [:len $rPath];
		:local aLen;
		:local args;
		:local fCall;
		:local isDone 0;
		:while ($isDone = 0) do={
			:set pos [:find $rPath "->"];
			:if ([:typeof $pos] = "num") do={
				:set pMethod [($MtmFacts->"parseMethodString") str=[:pick $rPath 0 $pos]];
				:set rPath [:pick $rPath ($pos + 2) $rLen];
				:set rLen [:len $rPath];
			} else={
				:set pMethod [($MtmFacts->"parseMethodString") str=$rPath];
				:set isDone 1;
			}
			:if ($curObj = "") do={
				[($MtmFacts->"throwException") method=$method msg=("Cannot call: '".$pMethod->"method"."' in '".$nsStr."', previous call failed")];
			}
			:set rMethod ($pMethod->"method");
			:if ($curObj->"$rMethod" = nil) do={
				[($MtmFacts->"throwException") method=$method msg=("Cannot call: '".$pMethod->"method"."' in '".$nsStr."', method does not exist")];
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
								[($MtmFacts->"throwException") method=$method msg=("Only support upto 4 parameters")];
							}
						}
					}
				}
			}
		}
		:return $curObj;
	}
	:set ($s->"parseMethodString") do={
		
		:global MtmFacts;
		:local method "MtmFacts->parseMethodString";
		:if ($str = nil) do={
			[($MtmFacts->"throwException") method=$method msg="String is mandatory"];
		}
		
		:local rData [:toarray ""];
		:set ($rData->"method") "";
		:set ($rData->"args") [:toarray ""];

		:local toolFact [($MtmFacts->"getTools")];
		:local strTool [($toolFact->"getStrings")];
		:local rStr [($strTool->"trim") str=$str];
		
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
				[($MtmFacts->"throwException") method=$method msg=("Malformed method in: '$str'")];
			}
			:set rStr [:pick $rStr ($pos + 1) ($len - 1)];
			:set rStr [($strTool->"trim") str=$rStr];
			:set len [:len $rStr];
			:if ($len > 0) do={
				#there is arguments in the method call
				:local argCount 0;
				:local isDone 0;
				:while ($isDone = 0) do={
					:set pos [:find $rStr "='"];
					:if ([:typeof $pos] = "num") do={
						:set attr [:pick $rStr 0 $pos];
						:set attr [($strTool->"trim") str=$attr];
						:set rStr [:pick $rStr ($pos + 2) $len];
						:set pos [:find $rStr "'"];
						:if ([:typeof $pos] = "num") do={
							:set len [:len $rStr];
							:set val [:pick $rStr 0 $pos];
							:set val [($strTool->"trim") str=$val];
							
							:set ($rData->"args"->$argCount) [:toarray ""];
							:set ($rData->"args"->$argCount->"index") $argCount;
							:set ($rData->"args"->$argCount->"name") $attr;
							:set ($rData->"args"->$argCount->"value") $val;
							:set argCount ($argCount + 1);
							:set rStr [:pick $rStr ($pos + 1) $len];
							
						} else={
							[($MtmFacts->"throwException") method=$method msg=("Malformed arguments in: '$str'")];
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
	:set ($s->"importFile") do={
		:global MtmFacts;
		:local method "MtmFacts->importFilePath";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="File path is mandatory"];
		}
		:local path [:tostr $0];
		:if ($MtmFacts->"debug" = true) do={
			#debugging mode, make all verbose
			[($MtmFacts->"setDebugMsg") ("Initiating file import: ".$path)];
			/import file-name=$path;
			[($MtmFacts->"setDebugMsg") ("Completed file import: ".$path."\n")];
		} else={
		
			#delegate job to sub process
			:local scr (":put ".$path."; /import file-name=".$path);
			:local jobId [:execute script=$scr file=([($MtmFacts->"getMtmImportFile")])];
			
			:local tCount 50; ##need more than 10 secs to run an import?
			:local jobType "";
			:while ($tCount > 0) do={
				:set jobType [/system script job get $jobId type];
				:if ([:typeof $jobType] = "nil") do={
					:set tCount 0;
				} else={
					:if ($tCount > 0) do={
						:set tCount ($tCount - 1);
						:delay 0.2s;
					} else={
						[($MtmFacts->"throwException") method=$method msg=("Importing: '$path' did not finish in time")];
					}
				}
			}
		}
		:return 1;
	}
	:set ($s->"setDebugMsg") do={
		:put ("Debug: ".$0);
		:return 1;
	}
	:set ($s->"getMtmPath") do={
		:global MtmFacts;
		:return ($MtmFacts->"a"->"mtmPath");
	}
	:set ($s->"getMtmObjFile") do={
		#TODO: multiple scripts using the same obj file without locking is recipe for disaster
		#MTM uses this temp file internally for instancing large object files, users should not use this file
		:global MtmFacts;
		:return ($MtmFacts->"a"->"mtmObjFile");
	}
	:set ($s->"getMtmTempFile") do={
		#TODO: multiple scripts using the same temp file without locking is recipe for disaster
		#MTM uses this temp file internally for scratch data, users should not use this file
		:global MtmFacts;
		:local path ($MtmFacts->"a"->"mtmTempFile");
		:if ($0 = true) do={
			##empty the file, this is helpful for functions that will write directly to the file outside the files tool
			:local fileTool [($MtmFacts->"execute") nsStr="getTools()->getFiles()"];
			[($fileTool->"setContent") $path ""];
		}
		:return $path;
	}
	:set ($s->"getMtmErrFile") do={
		:global MtmFacts;
		:return ($MtmFacts->"a"->"mtmErrFile");
	}
	:set ($s->"getMtmNullFile") do={
		#MTM uses this temp file internally for junk data, fell free to push junk here
		:global MtmFacts;
		:return ($MtmFacts->"a"->"mtmNullFile");
	}
	:set ($s->"getMtmImportFile") do={
		#MTM uses this temp file internally for import return
		:global MtmFacts;
		:return ($MtmFacts->"a"->"mtmImportFile");
	}
	:set ($s->"getMtmExceptionFile") do={
		#MTM uses this file internally for storing the last exception encountered
		:global MtmFacts;
		:return ($MtmFacts->"a"->"mtmExFile");
	}
	:set ($s->"getMtmTempVar") do={
		#MTM uses this temp file internally for scratch data, users should not use this file
		:global MtmFacts;
		:return ($MtmFacts->"a"->"mtmTempVar");
	}
	:set ($s->"setMtmTempVar") do={
		#MTM uses this temp file internally for scratch data, users should not use this file
		:global MtmFacts;
		:set ($MtmFacts->"a"->"mtmTempVar") $0;
		:return [:nothing]
	}
	:set ($s->"getNull") do={
		# cant seem to set nil without it being interpreted as a string
		:return $null;
	}
	:set ($s->"throwException") do={
	
		:global MtmFacts;
		:local logHead (" RosEvent:");
		:local log ("Exception thrown in: '$method', Message: ".$msg);
		:put ($log);
		
		:do {
			:log info ($logHead." ".$log);
		} on-error={
		
		}
		
		:if ($logFile = true) do={
			:do {
				:local fsTool [($MtmFacts->"execute") nsStr="getTools()->getFiles()"];
				[($fsTool->"setContent") ([($MtmFacts->"getMtmExceptionFile")]) $log];
			} on-error={
			
			}
		}
		
		# finally throw
		:error ($log);
	}
	:set MtmFacts $s;
	
	## try moving the file tool inside the {}, all the sudden create gets called without a path
	## try removing the {} and all the sudden "Tools->Fetch->Upload->postJson" is called throught the upload class
	## I do not yet understand it, might be when a method has no return (create used to not return anything)
	:local fsTool;
	{
		##create temp files
		:set fsTool [($s->"execute") nsStr="getTools()->getFiles()"];
		[($fsTool->"create") ([($s->"getMtmErrFile")])];
		[($fsTool->"create") ([($s->"getMtmObjFile")])];
		[($fsTool->"create") ([($s->"getMtmTempFile")])];
		[($fsTool->"create") ([($s->"getMtmNullFile")])];
		[($fsTool->"create") ([($s->"getMtmImportFile")])];
		[($fsTool->"create") ([($s->"getMtmExceptionFile")])];
	}
	#load helpers
	:local path;
	{
		#setup cache
		:global MtmCache;
		:set MtmCache;
		:set path ([($s->"getMtmPath")]."Cache.rsc");
		[($s->"importFile") $path];
	}
	
	{
		#setup store
		:global MtmStore;
		:set MtmStore;
		:set path ([($s->"getMtmPath")]."Store.rsc");
		[($s->"importFile") $path];
	}
}
