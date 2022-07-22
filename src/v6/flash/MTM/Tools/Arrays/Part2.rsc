:set ($s->"merge") do={

	##If the input arrays have the same string keys, 
	##then the later value for that key will overwrite the previous one. 
	##If, however, the arrays contain numeric keys, the later value will not overwrite the original value, 
	##but will be appended.
	
	:global MtmFacts;
	:local method "Tools->Arrays->merge";
	:if ($0 = nil || $1 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="array inputs are mandatory"];
	}
	:if ([:typeof $0] != "array" || [:typeof $1] != "array") do={
		[($MtmFacts->"throwException") method=$method msg="Inputs must be arrays"];
	}
	:local rData [:toarray ""];
	:local rCount 0;
	:local rDone false;
	:local rType "";
	:local param1 $0; #array1
	:local param2 $1; #array2
	
	:foreach index,val in=$param1 do={
		:set rDone false;
		:set rType [:typeof $index];
		:if ($rType = "str") do={
			:set ($rData->$index) $val;
			:set rDone true;
		}
		:if ($rType = "num") do={
			:set ($rData->$rCount) $val;
			:set rCount ($rCount + 1);
			:set rDone true;
		}
		:if ($rDone = false) do={
			[($MtmFacts->"throwException") method=$method msg=("Not handled for data type: ".$rType)];
		}
	}
	
	:foreach index,val in=$param2 do={
		:set rDone false;
		:set rType [:typeof $index];
		:if ($rType = "str") do={
			:set ($rData->$index) $val;
			:set rDone true;
		}
		:if ($rType = "num") do={
			:set ($rData->$rCount) $val;
			:set rCount ($rCount + 1);
			:set rDone true;
		}
		:if ($rDone = false) do={
			[($MtmFacts->"throwException") method=$method msg=("Not handled for data type: ".$rType)];
		}
	}

	:return $rData;
}
:set ($s->"keyExists") do={

	##by default will make everything lower case and match
	##not yet handling differnet data types
	
	:global MtmFacts;
	:local method "Tools->Arrays->keyExists";
	:if ($0 = nil || $1 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Search and array input is mandatory"];
	}
	:local param1 $0; #find key
	:local param2 $1; #array

	:local sType [:typeof $param1];
	:if ($sType != "str") do={
		[($MtmFacts->"throwException") method=$method msg=("Not handled for search data type: ".$sType)];
	}
	
	:local strTool [($MtmFacts->"execute") nsStr="getTools()->getStrings()"];
	:local sValue [($strTool->"toLower") $param1];
	:local rType "";
	:local rValue "";
	:foreach key,val in=$param2 do={
		:set rType [:typeof $key];
		:if ($rType = "str") do={
			:set rValue [($strTool->"toLower") $key];
			:if ($rValue = $sValue) do={
				:return true;
			}
		} else={
			[($MtmFacts->"throwException") method=$method msg=("Not handled for data type: ".$rType)];
		}
	}
	:return false;
}