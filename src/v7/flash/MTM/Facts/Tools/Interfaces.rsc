:local cPath "MTM/Facts/Tools/Interfaces.rsc";
:local s [:toarray ""];

:set ($s->"getWlans") do={

	:global MtmToolIfs1;
	:if ([:typeof ($MtmToolIfs1->"wlans")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Tools/Interfaces/Wlans.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmToolIfs1->"wlans");
}

:global MtmToolIfs1;
:set MtmToolIfs1 [:toarray ""];

:global MtmTools;
:set ($MtmTools->"ifs") $s;