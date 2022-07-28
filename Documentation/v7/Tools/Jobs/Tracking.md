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


####Example:

```
:local procName "myProc";
:local trkObj [($toolObj->"getTracker") $procName];
:if (($trkObj->"id") != "") do={
	##check the Job
	:local toolObj2 [($MtmFacts->"get") "getTools()->getJobs()->getStatus()"];
	:local isRun [($toolObj2->"getRunning") ($trkObj->"id")];
	:if ($isRun = false) do={
		##reset the object, job stalled
		:set ($trkObj->"id") "";
		:set ($trkObj->"lastCheck") 0;
		:set ($trkObj->"lastUpdate") 0;
	} else={
		##job is still running
	}
}	
:if (($trkObj->"id") = "") do={
	##kick off A Job
	:local wrkPath "flash/my/path/to/script.rsc");
	:local scr (":global MtmFacts; :local results [(\$MtmFacts->\"importFile\") $wrkPath];");
	:set ($trkObj->"id") [:execute script=$scr file=([($MtmFacts->"getNullFile")])];
}
:set ($trkObj->"lastCheck") (($trkObj->"lastCheck") + 1); ##increment the check counter
:local resultBool [($tTool->"setTracker") $procName $trkObj]; ##update the tracker	

```
