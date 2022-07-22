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
	
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
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
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:if ([($self->"isValid") $addr false] = true) do={
		:return [:toip $addr];
	}		
	[($MtmFacts->"throwException") method=$method msg=("Not handled for input: '".$0."'")];
}