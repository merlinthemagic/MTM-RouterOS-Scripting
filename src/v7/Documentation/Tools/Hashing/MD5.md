#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local toolObj [($MtmFacts->"get") "getTools()->getHashing()->getMD5()"];
```

## Methods:

### get:

```
:local myStr "My string";
:local toolObj [($factObj->"getMD5")];
:put ([($toolObj->"get") $myStr]); #d41d8cd98f00b204e9800998ecf8427e
```
