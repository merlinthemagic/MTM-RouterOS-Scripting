#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local nsStr "getTools()->getInterfaces()->getBridge()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];

```

## Methods:

### getSomething:

```
:local attrs [:toarr "name,mac-address,running,tx-bytes,rx-bytes"]; #optional

:local result [($toolObj->"getRegistrations") attrs=$attrs];
:put ($result); #array of wlan regs;
```


### stpPriorities (attribute):

```
:local result ($toolObj->"stpPriorities");
:put ($result); #array of stp priorities in decimal and hex
```