#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local nsStr "getTools()->getParsing()->getDateTime()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];

```

## Methods:

### toSeconds:

```
:local input "1w4d06:06:18";
:local result [($toolObj->"toSeconds") $input];
:put ($result); #num 972378
```
