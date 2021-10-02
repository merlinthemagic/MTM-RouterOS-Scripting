#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local nsStr "getTools()->getTraceroute()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### ipv4ICMP:

Checks if a file exists on the path already

```
:local addr "8.8.8.8";
:local result [($toolObj->"ipv4ICMP") $addr];
:put ($result); #array of hops;
```
