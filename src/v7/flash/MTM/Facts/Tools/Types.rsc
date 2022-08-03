:local cPath "MTM/Facts/Tools/Types.rsc";
:local s [:toarray ""];

:set ($s->"getStrings") do={

	:global MtmToolTypes1;
	:if ([:typeof ($MtmToolTypes1->"strs")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Tools/Types/Strings.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmToolTypes1->"strs");
}

:global MtmToolTypes1;
:set MtmToolTypes1 [:toarray ""];

:global MtmTools;
:set ($MtmTools->"types") $s;