:local cPath "MTM/Facts/Models/Interfaces.rsc";
:local s [:toarray ""];

:set ($s->"getWlans") do={

	:global MtmModelIfs1;
	:if ([:typeof ($MtmModelIfs1->"wlans")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Facts/Models/Interfaces/Wlans.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmModelIfs1->"wlans");
}

:global MtmModelIfs1;
:set MtmModelIfs1 [:toarray ""];

:global MtmModels;
:set ($MtmModels->"ifs") $s;