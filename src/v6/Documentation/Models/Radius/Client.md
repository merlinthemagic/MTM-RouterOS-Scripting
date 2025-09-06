#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local nsStr "getRadius()->getClients()->getAll()";
:local rObjs [($MtmFacts->"execute") nsStr=$nsStr];
:local radObj ($rObjs->0);
```

## Methods:

### getSrcAddress:

```
:local result [($radObj->"getSrcAddress")];
:put ($result); #string e.g. "10.64.78.23"
```

### monitorOnce:

```
:local result [($radObj->"monitorOnce")];
:put ($result); #array of monitored attributes e.g. accepts=19268;bad-replies=0;last-request-rtt=110ms;pending=0;rejects=0;requests=19392;resends=551;timeouts=124
```