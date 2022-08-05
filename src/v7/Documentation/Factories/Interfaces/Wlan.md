#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local factObj [($MtmFacts->"get") "getModels()->getInterfaces()->getWlans()"];
```

## Methods:

### getAll:

```
:local mObjs [($factObj->"getAll")];
:put ($mObjs); #array of wireless interface objs
```

### getAllHardware:

```
:local mObjs [($factObj->"getAllHardware")];
:put ($mObjs); #array of hardware wireless interface objs
```

### getAllVirtual:

```
:local mObjs [($factObj->"getAllVirtual")];
:put ($mObjs); #array of virtual wireless interface objs
```