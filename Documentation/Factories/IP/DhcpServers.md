#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local nsStr "getIP()->getDhcpServers()";
:local factObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### getAll:

```
:local result [($factObj->"getAll")];
:put ($result); #array of dhcp server objs
```