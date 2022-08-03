:local cPath "MTM/Facts/Models.rsc";
:local s [:toarray ""];

:set ($s->"getInterfaces") do={
	:global MtmModels;
	:if ([:typeof ($MtmModels->"ifs")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Facts/Models/Interfaces.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmModels->"ifs");
}

:global MtmModels;
:set MtmModels [:toarray ""];

:global MtmFaObjs;
:set ($MtmFaObjs->"models") $s;