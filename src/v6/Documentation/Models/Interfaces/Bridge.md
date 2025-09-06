#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local name "bridge1";
:local nsStr "getInterfaces()->getBridges()->getByName(name='$name')";
:local ifObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

Check Common.md for additional methods


### getAdminMacAddress:

```
:local result [($ifObj->"getAdminMacAddress")];
:put ($result); #string e.g. "C4:AD:34:A1:2A:12"
```

### getHosts:

```
:local inclLocal false; #optional, default true
:local attrs [:toarray "interface,mac-address,vid"]; #optional, defaults to all attributes
:local result [($ifObj->"getHosts") $inclLocal $attrs];
:put ($result); #array
```
