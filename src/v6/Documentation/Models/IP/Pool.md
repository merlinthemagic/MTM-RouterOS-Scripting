#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local name "dhcp_pool0";
:local nsStr "getIP()->getPools()->getByName(name='$name')";
:local poolObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### getName:

```
:local result [($poolObj->"getName")];
:put ($result); #string e.g. "dhcp_pool0"
```

### getUsedCount:

```
:local result [($poolObj->"getUsedCount")];
:put ($result); #num e.g. 5
```

### getNextPoolName:

```
:local result [($poolObj->"getNextPoolName")];
:put ($result); #string or nil e.g. "dhcp_pool1"
```
