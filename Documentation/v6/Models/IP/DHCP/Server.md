#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local name "dhcp0";
:local nsStr "getIP()->getDhcpServers()->getByName(name='$name')";
:local dhcpObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### getName:

```
:local result [($dhcpObj->"getName")];
:put ($result); #string e.g. "dhcp0"
```

### getRadiusUse:

```
:local result [($dhcpObj->"getRadiusUse")];
:put ($result); #string e.g. yes, no or accounting
```

### setRadiusUse:

```
:local val "yes";
:local result [($dhcpObj->"setRadiusUse") $val];
:put ($result); #bool true
```

### getLeaseScript:

```
:local result [($dhcpObj->"getLeaseScript")];
:put ($result); #string script
```

### setLeaseScript:

```
:local val ":delay 5s;";
:local result [($dhcpObj->"setLeaseScript") $val];
:put ($result); #bool true
```

### getBootpSupport:

```
:local result [($dhcpObj->"getRadiusUse")];
:put ($result); #string e.g. none, dynamic or static
```

### setBootpSupport:

```
:local val "none";
:local result [($dhcpObj->"setBootpSupport") $val];
:put ($result); #bool true
```

### getAuthoritative:

```
:local result [($dhcpObj->"getAuthoritative")];
:put ($result); #string e.g. after-2sec-delay, after-10sec-delay or no
```

### setAuthoritative:

```
:local val "after-10sec-delay";
:local result [($dhcpObj->"setAuthoritative") $val];
:put ($result); #bool true
```

### getLeaseTime:

```
:local result [($dhcpObj->"getLeaseTime")];
:put ($result); #string time e.g. 04:00:00
```

### setLeaseTime:

```
:local secs 7200;
:local result [($dhcpObj->"setLeaseTime") $secs];
:put ($result); #bool true
```

### getAddressPool:

```
:local result [($dhcpObj->"getAddressPool")];
:put ($result); #string e.g. "dhcp_pool0"
```

### setAddressPool:

```
:local val "dhcp_pool5";
:local result [($dhcpObj->"setAddressPool") $val];
:put ($result); #bool true
```
