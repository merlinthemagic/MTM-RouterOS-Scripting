:local cPath "MTM/Tools/Jobs/Tracking.rsc";
:local s [:toarray ""];

:set ($s->"getTracker") do={
		:global MtmToolJobsTrackers;
		:global MtmFacts;
		:local cPath "MTM/Tools/Jobs/Tracking.rsc/getTracker";
		:if ([:typeof $0] != "str") do={
			:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
		}
		
		:local lock "mtmTrack";
		:local key "";
		:do {
			:set key [($MtmFacts->"lock") $lock 5 7];
		} on-error={
			:error ($cPath.": Failed to lock");
		}
		:if (($MtmToolJobsTrackers->$0) = nil) do={
			:local jobObj [:toarray ""];
			:set ($jobObj->"id") "";
			:set ($jobObj->"data") [:toarray ""];
			:set ($jobObj->"lastCheck") 0;
			:set ($jobObj->"lastUpdate") 0;
			:set ($MtmToolJobsTrackers->$0) $jobObj;
		}
		:do {
			:set key [($MtmFacts->"unlock") $lock $key];
		} on-error={
			:error ($cPath.": Failed to unlock");
		}
		
		:return ($MtmToolJobsTrackers->$0);
	}
	:set ($s->"setTracker") do={
		:global MtmToolJobsTrackers;
		:global MtmFacts;
		:local cPath "MTM/Tools/Jobs/Tracking.rsc/setTracker";
		:if ([:typeof $0] != "str") do={
			:error ($cPath.": Input name has invalid type '".[:typeof $0]."'");
		}
		:if ([:typeof $1] != "array" && [:typeof $1] != "nothing") do={
			:error ($cPath.": Input object has invalid type '".[:typeof $1]."'");
		}
		:local lock "mtmTrack";
		:local key "";
		:do {
			:set key [($MtmFacts->"lock") $lock 5 7];
		} on-error={
			:error ($cPath.": Failed to lock");
		}
		:if (($MtmToolJobsTrackers->$0) != nil) do={
			:set ($MtmToolJobsTrackers->$0) $1;
			:do {
				:set key [($MtmFacts->"unlock") $lock $key];
			} on-error={
				:error ($cPath.": Failed to unlock");
			}
		} else={
			:do {
				:set key [($MtmFacts->"unlock") $lock $key];
			} on-error={
				:error ($cPath.": Failed to unlock");
			}
			:error ($cPath.": No tracker exists with name: '".$0."'");
		}
		:return true;
	}

:global MtmToolJobsTrackers;
:if ([:typeof $MtmToolJobsTrackers] = "nothing") do={
	:set $MtmToolJobsTrackers [:toarray ""];
}
	
:global MtmToolJobs1;
:set ($MtmToolJobs1->"track") $s;