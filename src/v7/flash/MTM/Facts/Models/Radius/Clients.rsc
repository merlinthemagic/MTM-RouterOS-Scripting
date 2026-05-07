:local cPath "MTM/Facts/Models/Radius/Clients.rsc";
:local s [:toarray ""];

:set ($s->"getAll") do={

	:global MtmFacts;
	:local self [($MtmFacts->"get") "getModels()->getRadius()->getClients()"];
	:local c 0;
	:local rObjs [:toarray ""];
	:foreach id in=[/radius/find] do={
		:set ($rObjs->$c) [($self->"getById") $id];
		:set c ($c + 1);
	}
	:return $rObjs;
}
:set ($s->"getById") do={

	:local cPath "MTM/Facts/Models/Radius/Clients.rsc/getById";
	:if ([:typeof $0] != "id") do={
		:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
	}
	:global MtmIds2;
	:local sysId [:tostr ("radc".$0)];
	:if ([:typeof ($MtmIds2->$sysId)] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Models/Radius/Client.rsc");
		:local key [($MtmFacts->"lock") "MtmId" 5 7];
		:global MtmId;
		:set MtmId $0;
		:set mVal [($MtmFacts->"importFile") $mVal];
		:set key [($MtmFacts->"unlock") "MtmId" $key];
	}
	:return ($MtmIds2->$sysId);
}

:global MtmModelRad1;
:set ($MtmModelRad1->"clients") $s;