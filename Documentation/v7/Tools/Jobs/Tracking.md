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