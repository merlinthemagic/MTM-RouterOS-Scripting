:local classId "tool-parsing-ipv6";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmT;
:if (($MtmT->$classId) = nil) do={
	
	:local s [:toarray ""];
	
	:set ($s->"getSubnetAddress") do={
	
		:global MtmFacts;
		:local method "Tools->Parsing->IPv6->getSubnetAddress";
		[($MtmFacts->"throwException") method=$method msg="METHOD NOT READY"];
		:local param1;
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Input address is mandatory"];
		}
		
		:local self [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getIPv6()"];
		:local addr [($self->"getAddress") $0];
		:local cidr [($self->"getCidr") $0];
		:local mask [($self->"getMaskFromCidr") $cidr];
		:return ($addr&$mask);
	}
	:set ($s->"getAddress") do={
		
		#returns fe80::2ec8:1bff:fe82:12f1/64 from e.g. fe80::2ec8:1bff:fe82:12f1/64
		:global MtmFacts;
		:local method "Tools->Parsing->IPv6->getAddress";
		:local param1;
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Input is mandatory"];
		}
		:local addr $0; #address
		:local pos [:find $addr "/"];
		:if ([:typeof $pos] = "num") do={
			#its a combined address, e.g. fe80::2ec8:1bff:fe82:12f1/64
			:set addr [:pick $addr 0 $pos];
		}
		
		#TODO: build validation
		#:local self [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getIPv6()"];
		#:if ([($self->"isValid") $addr false] = true) do={
			:return [:toip6 $addr];
		#}		
		[($MtmFacts->"throwException") method=$method msg=("Not handled for input: '".$0."'")];
	}
	:set ($s->"getCidr") do={
	
		:global MtmFacts;
		:local method "Tools->Parsing->IPv6->getCidr";
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
		:if ($cidr > -1 && $cidr < 129) do={
			:return $cidr;
		}
		[($MtmFacts->"throwException") method=$method msg=("Not handled for input: '".$0."'")];
	}
	
	:set ($MtmT->$classId) $s;
}
