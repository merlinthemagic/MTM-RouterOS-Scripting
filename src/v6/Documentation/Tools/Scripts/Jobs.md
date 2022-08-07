#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local nsStr "getTools()->getScripts()->getJobs()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:


### getLastByScriptName:

```
:local scriptName "myScript";
:local result [($toolObj->"getLastByScriptName") $scriptName];
:put ($result); #"array obj or nil if no job with that name was found";

:if ($result) do={
	##array obj: jobId=*40291;scriptName=myScript;started=1643957102
} else {
	##no such script is currently running
}
```
