#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local nsStr "getInterfaces()->getLTE()";
:local factObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### getAll:

```
:local result [($factObj->"getAll")];
:put ($result); #array of lte interface objs
```

### getByName:

```
:local name "lte1";
:local result [($factObj->"getByName") $name];

:if ([:typeof $result] != "nil") do={
	:put ($result); #Instance of a lte interface;
} else={
	#interface with that name does not exist
}
```
