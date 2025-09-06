#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local nsStr "getInterfaces()->getLists()";
:local factObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### getAll:

```
:local result [($factObj->"getAll")];
:put ($result); #array of interface list objs
```

### getByName:

```
:local name "myEdgePorts";
:local result [($factObj->"getByName") $name];

:if ([:typeof $result] != "nil") do={
	:put ($result); #Instance of an interface list;
} else={
	#interface list with that name does not exist
}
```