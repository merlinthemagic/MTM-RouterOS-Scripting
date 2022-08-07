#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local nsStr "getInterfaces()->getEthernet()";
:local factObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### getAll:

```
:local result [($factObj->"getAll")];
:put ($result); #array of ethernet interface objs
```

### getByName:

```
:local name "ether42";
:local result [($factObj->"getByName") $name];

:if ([:typeof $result] != "nil") do={
	:put ($result); #Instance of an ethernet interface;
} else={
	#interface with that name does not exist
}
```