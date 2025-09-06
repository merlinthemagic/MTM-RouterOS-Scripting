#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local nsStr "getTools()->getInterfaces()->getWireless()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];

```

## Methods:

### getRegistrations:

```
:local attrs [:toarr "name,mac-address,running,tx-bytes,rx-bytes"]; #optional

:local result [($toolObj->"getRegistrations") attrs=$attrs];
:put ($result); #array of wlan regs;
```
