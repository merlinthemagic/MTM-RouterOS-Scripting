#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local name "lte1";
:local nsStr "getInterfaces()->getLTE()->getByName(name='$name')";
:local ifObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

Check Common.md for additional methods


### getApnProfileNames:

```
:local result [($ifObj->"getApnProfileNames")];
:put ($result); #array e.g.
```

### getInfo:

```
:local result [($ifObj->"getInfo")];
:put ($result); #array of lte attributes, if info is supported;
