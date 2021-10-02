#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local nsStr "getSystem()->getResources()";
:local sysObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### getAvgCpuLoad:

```
:local result [($sysObj->"getAvgCpuLoad")];
:put ($result); #num e.g. 15
```

### getCpuLoads:

```
:local result [($sysObj->"getCpuLoads")];
:put ($result); #array or cpu loads
```


### getFreeMemory:

```
:local result [($sysObj->"getFreeMemory")];
:put ($result); #num e.g. 15
```

### getFreeHddSpace:

```
:local result [($sysObj->"getFreeHddSpace")];
:put ($result); #num e.g. 1532335
```

### getUptime:

```
:local result [($sysObj->"getUptime")];
:put ($result); #num, in seconds e.g. 973859
```

### getCpuModel:

```
:local result [($sysObj->"getCpuModel")];
:put ($result); #string, e.g. "MIPS 24Kc V7.4"
```

### getBadHddBlocks:

```
:local result [($sysObj->"getBadHddBlocks")];
:put ($result); #num, e.g. 5
```