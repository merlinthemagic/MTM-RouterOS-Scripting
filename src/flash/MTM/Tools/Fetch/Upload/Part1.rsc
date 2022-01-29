:set ($s->"postJson") do={

	:global MtmFacts;
	:local method "Tools->Fetch->Upload->postJson";
	:local param1; #url
	:local param2; #data
	:local param3; #throw
	:local param4; #port
	:if ($0 != nil) do={
		:set param1 $0;
		:if ($1 != nil) do={
			:set param2 $1;
		}
		:if ($2 != nil) do={
			:set param3 $2;
		}
		:if ($3 != nil) do={
			:set param4 $3;
		}
	} else={
		:if ($url != nil) do={
			:set param1 $url;
			:if ($data != nil) do={
				:set param2 $data;
			}
			:if ($throw != nil) do={
				:set param3 $throw;
			}
			:if ($port != nil) do={
				:set param4 $port;
			}
		} else={
			[($MtmFacts->"throwException") method=$method msg="Url is mandatory"];
		}
	}
	:if ($param3 = nil) do={
		:set param3 false;
	}
	:if ([:typeof $param1] != "str") do={
		[($MtmFacts->"throwException") method=$method msg="Url must be string"];
	}
	
	:local dType [:typeof $param2];
	:if ($dType != "str" && $dType != "array") do={
		[($MtmFacts->"throwException") method=$method msg=("Data input type: '$dType', not handled")];
	}
	:if ($dType = "array") do={
		:local nsStr "getTools()->getParsing()->getJsonEncode()";
		:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];
		:set param2 [($toolObj->"getFromArray") data=$param2];
	}
	:if ([:len $param2] > 65535) do={
		[($MtmFacts->"throwException") method=$method msg=("Payload is too large. Maximum is 65535")];
	}

	:local scheme;
	:if ([:find $param1 "https://"] = 0) do={
		:set scheme "https";
		:if ($param4 = nil) do={
			:set param4 443;
		}
	}
	:if ($scheme = nil) do={
		:if ([:find $param1 "http://"] = 0) do={
			:set scheme "http";
			:if ($param4 = nil) do={
				:set param4 80;
			}
		}
	}
	:if ($scheme = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Url must start with http://"];
	}
	
	:local result;
	:if ($scheme = "https") do={
		:set result [/tool fetch check-certificate=yes mode=https port=$param4 url=$param1 http-header-field="Content-Type: application/json" http-method=post http-data="$param2" output=none as-value];
	}
	:if ($scheme = "http") do={
		:set result [/tool fetch mode=http port=$param4 url=$param1 http-header-field="Content-Type: application/json" http-method=post http-data="$param2" output=none as-value];
	}
	:if ($result->"status" = "finished") do={
		:return $result;
	}
	:if ($param3 = true) do={
		[($MtmFacts->"throwException") method=$method msg=("Fetch completed with status: ".$result->"status")];
	}
	#default return result
	:return $result;
}
