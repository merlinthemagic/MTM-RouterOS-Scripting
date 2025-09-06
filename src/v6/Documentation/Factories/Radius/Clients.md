#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local nsStr "getRadius()->getClients()";
:local factObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### getAll:

```
:local result [($factObj->"getAll")];
:put ($result); #array of radius client objs
```
