#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local toolObj [($MtmFacts->"get") "getTools()->getJobs()->getStatus()"];
```

## Methods:

### getRunning:

```
:local pId 5; #required
:put ([($toolObj->"getRunning") $pId]); #bool
```