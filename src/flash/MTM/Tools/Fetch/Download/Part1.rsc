:set ($s->"getHttpToFile") do={

	:global MtmFacts;
	:local method "Tools->Fetch->Download->httpToFile";
	:local param1; #url
	:local param2 "fetchDownload.txt"; #dstFile
	:local param3; #port
	:local param4 false; #throw
	:if ($0 != nil) do={
		:set param1 $0;
		:if ([:typeof $1] = "str") do={
			##allows user to set to [:nothing], if a custom port is desired, but using default file
			:set param2 $1;
		}
		:if ($2 != nil) do={
			:set param3 $2;
		}
		:if ($3 != nil) do={
			:set param4 $3;
		}

	} else={
		[($MtmFacts->"throwException") method=$method msg="Url is mandatory"];
	}
	:if ([:typeof $param1] != "str") do={
		[($MtmFacts->"throwException") method=$method msg="Url must be string"];
	}
	:if ([:typeof $param2] != "str") do={
		[($MtmFacts->"throwException") method=$method msg="Dst file must be string"];
	}
	
	:local scheme;
	:if ([:find $param1 "https://"] = 0) do={
		:set scheme "https";
		:if ($param3 = nil) do={
			:set param3 443;
		}
	}
	:if ($scheme = nil) do={
		:if ([:find $param1 "http://"] = 0) do={
			:set scheme "http";
			:if ($param3 = nil) do={
				:set param3 80;
			}
		}
	}
	:if ($scheme = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Url must start with http://"];
	}
	:if ([:typeof $param3] != "num") do={
		[($MtmFacts->"throwException") method=$method msg="Port must be int"];
	}
	:if ($param4 != true) do={
		:set param4 false; #lazy check
	}

	:local result;
	:if ($scheme = "https") do={
		:set result [/tool fetch mode=https port=$param3 url=$param1 http-method=get dst-path=$param2 check-certificate=yes output=file as-value];
	}
	:if ($scheme = "http") do={
		:set result [/tool fetch mode=http port=$param3 url=$param1 http-method=get dst-path=$param2 output=file as-value];
	}
	:set ($result->"dstFile") $param2;

	:if (($result->"status") = "finished") do={
		:return $result;
	}
	:if ($param3 = true) do={
		[($MtmFacts->"throwException") method=$method msg=("Fetch completed with status: ".($result->"status"))];
	}
	#default return result
	:return $result;
}
:set ($s->"ftpAsVariable") do={

	:global MtmFacts;
	:local method "Tools->Fetch->Download->ftpAsVariable";

	:local srcPath $0;
	:local address $1;
	:local username $2;
	:local password $3;
	:local port 21;
	:if ($0 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Source path is mandatory"];
	}
	:if ($1 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Address is mandatory"];
	}
	:if ($4 != nil) do={
		:set port $4;
	}

	:local url ("ftp://".$address."/".$srcPath);
	:local result;
	:if ($username != nil) do={
		:set result [/tool fetch mode=ftp url=$url port=$port user=$username password=$password output=user as-value];
	} else={
		[($MtmFacts->"throwException") method=$method msg="Not handled when username not specified"];
	}
	
	:if (($result->"status") != "finished") do={
		[($MtmFacts->"throwException") method=$method msg=("Download ended with status: ".($result->"status"))];
	}
	
	:return ($result->"data");
}