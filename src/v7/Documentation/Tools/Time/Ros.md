#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local toolObj [($MtmFacts->"get") "getTools()->getTime()->getRos()"];
```

## Methods:

### getMiliFromFormat:

```
:local mTime "01:00:17.050";
:local mFormat "h:i:s.u";
:put ([($toolObj->"getMiliFromFormat") $mTime $mFormat]); #number 3617050
```

### getGmtOffset:

Note: returns number of seconds from GMT as a "signed int".. in ROS represented as a string since num is not signed:/

```
:put ([($toolObj->"getGmtOffset") $mTime $mFormat]); #number -21600
```

### getSecondsFromFormat:

```
:local mTime "01:00:17";
:local mFormat "h:i:s";
:put ([($toolObj->"getSecondsFromFormat") $mTime $mFormat]); #number 3617
```

### getCurrentHour:

```
:put ([($toolObj->"getCurrentHour")]); #number 5 or 13 etc
```


