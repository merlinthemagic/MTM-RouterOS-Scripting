:local s [:toarray ""];
:set ($s->"getId") do={
	:return "|MTMD|";
}
:set ($s->"getVersion") do={
	:return 4;
}
:set ($s->"getSubnetAddress") do={
	:global MtmFacts;
	:local ipv4Tool [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getIPv4()"];
	:return [($ipv4Tool->"getSubnetAddress") ([/ip address get |MTMD| address])];
}
:set ($s->"getAddress") do={
	:global MtmFacts;
	:local ipv4Tool [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getIPv4()"];
	:return [($ipv4Tool->"getAddress") ([/ip address get |MTMD| address])];
}
:set ($s->"getCidr") do={
	:global MtmFacts;
	:local ipv4Tool [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getIPv4()"];
	:return [($ipv4Tool->"getCidr") ([/ip address get |MTMD| address])];
}