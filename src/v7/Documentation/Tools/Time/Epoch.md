#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local toolObj [($MtmFacts->"get") "getTools()->getTime()->getEpoch()"];
```

## Methods:

### getCurrent:

```
:put ([($toolObj->"getCurrent")]); #number e.g. 1659953188
```
