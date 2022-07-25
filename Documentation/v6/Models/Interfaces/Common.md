
## Methods:

Common methods for all interface types

### getName:

```
:local result [($ifObj->"getName")];
:put ($result); #"ether42"
```

### getMacAddress:

```
:local result [($ifObj->"getMacAddress")];
:put ($result); #string mac address e.g. "C4:AD:34:A2:9E:11"
```
### isRunning:

```
:local result [($ifObj->"isRunning")];
:put ($result); #bool
```

### getComment:

```
:local result [($ifObj->"getComment")];
:put ($result); #string e.g. "This is my WAN interface"
```

### setComment:

```
:local comment "This is my WAN interface";
:local result [($ifObj->"getComment") $comment];
:put ($result); #nil
```

### getMTU:

```
:local result [($ifObj->"getMTU")];
:put ($result); #number e.g. 1500
```

### setMTU:

```
:local val 1500;
:local result [($ifObj->"setMTU") $val];
:put ($result); #nil
```

### getL2MTU:

```
:local result [($ifObj->"getL2MTU")];
:put ($result); #number e.g. 1594
```

### getMaxL2MTU:

```
:local result [($ifObj->"getMaxL2MTU")];
:put ($result); #number e.g. 10218
```

### setL2MTU:

```
:local val 9214;
:local result [($ifObj->"setL2MTU") $val];
:put ($result); #nil
```

### getDisabled:

```
:local result [($ifObj->"getDisabled")];
:put ($result); #bool
```

### setDisabled:

```
:local bool false;
:local result [($ifObj->"setDisabled") $bool];
:put ($result); #nil
```

### getTxBytes:

```
:local result [($ifObj->"getTxBytes")];
:put ($result); #byte count e.g. 108046881
```

### getRxBytes:

```
:local result [($ifObj->"getRxBytes")];
:put ($result); #byte count e.g. 112843451
```

### getTxPackets:

```
:local result [($ifObj->"getTxPackets")];
:put ($result); #packet count e.g. 108046881
```

### getRxPackets:

```
:local result [($ifObj->"getRxPackets")];
:put ($result); #packet count e.g. 112843451
```

### getTxDrops:

Number of drops bc output queue was already full

```
:local result [($ifObj->"getTxDrops")];
:put ($result); #num e.g. 33
```
