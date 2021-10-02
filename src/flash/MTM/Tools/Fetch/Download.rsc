:local classId "tool-fetch-download";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmTF;
:if (($MtmTF->$classId) = nil) do={

	:local s [:toarray ""];
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
	:set ($MtmTF->$classId) $s;
}
