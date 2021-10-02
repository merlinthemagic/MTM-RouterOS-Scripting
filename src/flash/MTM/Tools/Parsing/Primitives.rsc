:local classId "tool-parsing-primis";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmT;
:if (($MtmT->$classId) = nil) do={
	
	:local s [:toarray ""];
	
	:set ($s->"toBool") do={
		:global MtmFacts;
		:local method "Tools->Parsing->Primitives->toBool";
		:local param1;
		:if ($0 != nil) do={
			:set param1 $0;
		} else={
			[($MtmFacts->"throwException") method=$method msg="Input is mandatory"];
		}
		:if ([:typeof $param1] = "bool") do={
			:return $param1;
		}
		:if ([:typeof $param1] = "str") do={
			:if ($param1 = "true") do={
				:return true;
			}
			:if ($param1 = "false") do={
				:return false;
			}
		}
		[($MtmFacts->"throwException") method=$method msg=("Input not handled: ".$param1)];	
	}
	:set ($s->"isBool") do={
		:global MtmFacts;
		:local method "Tools->Parsing->Primitives->isBool";
		:local param1;
		:if ($0 != nil) do={
			:set param1 $0;
		} else={
			[($MtmFacts->"throwException") method=$method msg="Input is mandatory"];
		}
		:if ([:typeof $param1] = "bool") do={
			:return true;
		}
		:if ([:typeof $param1] = "str") do={
			#not sure this is a good idea
			:if ($param1 = "true") do={
				:return true;
			}
			:if ($param1 = "false") do={
				:return true;
			}
		}
		:return false;
	}
	:set ($s->"toNil") do={
		:global MtmFacts;
		:local method "Tools->Parsing->Primitives->toNil";
		:local param1;
		:if ($0 != nil) do={
			:set param1 $0;
		} else={
			[($MtmFacts->"throwException") method=$method msg="Input is mandatory"];
		}
		:if ([:typeof $param1] = "nil") do={
			:return $param1;
		}
		:if ([:typeof $param1] = "str") do={
			:if ($param1 = "nil") do={
				:return $null;
			}
		}
		[($MtmFacts->"throwException") method=$method msg=("Input not handled: ".$param1)];	
	}
	:set ($s->"isNil") do={
		:global MtmFacts;
		:local method "Tools->Parsing->Primitives->isNil";
		:local param1;
		:if ($0 != nil) do={
			:set param1 $0;
		} else={
			[($MtmFacts->"throwException") method=$method msg="Input is mandatory"];
		}
		:if ([:typeof $param1] = "nil") do={
			:return true;
		}
		:if ([:typeof $param1] = "str") do={
			:if ($param1 = "nil") do={
				:return true;
			}
		}
		:return false;
	}
	:set ($s->"isEmpty") do={
		:global MtmFacts;
		:local method "Tools->Parsing->Primitives->isEmpty";
		:local type [:typeof $0];
		:if ($type = "str") do={
			:if ($0 = "") do={
				:return true;
			}
			:return false;
		}
		:if ($type = "nil") do={
			:return true;
		}
		:if ($type = "nothing") do={
			:return true;
		}
		:if ($type = "num") do={
			:return false; ##dont follow in PHP's footsteps
		}
		:if ($type = "array") do={
			:if ([:len $0] = 0) do={
				:return true;
			}
			:return false;
		}
		:if ($type = "bool") do={
			:if ($0 = false) do={
				:return true;
			}
			:return false;
		}
		[($MtmFacts->"throwException") method=$method msg=("Input not handled for type: ".$type)];	
	}
	:set ($MtmT->$classId) $s;
}
