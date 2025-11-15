:local cPath "MTM/Facts/Tools/Parse.rsc";
:local s [:toarray ""];

:set ($s->"getLogs") do={

	:global MtmToolParse1;
	:if ([:typeof ($MtmToolParse1->"logs")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Tools/Parse/Logs.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmToolParse1->"logs");
}

:global MtmToolParse1;
:set MtmToolParse1 [:toarray ""];

:global MtmTools;
:set ($MtmTools->"parse") $s;