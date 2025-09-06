#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local nsStr "getTools()->getTime()->getEpoch()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### getCurrent:

```
:local result [($toolObj->"getCurrent")];
:put ($result); #"1627378738";
```

### getFromFormat:

```
:local format "m/d/Y h:i:s";
:local time "jul/27/2019 09:37:24";

:local result [($toolObj->"getFromFormat") $format $time];
:put ($result); #"1564220244";
```
