

:local scr (":global MtmFacts; :local mVal [(\$MtmFacts->\"importFile\") $wrkPath];");
		:set ($trkObj->"id") [:execute script=$scr file=([($MtmFacts->"getNullFile")])];


:global MtmLocks;
:local mState 0;
:local lock;
:local mName "dcsLogs";
:local isDone 0;
:while ($isDone = 0) do={
	:set lock ($MtmLocks->$mName);
	:if ([:typeof $lock] = "nothing" && $mState = 1) do={
		:set mState 0;
		:put ("unlocked!");
	}
	:if ([:typeof $lock] != "nothing" && $mState = 0) do={
		:set mState 1;
		:put ("locked!");
	}
}