#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local toolObj [($MtmFacts->"get") "getTools()->getJson()->getDecode()"];
```

## Methods:

### get:

```
:local data "[\"my\",\"data\",\"and\",\"objects\"]"; #required
:put ([($toolObj->"getFromString") $data]); #array my,data,and,objects
```