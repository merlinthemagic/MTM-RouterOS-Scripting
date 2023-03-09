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
:put ([($toolObj->"get") $myStr]); #a537d002d4b595d99b7a2a9db4dfa2ff
```
