#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local toolObj [($MtmFacts->"get") "getTools()->getEncoding()->getBase16()"];
```

## Methods:

### encode:

```
:local myStr "My string";
:put ([($toolObj->"encode") $myStr]); #4D7920737472696E67
```
