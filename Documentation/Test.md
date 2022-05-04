#MTM

Build test scripts and trigger using:

```
/import flash/MTM/Factories/Test.rsc
```

Force a specific class to be reloaded:


##Find the class sysId (usually in its factory get function), then unset it before running your program.

```
:global MtmFacts;
:local sysId "tool-time-epoch";
:local objFact [($MtmFacts->"getObjects")];
:local sObj [($objFact->"getStore") $sysId];
:set ($sObj->"obj"->($sObj->"hash"));

```

##remove specific tool from large object cache
```
:local sysId "tool-parsing-json-dec";
:global MtmSM0;
:if (($MtmSM0->$sysId) != nil) do={
	:set ($MtmSM0->$sysId);
}
```