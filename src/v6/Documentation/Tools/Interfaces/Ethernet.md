#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local nsStr "getTools()->getInterfaces()->getEthernet()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];

```

## Methods:

### getAttributes:

```
:local ifName "ether1"; #required
:local attrs [:toarr "name,mac-address,running,tx-bytes,rx-bytes"]; #optional
:local throw true; #optional throws exception if interface name not found

:local result [($toolObj->"getAttributes") name=$ifName attrs=$attrs throw=$throw];
:put ($result); #"array of properties and their values";
```

### getProperties:

```
:local ifName "ether1"; #required
:local throw true; #optional throws exception if interface name not found

:local result [($toolObj->"getProperties") name=$ifName throw=$throw];
:put ($result); #"array of properties";
```
