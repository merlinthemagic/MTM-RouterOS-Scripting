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

### getAntennaGain:

```
:local mVal [($mObj->"getAntennaGain")];
:put ($mVal); #num e.g. 3
```

### getClientCount:

```
:local mVal [($mObj->"getClientCount")];
:put ($mVal); #num of associated clients, including anyone associated on a child virtual interface
```