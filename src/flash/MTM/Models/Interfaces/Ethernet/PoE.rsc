#POE methods
:set ($s->"getPoeOutStatus") do={
	:global MtmFacts;
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local rData [($self->"monitorPoeOnce")];
	:return ($rData->"poe-out-status");
}
:set ($s->"getPoeOutVoltageMode") do={
	:global MtmFacts;
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local rData [($self->"monitorPoeOnce")];
	:return ($rData->"poe-voltage");
}
:set ($s->"getPoeOutVoltage") do={
	:global MtmFacts;
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local rData [($self->"monitorPoeOnce")];
	:return ($rData->"poe-out-voltage");
}
:set ($s->"getPoeOutMode") do={
	:global MtmFacts;
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local rData [($self->"monitorPoeOnce")];
	:return ($rData->"poe-out");
}
:set ($s->"getPoeOutCurrent") do={
	:global MtmFacts;
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local rData [($self->"monitorPoeOnce")];
	:return ($rData->"poe-out-current");
}
:set ($s->"getPoeOutWatts") do={
	:global MtmFacts;
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local rData [($self->"monitorPoeOnce")];
	:return ($rData->"poe-out-power");
}