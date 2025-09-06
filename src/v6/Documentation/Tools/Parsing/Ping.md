#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local nsStr "getTools()->getParsing()->getPing()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];

```

## Methods:

### asArray:

Mostly used by the traceroute function

```
:local raw "SEQ HOST                                     SIZE TTL TIME  STATUS
    0 8.8.8.8                              			      56 116 13ms
    1 8.8.8.8                                    			56 116 15ms
    sent=2 received=3 packet-loss=0% min-rtt=13ms avg-rtt=14ms max-rtt=15ms";
:local result [($toolObj->"asArray") $raw];
:put ($result); #array of 
```
