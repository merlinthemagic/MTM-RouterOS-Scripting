:local cPath "MTM/Tools/Jobs/Scripts.rsc";
:local s [:toarray ""];
:set ($s->"execute") do={

	:global MtmFacts;
	:local cPath "MTM/Tools/Jobs/Scripts.rsc/execute";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input script has invalid type '".[:typeof $0]."'");
	}
	:if ([:typeof $1] != "num") do={
		:error ($cPath.": Input termination time has invalid type '".[:typeof $1]."'");
	}
	
	:local procTool [($MtmFacts->"get") "getTools()->getJobs()->getStatus()"];
	:local tTime $1;
	:local mVal "";
	:local jId [:execute script=$0 file=[($MtmFacts->"getNullFile")]];
	:while ($tTime > 0) do={
		:if ([($procTool->"getRunning") $jId] = false) do={
			:set tTime 0;
		} else={
			:set tTime ($tTime - 100);
			:if ($tTime > 0) do={
				:delay 0.1s;
			} else={
				:local mMsg "Terminated, script took too long"; 
				:local sigTool [($MtmFacts->"get") "getTools()->getJobs()->getSignals()"];
				:do {
					:set mVal [($sigTool->"sigint") $jId];
				} on-error={
					:set mMsg "Script took too long. Termination resulted in error"; 
				}
				:error ($cPath.": ".$mMsg);
			}
		}
	}
	:return true;
}

:global MtmToolJobs1;
:set ($MtmToolJobs1->"scripts") $s;