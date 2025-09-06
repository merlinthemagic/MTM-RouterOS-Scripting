#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local nsStr "getTools()->getParsing()->getIPv4()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];

```

## Methods:

### isValid:

```
:local addr "10.0.0.1";
:local throw false; # optional boolean
:local result [($toolObj->"isValid") $addr, $throw];
:put ($result); #bool or throw
```

### isRFC1918:

```
:local addr "10.0.0.1";
:local result [($toolObj->"isRFC1918") $addr];
:put ($result); #bool
```

### getSubnetAddress:

```
:local addr "10.0.0.1/24";
:local result [($toolObj->"getSubnetAddress") $addr];
:put ($result); #ip e.g. 10.0.0.0
```

### getAddress:

```
:local addr "10.0.0.1/24";
:local result [($toolObj->"getAddress") $addr];
:put ($result); #ip e.g. 10.0.0.1
```

### getCidr:

```
:local addr "10.0.0.1/24";
:local result [($toolObj->"getCidr") $addr];
:put ($result); #num e.g. 24
```

### getMaskFromCidr:

```
:local cidr 24;
:local result [($toolObj->"getMaskFromCidr") $cidr];
:put ($result); #ip e.g. 255.255.255.0
```

### cidrMasks (attribute):

```
:local result ($toolObj->"cidrMasks");
:put ($result); #array of cidrs and their masks
```