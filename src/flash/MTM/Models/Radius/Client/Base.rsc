:local s [:toarray ""];
:set ($s->"getId") do={
	:return "|MTMD|";
}
:set ($s->"getSrcAddress") do={
	:return [/radius get |MTMD| src-address];
}
:set ($s->"getAccountingBackup") do={
	:return [/radius get |MTMD| accounting-backup];
}
:set ($s->"getAddress") do={
	:return [/radius get |MTMD| address];
}
:set ($s->"getCalledId") do={
	:return [/radius get |MTMD| called-id];
}
:set ($s->"getComment") do={
	:return [/radius get |MTMD| comment];
}
:set ($s->"getAccountingPort") do={
	:return [/radius get |MTMD| accounting-port];
}
:set ($s->"getAuthenticationPort") do={
	:return [/radius get |MTMD| authentication-port];
}
:set ($s->"isDisabled") do={
	:return [/radius get |MTMD| disabled];
}
:set ($s->"getProtocol") do={
	:return [/radius get |MTMD| protocol];
}
:set ($s->"getSecret") do={
	:return [/radius get |MTMD| secret];
}
:set ($s->"getDomain") do={
	:return [/radius get |MTMD| domain];
}
:set ($s->"getRealm") do={
	:return [/radius get |MTMD| realm];
}
:set ($s->"getServices") do={
	:return [/radius get |MTMD| service];
}
:set ($s->"getTimeout") do={
	:return [/radius get |MTMD| timeout];
}