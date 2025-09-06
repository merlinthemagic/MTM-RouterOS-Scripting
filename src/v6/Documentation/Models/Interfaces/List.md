#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local name "myEdgePorts";
:local nsStr "getInterfaces()->getLists()->getByName(name='$name')";
:local listObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### getName:

```
:local result [($listObj->"getName")];
:put ($result); #"myEdgePorts"
```

### getInterfaceNames:

```
:local result [($listObj->"getInterfaceNames")];
:put ($result); #array of interface names that are in this list
```