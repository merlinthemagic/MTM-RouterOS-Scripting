#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local nsStr "getTools()->getParsing()->getJsonEncode()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];

```

## Methods:

### getFromArray:

```
:local data [:toarray "my,data,and,objects"]; #required

:local result [($toolObj->"getFromArray") data=$data];
:put ($result); #"json formatted string";
```

Example take some ethernet attributes and convert to json:

```
:local nsStr "getTools()->getInterfaces()->getEthernet()";
:local ifTool [($MtmFacts->"execute") nsStr=$nsStr];

:local ifName "ether1";
:local attrs [:toarr "name,mac-address,tx-bytes,rx-bytes"];

:local data [($ifTool->"getAttributes") name=$ifName attrs=$attrs];
:local result [($toolObj->"getFromArray") data=$data];
:put ($result); #"{"mac-address":"B869F421294A","name":"ether1","rx-bytes":"51849259","tx-bytes":"23946564"}";

```