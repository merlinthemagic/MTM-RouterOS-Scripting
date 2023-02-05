:local cPath "MTM/Tools/Json/Encode.rsc";
:local s [:toarray ""];
:set ($s->"get") do={

	:global MtmToolJson1;
	:local cPath "MTM/Tools/Json/Encode.rsc/get";
	:local self ($MtmToolJson1->"encode");
	:if ([:typeof $0] = "array") do={
		:return ([($self->"getFromArray") $0]);
	}
	:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
}
:set ($s->"getFromArray") do={

	#todo: escape special chars: /\"\'\b\f\t\r\n.
	:local cPath "MTM/Tools/Json/Encode.rsc/getFromArray";
	:if ([:typeof $0] != "array") do={
		:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
	}

	:global MtmToolJson1;
	:local self ($MtmToolJson1->"encode");
	
	:local rData "";
	:local isArr 1;
	:local vType "";
	:local count 0;
	
	# determine if the first dimention is an object or an array
	:foreach prop,value in=$0 do={
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
	
	:foreach prop,value in=$0 do={
	
		:if ($count > 0) do={
			:set rData ($rData.",");
		} else={
			:set count 1;
		}
		:if ($isArr = 0) do={
			:set rData ($rData."\"$prop\":");
		}
		:set vType [:typeof $value];
		
		:if ($vType = "str" || $vType = "time" || $vType = "ip") do={
			##https://stackoverflow.com/questions/43969649/null-character-within-json
			##null values are not allowed in json, you can remove with: [($strTool->"replace") $myString ("\00") ""]
			##too resource intensive to run here on big blobs of text
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
			:set rData ($rData.[($self->"getFromArray") $value]);
			:set vType "";
		}
		:if ($vType != "") do={
			:error ($cPath.": Input not handled for datatype: '".$vType."'");
		}
	}
	
	:if ($isArr = 0) do={
		:set rData ($rData."}");
	} else={
		:set rData ($rData."]");
	}
	:return $rData;
	
}

:global MtmToolJson1;
:set ($MtmToolJson1->"encode") $s;