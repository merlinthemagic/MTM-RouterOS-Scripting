:local s [:toarray ""];
:set ($s->"getId") do={
	:return "|MTMD|";
}
:set ($s->"getName") do={
	:return [/interface get |MTMD| name];
}
:set ($s->"getMacAddress") do={
	:return [/interface get |MTMD| mac-address];
}
:set ($s->"getMTU") do={
	:return [/interface get |MTMD| mtu];
}
:set ($s->"getL2MTU") do={
	:return [/interface get |MTMD| l2mtu];
}
:set ($s->"getComment") do={
	:return [/interface get |MTMD| comment];
}
:set ($s->"setComment") do={
	:return [/interface set |MTMD| comment=$0];
}
:set ($s->"isRunning") do={
	:return [/interface ethernet get |MTMD| running];
}
:set ($s->"getDisabled") do={
	:return [/interface get |MTMD| disabled];
}
:set ($s->"setDisabled") do={
	:local value "no";
	:if ($0 = true) do={
		:set value "yes";
	}
	:return [/interface set |MTMD| disabled=$value];
}
:set ($s->"getTxBytes") do={
	:return [/interface get |MTMD| tx-byte];
}
:set ($s->"getRxBytes") do={
	:return [/interface get |MTMD| rx-byte];
}
:set ($s->"getTxPackets") do={
	:return [/interface get |MTMD| tx-packet];
}
:set ($s->"getRxPackets") do={
	:return [/interface get |MTMD| rx-packet];
}
:set ($s->"getTxDrops") do={
	:return [/interface get |MTMD| tx-drop];
}
:set ($s->"getRxDrops") do={
	:return [/interface get |MTMD| rx-drop];
}
:set ($s->"getIPAddresses") do={
	:global MtmFacts;
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local c 0;
	:local rObjs [:toarray ""];
	:local factObj [($MtmFacts->"execute") nsStr="getIP()->getAddresses()"];
	:foreach id in=[/ip address find interface=([($self->"getName")])] do={
		:set ($rObjs->"$c") [($factObj->"getV4ById") $id];
		:set c ($c + 1);
	}
	:foreach id in=[/ipv6 address find interface=([($self->"getName")])] do={
		:set ($rObjs->"$c") [($factObj->"getV6ById") $id];
		:set c ($c + 1);
	}
	:return $rObjs;
}