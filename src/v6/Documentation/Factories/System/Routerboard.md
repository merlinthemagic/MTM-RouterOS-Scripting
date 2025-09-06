#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local nsStr "getSystem()->getRouterboard()";
:local sysObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### getModel:


```
:local result [($sysObj->"getModel")];
:put ($result); #string e.g. "CRS354-48P-4S+2Q+"
```


