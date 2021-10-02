:set ($s->"getAdminMacAddress") do={
	:return [/interface bridge get |MTMD| admin-mac];
}