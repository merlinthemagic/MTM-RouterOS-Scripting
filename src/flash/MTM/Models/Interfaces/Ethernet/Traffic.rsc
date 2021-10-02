:set ($s->"getTxUnicast") do={
	:global MtmCache;
	:local val [($MtmCache->"strReplace") ([/interface ethernet get |MTMD| tx-unicast]) " " ""];
	:if ([:len $val] = 0) do={
		:global MtmO2; #not counting unicast
		:local self ($MtmO2->"|MTMC|");
		:set val ([($self->"getTxPackets")] - ([($self->"getTxMulticast")] + [($self->"getTxBroadcast")]));
	}
	:return [:tonum $val];
}
:set ($s->"getRxUnicast") do={
	:global MtmCache;
	:local val [($MtmCache->"strReplace") ([/interface ethernet get |MTMD| rx-unicast]) " " ""];
	:if ([:len $val] = 0) do={
		:global MtmO2; #not counting unicast
		:local self ($MtmO2->"|MTMC|");
		:set val ([($self->"getRxPackets")] - ([($self->"getRxMulticast")] + [($self->"getRxBroadcast")]));
	}
	:return [:tonum $val];
}
:set ($s->"getTxMulticast") do={
	:global MtmCache;
	:return [:tonum [($MtmCache->"strReplace") ([/interface ethernet get |MTMD| tx-multicast]) " " ""]];
}
:set ($s->"getRxMulticast") do={
	:global MtmCache;
	:return [:tonum [($MtmCache->"strReplace") ([/interface ethernet get |MTMD| rx-multicast]) " " ""]];
}
:set ($s->"getTxBroadcast") do={
	:global MtmCache;
	:return [:tonum [($MtmCache->"strReplace") ([/interface ethernet get |MTMD| tx-broadcast]) " " ""]];
}
:set ($s->"getRxBroadcast") do={
	:global MtmCache;
	:return [:tonum [($MtmCache->"strReplace") ([/interface ethernet get |MTMD| rx-broadcast]) " " ""]];
}
:set ($s->"getTxErrorCount") do={
	:global MtmO2;
	:local self ($MtmO2->"|MTMC|");
	:local v [:toarray ""];
	:set ($v->0) [/interface ethernet get |MTMD| rx-align-error];
	:set ($v->1) [/interface ethernet get |MTMD| rx-code-error];
	:set ($v->2) [/interface ethernet get |MTMD| rx-drop];
	:set ($v->3) [/interface ethernet get |MTMD| rx-length-error];
	:set ($v->4) [/interface ethernet get |MTMD| rx-overflow];
	:set ($v->5) [/interface ethernet get |MTMD| rx-tcp-checksum-error];
	:set ($v->6) [/interface ethernet get |MTMD| rx-too-long];
	:set ($v->7) [/interface ethernet get |MTMD| rx-too-short];
	:set ($v->8) [/interface ethernet get |MTMD| rx-udp-checksum-error];
	:local count 0;
	:global MtmCache;
	:foreach val in=$v do={
		:if ([:len $val] > 0) do={
			:set count ($count+[($MtmCache->"strReplace") $val " " ""]);
		}
	}
	:return $count;
}
:set ($s->"getRxErrorCount") do={
	:global MtmO2;
	:local self ($MtmO2->"|MTMC|");
	:local v [:toarray ""];
	:set ($v->0) [/interface ethernet get |MTMD| tx-drop];
	:set ($v->1) [/interface ethernet get |MTMD| tx-fcs-error];
	:set ($v->2) [/interface ethernet get |MTMD| tx-too-long];
	:set ($v->3) [/interface ethernet get |MTMD| tx-too-short];
	:local count 0;
	:global MtmCache;
	:foreach val in=$v do={
		:if ([:len $val] > 0) do={
			:set count ($count+[($MtmCache->"strReplace") $val " " ""]);
		}
	}
	:return $count;
}
