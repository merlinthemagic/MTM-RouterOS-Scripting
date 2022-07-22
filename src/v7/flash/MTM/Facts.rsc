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
	:set ($s->"setDebug") do={
		:local methodName "MTM->Facts->setDebug";
		:global MtmFacts;
		:if ($0 != "true" && $0 != "false") do={
			:error ($methodName.": Parameter must be true or false");
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
		:local methodName "MTM->Facts->setEnv";
		:global MtmFacts;
		:if ([:len $0] = 0 || [:typeof $0] != "str") do={
			:error ($methodName.": Key is mandatory, must be string value");
		}
		:if ([:typeof $1] != "str") do={
			:error ($methodName.": Value must be string value");
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
		:if ([:typeof $mVal] = "nothing" && $1 != false) do={
			:error ($methodName.": Key '".$0."' does not exist");
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
		:local methodName "MTM->Facts->importFile";
		:if ([:len $0] = 0 || [:typeof $0] != "str") do={
			:error ($methodName.": File path is mandatory, must be string value");
		}
		:local mVal [($MtmFacts->"getEnv") "mtm.debug.enabled" false];
		:if ($mVal = true) do={
			#debugging mode, make all verbose
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
