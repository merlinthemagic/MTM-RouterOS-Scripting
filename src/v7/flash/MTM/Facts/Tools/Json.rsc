:local cPath "MTM/Facts/Tools/Json.rsc";
:local s [:toarray ""];

:set ($s->"getEncode") do={

	:global MtmToolJson1;
	:if ([:typeof ($MtmToolJson1->"encode")] = "nothing") do={
		:global MtmFacts;
		:local mVal "";
		:set mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Tools/Json/Encode.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmToolJson1->"encode");
}
:set ($s->"getDecode") do={

	:global MtmToolJson1;
	:if ([:typeof ($MtmToolJson1->"decode")] = "nothing") do={
		:global MtmFacts;
		:local mVal "";
		:set mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Tools/Json/Decode.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmToolJson1->"decode");
}
:global MtmToolJson1;
:set MtmToolJson1 [:toarray ""];

:global MtmTools;
:set ($MtmTools->"json") $s;