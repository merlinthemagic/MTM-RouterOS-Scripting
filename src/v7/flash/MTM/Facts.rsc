:local className "MTM->Facts.rsc";
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
		:error ($className.": Cannot find environment file 'MtmEnv.rsc'");
	}
	
	:set ($s->"setEnv") do={
		:local methodName "MTM->Facts->setEnv";
		:global MtmFacts;
		:if ([:len $0] = 0 || [:typeof $0] != "str") do={
			:error ($methodName.": Key is mandatory, must be string value");
		}
		:if ([:len $1] = 0) do={
			:error ($methodName.": Value is mandatory");
		}
		:set ($MtmFacts->"env"->$0) $1;
		:return $MtmFacts;
	}
	:set ($s->"getEnv") do={
		:local methodName "MTM->Facts->getEnv";
		:global MtmFacts;
		:if ([:len $0] = 0 || [:typeof $0] != "str") do={
			:error ($methodName.": Key is mandatory, must be string value");
		}
		:local mVal ($MtmFacts->"env"->$0);
		
		:put ([:typeof $mVal]);
		:put ($0);
		:put ($MtmFacts->"env");
		:put ($0);
		:if ([:typeof $mVal] = "nothing" && $1 != false) do={
			:error ($methodName.": Key '".$0."' does not exist");
		}
		:return $mVal;
	}
	:set ($s->"echo") do={
		:put ($0."\n");
		:return $mVal;
	}
	:set ($s->"importFile") do={
		:global MtmFacts;
		:local methodName "MTM->Facts->importFile";
		:if ([:len $0] = 0 || [:typeof $0] != "str") do={
			:error ($methodName.": File path is mandatory, must be string value");
		}
		:local mVal [($MtmFacts->"getEnv") "mtm.debug.enabled" false];
		:put ([:typeof $mVal]);
		:put ($mVal);
		:if ($mVal != false) do={
			#debugging mode, make all verbose
			[($MtmFacts->"echo") ("Starting file import: '".$0."'\n")];
			/import file-name=$path verbose=yes;
			[($MtmFacts->"echo") ("Completed file import: '".$0."'\n")];
			:return true;
		} else={
		
			#delegate job to sub process
			:local scr (":put ".$path."; /import file-name=".$0);
			:local jobId [:execute script=$scr file="mtmNull.txt"];
			
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
						:error ($methodName.": Importing '".$0."' resulted in timeout");
					}
				}
			}
		}
		:return $MtmFacts;
	}
	
	:set MtmFacts $s;
	:local mVal "";
	
	##import the environment variables
	:set mVal [($MtmFacts->"importFile") $envFile];
}
