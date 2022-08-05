#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local toolObj [($MtmFacts->"get") "getTools()->getJson()->getDecode()"];
```

## Methods:

### get:

```
:local data "[\"my\",\"data\",\"and\",\"objects\"]"; #required
:put ([($toolObj->"getFromArray") $data]); #array my,data,and,objects
```