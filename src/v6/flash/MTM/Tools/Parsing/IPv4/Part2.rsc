:set ($s->"getCidr") do={

	:global MtmFacts;
	:local method "Tools->Parsing->IPv4->getCidr";
	:local param1;
	:if ($0 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Input is mandatory"];
	}
	:local cidr $0; #cidr
	:if ([:typeof $cidr] != "num") do={
		:local pos [:find $cidr "/"];
		:if ([:typeof $pos] = "num") do={
			:set cidr [:pick $cidr ($pos + 1) [:len $cidr]];
		}
	}
	:set cidr [:tonum $cidr];
	:if ($cidr > -1 && $cidr < 33) do={
		:return $cidr;
	}
	[($MtmFacts->"throwException") method=$method msg=("Not handled for input: '".$0."'")];
}
:set ($s->"getBroadcastAddress") do={

	:global MtmFacts;
	:local method "Tools->Parsing->IPv4->getBroadcastAddress";
	:local param1;
	:if ($0 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Input address is mandatory"];
	}
	
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local addr [($self->"getAddress") $0];
	:local cidr [($self->"getCidr") $0];
	:local mask [($self->"getMaskFromCidr") $cidr];
	:return ($addr|$mask);
}
:set ($s->"getMaskFromCidr") do={

	:global MtmFacts;
	:local method "Tools->Parsing->IPv4->getMaskFromCidr";
	:local param1;
	:if ($0 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="CIDR is mandatory"];
	}
	:local cidr [:tonum $0]
	:if ($cidr < 0 || $cidr > 32) do={
		[($MtmFacts->"throwException") method=$method msg=("CIDR is invalid: '".$0."'")];
	}
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local masks ($self->"cidrMasks");
	:return [:toip ($masks->$cidr)];
}

##attribute
:local masks [:toarray ""]
:set ($masks->0) "0.0.0.0";
:set ($masks->1) "128.0.0.0";
:set ($masks->2) "192.0.0.0";
:set ($masks->3) "224.0.0.0";
:set ($masks->4) "240.0.0.0";
:set ($masks->5) "248.0.0.0";
:set ($masks->6) "252.0.0.0";
:set ($masks->7) "254.0.0.0";
:set ($masks->8) "255.0.0.0";
:set ($masks->9) "255.128.0.0";
:set ($masks->10) "255.192.0.0";
:set ($masks->11) "255.224.0.0";
:set ($masks->12) "255.240.0.0";
:set ($masks->13) "255.248.0.0";
:set ($masks->14) "255.252.0.0";
:set ($masks->15) "255.254.0.0";
:set ($masks->16) "255.255.0.0";
:set ($masks->17) "255.255.128.0";
:set ($masks->18) "255.255.192.0";
:set ($masks->19) "255.255.224.0";
:set ($masks->20) "255.255.240.0";
:set ($masks->21) "255.255.248.0";
:set ($masks->22) "255.255.252.0";
:set ($masks->23) "255.255.254.0";
:set ($masks->24) "255.255.255.0";
:set ($masks->25) "255.255.255.128";
:set ($masks->26) "255.255.255.192";
:set ($masks->27) "255.255.255.224";
:set ($masks->28) "255.255.255.240";
:set ($masks->29) "255.255.255.248";
:set ($masks->30) "255.255.255.252";
:set ($masks->31) "255.255.255.254";
:set ($masks->32) "255.255.255.255";
:set ($s->"cidrMasks") $masks;