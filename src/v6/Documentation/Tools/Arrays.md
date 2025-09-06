#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local nsStr "getTools()->getArrays()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### implode:

```
:local delimitor "+";
:local myArr [:toarray "alice,bob,charlie"];
:local result [($toolObj->"implode") $delimitor $myArr];
:put ($result); ## string "alice+bob+charlie";
```

### contains:

note: not case sensetive, only handles strings for now 

```
:local search "bob";
:local myArr [:toarray "alice,bob,charlie"];
:local result [($toolObj->"contains") $search $myArr];
:put ($result); ## bool;
```

### keyExists:

```
:local search "charlie";
:local myArr [:toarray ""];
:set ($myArr->"alice") "female";
:set ($myArr->"bobby") "male";
:set ($myArr->"charlie") "male";

:local result [($toolObj->"keyExists") $search $myArr];
:put ($result); ## bool;
```