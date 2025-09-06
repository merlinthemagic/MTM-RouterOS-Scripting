#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local nsStr "getIP()->getPools()";
:local factObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### getAll:

```
:local result [($factObj->"getAll")];
:put ($result); #array of ip pool objs
```