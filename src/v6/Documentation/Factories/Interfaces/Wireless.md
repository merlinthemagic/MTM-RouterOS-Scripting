#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local nsStr "getInterfaces()->getWireless()";
:local factObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### getAll:

```
:local result [($factObj->"getAll")];
:put ($result); #array of wireless interface objs
```

### getByName:

```
:local name "wlan1";
:local result [($factObj->"getByName") $name];

:if ([:typeof $result] != "nil") do={
	:put ($result); #Instance of a wireless interface;
} else={
	#interface with that name does not exist
}
```

### getAllHardware:

```
:local result [($factObj->"getAllHardware")];
:put ($result); #array of wireless interface objs that are not virtual
```