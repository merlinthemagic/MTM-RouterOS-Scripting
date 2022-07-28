:local cPath "MTM/Facts/Tools/Hashing.rsc";
:local s [:toarray ""];

:set ($s->"getV4") do={

	:global MtmToolGuid1;
	:if ([:typeof ($MtmToolGuid1->"v4")] = "nothing") do={
		:global MtmFacts;
		:local mVal "";
		:set mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Tools/Guids/V4.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmToolGuid1->"v4");
}

:global MtmToolGuid1;
:set MtmToolGuid1 [:toarray ""];

:global MtmTools;
:set ($MtmTools->"guids") $s;