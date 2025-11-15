:local cPath "MTM/Facts/Models/Radius.rsc";
:local s [:toarray ""];

:set ($s->"getClients") do={

	:global MtmModelRad1;
	:if ([:typeof ($MtmModelRad1->"clients")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Facts/Models/Radius/Clients.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmModelRad1->"clients");
}

:global MtmModelRad1;
:set MtmModelRad1 [:toarray ""];

:global MtmModels;
:set ($MtmModels->"radius") $s;