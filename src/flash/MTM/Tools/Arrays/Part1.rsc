:set ($s->"implode") do={
	:global MtmFacts;
	:local method "Tools->Arrays->implode";
	:if ($0 = nil || $1 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Delimitor and array input is mandatory"];
	}
	:local param1 $0; #delimitor
	:local param2 $1; #array
	:local rData "";
	:local rCount 0;
	:local rType "";
	:local rValue "";
	:local isDone false;
	:foreach val in=$param2 do={
		:set isDone false;
		:set rType [:typeof $val];
		:if ($isDone = false && ($rType = "str" || $rType = "num")) do={
			:set rValue $val;
			:set isDone true;
		}
		:if ($isDone = false && ($rType = "nil" || $rType = "nothing")) do={
			:set rValue "";
			:set isDone true;
		}
		:if ($isDone = false) do={
			[($MtmFacts->"throwException") method=$method msg=("Not handled for data type: ".$rType)];
		}
		
		:if ($rCount = 0) do={
			:set rData $rValue;
		} else={
			:set rData ($rData.$param1.$rValue);
		}
		:set rCount ($rCount + 1);
	}
	:return $rData;
}
:set ($s->"contains") do={

	##by default will make everything lower case and match
	##not yet handling differnet data types
	
	:global MtmFacts;
	:local method "Tools->Arrays->contains";
	:if ($0 = nil || $1 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Search and array input is mandatory"];
	}
	:local param1 $0; #find
	:local param2 $1; #array

	:local sType [:typeof $param1];
	:if ($sType != "str") do={
		[($MtmFacts->"throwException") method=$method msg=("Not handled for search data type: ".$sType)];
	}
	
	:local strTool [($MtmFacts->"execute") nsStr="getTools()->getStrings()"];
	:local sValue [($strTool->"toLower") $param1];
	:local rType "";
	:local rValue "";
	:foreach val in=$param2 do={
		:set rType [:typeof $val];
		:if ($rType = "str") do={
			:set rValue [($strTool->"toLower") $val];
			:if ($rValue = $sValue) do={
				:return true;
			}
		} else={
			[($MtmFacts->"throwException") method=$method msg=("Not handled for data type: ".$rType)];
		}
	}
	:return false;
}