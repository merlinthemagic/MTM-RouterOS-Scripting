#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local toolObj [($MtmFacts->"get") "getTools()->getJobs()->getTracking()"];
```

## Methods:

### getTracker:

Note: gets or creates the tracker

```
:local procName "myProcess"; #required
:local trkObj [($toolObj->"getTracker") $procName];
```

### setTracker:

Note: updates or removes the tracker

```
:local procName "myProcess"; #required
:local trkObj $obj; #tracker object you got  from getTracker, or nothing

:local result [($toolObj->"setTracker") $procName, $trkObj]; #bool true or error if tracker does not exist
```


####Example of tracker + locks:

```
:global MtmFacts;
:local mVal ""; ##return garbage variable, if returns are not placed in a var bad things happen
:if ([:typeof $MtmFacts] = "nothing") do={
	:set mVal [/import file-name=flash/MTM/Facts.rsc verbose=no];
}


:local jobName "myJob"; ##name of the job you want to check, must be unique on the system
:local procName "myCtrl"; ##name of this controller job, must be unique on the system
:local key [($MtmFacts->"lock") $procName 60 2]; ##lock the process. Will throw error if someone else holds this, ensuring only one controller runs at a time

:do {

	:local toolObj [($MtmFacts->"get") "getTools()->getJobs()->getTracking()"];
	:local trkObj [($toolObj->"getTracker") $jobName];
	:if (($trkObj->"id") != "") do={
		##check the Job
		:local toolObj2 [($MtmFacts->"get") "getTools()->getJobs()->getStatus()"];
		:local isRun [($toolObj2->"getRunning") ($trkObj->"id")];
		:if ($isRun = false) do={
			##reset the object, job stalled
			:log/warning ("Job ".$jobName." found dead");
			:set ($trkObj->"id") "";
			:set ($trkObj->"lastCheck") 0;
			:set ($trkObj->"lastUpdate") 0;
		} else={
			##job is still running
		}
	}	
	:if (($trkObj->"id") = "") do={
		##kick off A Job
		:log/info ("Starting job ".$jobName);
		:local wrkPath "flash/my/path/to/script.rsc");
		:local scr (":global MtmFacts; :local mVal [(\$MtmFacts->\"importFile\") $wrkPath];");
		:set ($trkObj->"id") [:execute script=$scr file=([($MtmFacts->"getNullFile")])];
	}
	:set ($trkObj->"lastCheck") (($trkObj->"lastCheck") + 1); ##increment the check counter
	:set mVal [($tTool->"setTracker") $jobName $trkObj]; ##update the tracker
	
	:set mVal [($MtmFacts->"unlock") $procName $key]; ##unlock this process
	
} on-error={
	
	:log/error ($procName.": Encountered an error");
	:set mVal [($MtmFacts->"unlock") $procName $key]; ##unlock this process
}

```
