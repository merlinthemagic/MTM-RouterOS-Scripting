:set ($s->"getAttributes") do={

	:global MtmFacts;
	:local method "Tools->Interfaces->Ethernet->getAttributes";
	:local param1;
	:local param2;
	:if ($0 != nil) do={
		:set param1 $0;
		:if ($1 != nil) do={
			:set param2 $1;
		}
	} else={
		:if ($name != nil) do={
			:set param1 $name;
			:if ($attrs != nil) do={
				:set param2 $attrs;
			}
		} else={
			[($MtmFacts->"throwException") method=$method msg="Interface name is mandatory"];
		}
	}
	:if ($param2 = nil) do={
		:local nsStr "getTools()->getInterfaces()->getEthernet()->getProperties(name='$param1' throw='false')";
		:set param2 [($MtmFacts->"execute") nsStr=$nsStr];
	}
	:local toolObj [($MtmFacts->"execute") nsStr="getTools()->getStrings()"];
	:local rObj;
	:local val0;
	:local val1;
	:local val2;
	:local val3;
	:local val4;

	:set val1 [/interface ethernet find where name=$param1];
	:if ($val1 != "") do={
		:set rObj [:toarray ""];
		:foreach attr in=$param2 do={
			
			:set val0 [/interface ethernet get $val1 $attr];
			:set val2 0;

			:if ($attr~"rx-" || $attr~"tx-") do={
				:set val0 [($toolObj->"replace") str=$val0 find=" " replace=""];
				:set val2 1;
			}
			:if ($val2 = 0 && $attr = "mac-address") do={
				:set val0 [($toolObj->"replace") str=$val0 find=":" replace=""];
				:set val2 1;
			}
			:if ($val2 = 0 && [:typeof $val0] = "array") do={
				:set val4 0;
				:set val3 $val0;
				:set val0 [:toarray ""];
				:foreach item in=$val3 do={
					:set ($val0->$val4) $item;
					:set val4 ($val4 + 1);
				}
				:set val2 1;
			}
			:set ($rObj->$attr) $val0;
		}
	}
	:if ($rObj != nil) do={
		:return $rObj;
	}
	
	[($MtmFacts->"throwException")  method=$method msg=("No interface with name: '$param1'")];
}
:set ($s->"getProperties") do={

	:global MtmFacts;
	:local method "Tools->Interfaces->Ethernet->getProperties";
	:local param1;
	:local param2;
	:if ($0 != nil) do={
		:set param1 $0;
		:if ($1 != nil) do={
			:set param2 $1;
		}
	} else={
		:if ($name != nil) do={
			:set param1 $name;
			:if ($throw != nil) do={
				:set param2 $throw;
			}
		} else={
			[($MtmFacts->"throwException") method=$method msg="Interface name is mandatory"];
		}
	}
	:if ($param2 = nil) do={
		:set param2 false;
	}
	:local rData;
	:local i 0;
	:if ([/interface ethernet find where name=$param1] != "") do={
		:foreach prop,val in=[/interface ethernet get [find where name=$param1]] do={
			:if ($prop != ".id") do={
				:if ($i > 0) do={
					:set rData ($rData.",");
				} else={
					:set rData "";
					:set i 1;
				}
				:set rData ($rData.$prop);
			}
		}
	}
	:if ($rData != nil) do={
		:set rData [:toarray $rData];
		:return $rData;
	}
	:if ($param2 = true) do={
		[($MtmFacts->"throwException")  method=$method msg=("No interface with name: '$param1'")];
	}
	:return [($MtmFacts->"getNull")];
}