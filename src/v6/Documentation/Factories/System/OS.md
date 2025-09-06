#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local nsStr "getSystem()->getOS()";
:local sysObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### getVersion:

```
:local result [($sysObj->"getVersion")];
:put ($result); #string e.g. "6.48.3"
```

### getMajorVersion:

```
:local result [($sysObj->"getMajorVersion")];
:put ($result); #string e.g. "6"
```

### getMinorVersion:

```
:local result [($sysObj->"getMinorVersion")];
:put ($result); #string e.g. "48"
```

### getMinorVersion:

```
:local result [($sysObj->"getPatchVersion")];
:put ($result); #string e.g. "3"
```


