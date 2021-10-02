:set ($s->"getVlanId") do={
	:return [/interface vlan get |MTMD| vlan-id];
}