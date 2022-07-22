:set ($s->"getFromArray") do={

	#todo: escape special chars: /\"\'\b\f\t\r\n.
	
	:global MtmFacts;
	:local method "Tools->Parsing->JsonEncode->getFromArray";
	:local param1;
	:if ($0 != nil) do={
		:set param1 $0;
	} else={
		:if ($data != nil) do={
			:set param1 $data;
		} else={
			[($MtmFacts->"throwException") method=$method msg="Data is mandatory"];
		}
	}

	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	
	:local rData "";
	:local isArr 1;
	:local vType "";
	:local count 0;
	:if ([:typeof $param1] = "array") do={
		# determine if the first dimention is an object or an array
		:foreach prop,value in=$param1 do={
			:if ([:typeof $prop] != "num") do={
				#indexes are not purely numeric, we need to use an object for named indexes
				:set isArr 0;
			}
		}
		
		:if ($isArr = 0) do={
			:set rData "{";
		} else={
			:set rData "[";
		}
		
		:foreach prop,value in=$param1 do={
		
			:if ($count > 0) do={
				:set rData ($rData.",");
			} else={
				:set count 1;
			}
			:if ($isArr = 0) do={
				:set rData ($rData."\"$prop\":");
			}
			:set vType [:typeof $value];
			
			:if ($vType = "str" || $vType = "time") do={
				:set rData ($rData."\"$value\"");
				:set vType "";
			}
			:if ($vType = "bool" || $vType = "num") do={
				:set rData ($rData.$value);
				:set vType "";
			}
			:if ($vType = "nil") do={
				#src: https://stackoverflow.com/questions/21120999/representing-null-in-json
				:set rData ($rData."null");
				:set vType "";
			}
			:if ($vType = "array") do={
				:set rData ($rData.[($self->"getFromArray") data=$value]);
				:set vType "";
			}
			:if ($vType != "") do={
				[($MtmFacts->"throwException")  method=$method msg=("Property: '".$prop."', input not handled for datatype: '$vType'")];
			}
		}
		
		:if ($isArr = 0) do={
			:set rData ($rData."}");
		} else={
			:set rData ($rData."]");
		}
		:return $rData;
	}
		
	[($MtmFacts->"throwException") method=$method msg=("Input not handled for datatype: ".[:typeof $param1])];	
}