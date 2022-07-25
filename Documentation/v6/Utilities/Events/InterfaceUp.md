#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local nsStr "getUtilities()->getEvents()->getInterfaceUp()";
:local utilObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### registerCb:

Every time an interface returns to up, the call back will be called with the string name of the interface that went up

```
:local cbId "myCbFunction";
:local cbFunc do={
	:local interfaceName $0;
	:put ("Interface name: '".$interfaceName."' changed state to up");
}
[($utilObj->"registerCb") $cbId $cbFunc];
```

### runOnce:

will scan all running interfaces once

```
[($utilObj->"runOnce")];

```

### run:

will scan all running interfaces every x seconds

```
:local interval 15; # run interval in seconds, defaults to 10 seconds
[($utilObj->"run") $interval];
```