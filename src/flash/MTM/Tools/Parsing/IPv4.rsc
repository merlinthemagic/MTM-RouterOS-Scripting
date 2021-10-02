:local classId "tool-parsing-ipv4";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmT;
:if (($MtmT->$classId) = nil) do={
	
	:local s [:toarray ""];
	
	:set ($s->"isValid") do={
	
		:global MtmFacts;
		:local method "Tools->Parsing->IPv4->isValid";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Input address is mandatory"];
		}
		:local throw true;
		:if ($1 = false) do={
			:set throw false;
		}
		
		:local isValid true;
		:local pos;
		:local oct;
		:local octNum;
		:local rAddr $0;
		:for x from=0 to=3 do={
			:set pos [:find $rAddr "."];
			:if ([:typeof $pos] = "num") do={
				:set oct [:pick $rAddr 0 $pos];
				:set rAddr [:pick $rAddr ($pos + 1) [:len $rAddr]];
			} else={
				:set oct $rAddr;
				:set rAddr "";
			}
			:set octNum [:tonum $oct];
			:if ([:tostr $octNum] != $oct || $octNum < 0 || $octNum > 255) do={
				:set isValid false;
			}
		}
		
		:if ($isValid = true && $rAddr = "") do={
			:return true;
		}
		:if ($throw = true) do={
			[($MtmFacts->"throwException") method=$method msg=("Not a valid IPv4 address: '".$0."'")];
		}
		:return false;
	}
	:set ($s->"isRFC1918") do={
	
		:global MtmFacts;
		:local method "Tools->Parsing->IPv4->isRFC1918";
		:local param1;
		:if ($0 != nil) do={
			:set param1 $0;
		} else={
			[($MtmFacts->"throwException") method=$method msg="Input address is mandatory"];
		}
		:local input [:tostr $param1];
		:local oct;
		:local pos [:find $input "."];
		:if ([:typeof $pos] = "num") do={
			:set oct [:pick $input 0 $pos];
			:if ($oct = 10) do={
				# 10.0.0.0        -   10.255.255.255  (10/8 prefix)
				:return true;
			}
			:if ($oct = 192) do={
				:set input ([:pick $input ($pos + 1) [:len $input]]);
				:set pos [:find $input "."];
				:set oct [:pick $input 0 $pos];
				:if ($oct = 168) do={
					#192.168.0.0     -   192.168.255.255 (192.168/16 prefix)
					:return true;
				}
			}
			:if ($oct = 172) do={
				:set input ([:pick $input ($pos + 1) [:len $input]]);
				:set pos [:find $input "."];
				:set oct [:pick $input 0 $pos];
				:if ($oct > 15 && $oct < 32) do={
					#172.16.0.0      -   172.31.255.255  (172.16/12 prefix)
					:return true;
				}
			}
		}
		:return false;
	}
	:set ($s->"getSubnetAddress") do={
	
		:global MtmFacts;
		:local method "Tools->Parsing->IPv4->getSubnetAddress";
		:local param1;
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Input address is mandatory"];
		}
		
		:local self [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getIPv4()"];
		:local addr [($self->"getAddress") $0];
		:local cidr [($self->"getCidr") $0];
		:local mask [($self->"getMaskFromCidr") $cidr];
		:return ($addr&$mask);
	}
	:set ($s->"getAddress") do={
		
		#returns 192.168.0.4 from e.g. 192.168.0.4/27
		:global MtmFacts;
		:local method "Tools->Parsing->IPv4->getAddress";
		:local param1;
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Input is mandatory"];
		}
		:local addr $0; #address
		:local pos [:find $addr "/"];
		:if ([:typeof $pos] = "num") do={
			#its a combined address, e.g. 192.168.88.77/24
			:set addr [:pick $addr 0 $pos];
		}
		:local self [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getIPv4()"];
		:if ([($self->"isValid") $addr false] = true) do={
			:return [:toip $addr];
		}		
		[($MtmFacts->"throwException") method=$method msg=("Not handled for input: '".$0."'")];
	}
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
		
		:local self [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getIPv4()"];
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
		:local self [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getIPv4()"];
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
	
	:set ($MtmT->$classId) $s;
}
