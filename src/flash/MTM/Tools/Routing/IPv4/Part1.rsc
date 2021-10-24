:set ($s->"getActiveGatewayAddress") do={
	:return [/ip route get [find dst-address="0.0.0.0/0" && active=yes && routing-mark=[:nothing]] gateway];
}