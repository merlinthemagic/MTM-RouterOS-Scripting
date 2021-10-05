:set ($s->"getVersion") do={
	:return 6;
}
:set ($s->"getSubnetAddress") do={
	:global MtmFacts;
	:local ipv6Tool [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getIPv6()"];
	:return [($ipv6Tool->"getSubnetAddress") ([/ipv6 address get |MTMD| address])];
}
:set ($s->"getAddress") do={
	:global MtmFacts;
	:local ipv6Tool [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getIPv6()"];
	:return [($ipv6Tool->"getAddress") ([/ipv6 address get |MTMD| address])];
}
:set ($s->"getCidr") do={
	:global MtmFacts;
	:local ipv6Tool [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getIPv6()"];
	:return [($ipv6Tool->"getCidr") ([/ipv6 address get |MTMD| address])];
}