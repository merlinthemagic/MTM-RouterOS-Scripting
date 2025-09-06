#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local nsStr "getTools()->getParsing()->getIPv6()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];

```

## Methods:


### getAddress:

```
:local addr "fe80::2ec8:1bff:fe82:12f1/64";
:local result [($toolObj->"getAddress") $addr];
:put ($result); #ip e.g. fe80::2ec8:1bff:fe82:12f1
```

### getCidr:

```
:local addr "fe80::2ec8:1bff:fe82:12f1/64";
:local result [($toolObj->"getCidr") $addr];
:put ($result); #num e.g. 64
```
