#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local nsStr "getInterfaces()->getDot1x()->getServers()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### getByInterface:

```
:local interface "ether42"; #can also be a list
:local result [($toolObj->"getByInterface") $interface];

:if ([:typeof $result] != "nil") do={
	:put ($result); #Instance of a dot1x server;
} else={
	#server with that interface does not exist
}
```