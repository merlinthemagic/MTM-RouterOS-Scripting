#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local nsStr "getTools()->getHashing()->getMD5()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];

```

## Methods:

### hash:

```
:local myStr "my string data"; ## string to be hashed
:local result [($toolObj->"hash") $myStr];
:put ($result); #string "8240143bd807e5a52b1f9d7dd5e21ef3"
```