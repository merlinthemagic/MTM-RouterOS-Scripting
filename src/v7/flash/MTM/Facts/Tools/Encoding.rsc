:local cPath "MTM/Facts/Tools/Encoding.rsc";
:local s [:toarray ""];

:set ($s->"getBase16") do={

	:global MtmToolEncode1;
	:if ([:typeof ($MtmToolEncode1->"base16")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Tools/Encoding/Base16.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmToolEncode1->"base16");
}
:set ($s->"getBase64") do={

	:global MtmToolEncode1;
	:if ([:typeof ($MtmToolEncode1->"base64")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Tools/Encoding/Base64.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmToolEncode1->"base64");
}

:global MtmToolEncode1;
:set MtmToolEncode1 [:toarray ""];

:global MtmTools;
:set ($MtmTools->"encoding") $s;