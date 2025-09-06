#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local nsStr "getTools()->getRouting()->getIPv4()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];

```

## Methods:

### getActiveGatewayAddress:

```
:local result [($toolObj->"getActiveGatewayAddress")];
:put ($result); #string e.g. 5.6.5.44;
```
