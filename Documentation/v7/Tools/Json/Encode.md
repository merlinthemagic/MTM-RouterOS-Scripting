#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local toolObj [($MtmFacts->"get") "getTools()->getJson()->getEncode()"];
```

## Methods:

### get:

```
:local data [:toarray "my,data,and,objects"]; #required
:put ([($toolObj->"getFromArray") $data]); #string ["my","data","and","objects"]
```