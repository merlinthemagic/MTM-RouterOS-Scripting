#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local name "ether42";
:local nsStr "getInterfaces()->getEthernet()->getByName(name='$name')";
:local ifObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

Check Common.md for additional methods

### getLinkSpeed:

```
:local result [($ifObj->"getLinkSpeed")];
:put ($result); #string e.g. "1Gbps"
```

### getDot1xServerStateStatus:

```
:local result [($ifObj->"getDot1xServerStateStatus")];
:put ($result); #string or null if part of a server. e.g. un-authorized, authorized
```
### getLastLinkUpTime:

```
:local result [($ifObj->"getLastLinkUpTime")];
:put ($result); #epoch e.g. 1628030141
```

### getLastLinkDownTime:

```
:local result [($ifObj->"getLastLinkDownTime")];
:put ($result); #epoch e.g. 1628030141
```

### getTxUnicast:

```
:local result [($ifObj->"getTxUnicast")];
:put ($result); #packet count e.g. 108046881
```

### getRxUnicast:

```
:local result [($ifObj->"getRxUnicast")];
:put ($result); #packet count e.g. 112843451
```

### getTxMulticast:

```
:local result [($ifObj->"getTxMulticast")];
:put ($result); #packet count e.g. 108046881
```

### getRxMulticast:

```
:local result [($ifObj->"getRxMulticast")];
:put ($result); #packet count e.g. 112843451
```

### getTxBroadcast:

```
:local result [($ifObj->"getTxBroadcast")];
:put ($result); #packet count e.g. 108046881
```

### getRxBroadcast:

```
:local result [($ifObj->"getRxBroadcast")];
:put ($result); #packet count e.g. 112843451
```

### getRxErrorEventCount:

```
:local result [($ifObj->"getRxErrorEventCount")];
:put ($result); #count e.g. 276
```

### getPoeOutVoltage:

```
:local result [($ifObj->"getPoeOutVoltage")];
:put ($result); #voltage provided on the interface e.g. 26.5V
```

### getPoeOutStatus:

```
:local result [($ifObj->"getPoeOutStatus")];
:put ($result); #e.g. powered-on
```

### getPoeOutVoltageMode:

```
:local result [($ifObj->"getPoeOutVoltageMode")];
:put ($result); #e.g. auto
```

### getPoeOutCurrent:

```
:local result [($ifObj->"getPoeOutCurrent")];
:put ($result); #e.g. 152mA
```

### getPoeOutWatts:

```
:local result [($ifObj->"getPoeOutWatts")];
:put ($result); #e.g. 4W
```



### monitorOnce:

```
:local result [($ifObj->"monitorOnce")];
:put ($result); #array of monitored attributes e.g. advertising=10M-half,10M-full,100M-half,100M-full,1000M-half;auto-negotiation=done;full-duplex=yes;link-partner-advertising=10M-half,10M-full,100M-half,100M-full,1000M-half;name=ether16;rate=1Gbps;rx-flow-control=no;status=link-ok;tx-flow-control=no
```

### monitorPoeOnce:

```
:local result [($ifObj->"monitorPoeOnce")];
:put ($result); #array of monitored attributes e.g. name=ether16;poe-out=auto-on;poe-out-current=152mA;poe-out-power=4W;poe-out-status=powered-on;poe-out-voltage=26.5V;poe-voltage=auto
```


### getValues:

Note: this method was called "getAttributes" but for unknown reasons that causes the method to be called when the object is instanciated
so now its called getValues

```
:local result [($ifObj->"getValues")];
:put ($result); #array of interface values e.g. advertising=10M-half,10M-full,100M-half,100M-full,1000M-half;auto-negotiation=done;full-duplex=yes;link-partner-advertising=10M-half,10M-full,100M-half,100M-full,1000M-half;name=ether16;rate=1Gbps;rx-flow-control=no;status=link-ok;tx-flow-control=no
```


