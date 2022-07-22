:set ($s->"getName") do={
	:return [/ip pool get |MTMD| name];
}
:set ($s->"getUsedCount") do={
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:return [:len [/ip pool used find where pool=([($self->"getName")])]];
}
:set ($s->"getNextPoolName") do={
	:return [/ip pool get |MTMD| next-pool];
}
