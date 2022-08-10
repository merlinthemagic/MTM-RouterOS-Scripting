#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
##picking first hardware interface
:local mObj (([($MtmFacts->"get") "getModels()->getInterfaces()->getWlans()->getAllHardware()"])->0);
```

## Methods:

### getType:

```
:local mVal [($mObj->"getAll")];
:put ($mVal); #string 'wlan'
```

### getName:

```
:local mVal [($mObj->"getName")];
:put ($mVal); #string wlan1
```

### getMacAddress:

```
:local mVal [($mObj->"getMacAddress")];
:put ($mVal); #string "AA:BB:CC:11:22:33"
```

### getEnabled:

```
:put([($mObj->"getEnabled")]); #bool
```

### setEnabled:

```
:local mVal ([($mObj->"setEnabled") [:tobool true]]);
```

### getClientCount:

```
:local mVal [($mObj->"getClientCount")];
:put ($mVal); #num of associated clients, including anyone associated on a child virtual interface
```

### getAntennaGain:

```
:local mVal [($mObj->"getAntennaGain")];
:put ($mVal); #num e.g. 3
```

### getScan:

```
:local mVal [($mObj->"getScan")];
:put ($mVal); #array of observed access points, throws if interface is not running-ap
```

### getStatus:

```
:local mVal [($mObj->"getStatus")];
:put ($mVal); #string running-ap or disabled or searching-for-network etc
```

### getStatus:

```
:local mVal [($mObj->"getTxCcq")];
:put ($mVal); #num overall tx ccq procentage for radio
```
