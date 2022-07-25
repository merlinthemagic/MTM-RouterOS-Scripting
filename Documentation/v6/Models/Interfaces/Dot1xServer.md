#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local interface "ether42";
:local nsStr "getInterfaces()->getDot1x()->getServers()->getByInterface(name='$interface')";
:local rObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### getInterfaceName:

```
:local result [($rObj->"getInterfaceName")];
:put ($result); #"ether42"
```

### isInterfaceList:

```
:local result [($rObj->"isInterfaceList")];
:put ($result); #bool
```