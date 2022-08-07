#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local nsStr "getInterfaces()->getVLAN()";
:local factObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### getAll:

```
:local result [($factObj->"getAll")];
:put ($result); #array of vlan interface objs
```

### getByName:

```
:local name "vlan1";
:local result [($factObj->"getByName") $name];

:if ([:typeof $result] != "nil") do={
	:put ($result); #Instance of an vlan interface;
} else={
	#interface with that name does not exist
}
```