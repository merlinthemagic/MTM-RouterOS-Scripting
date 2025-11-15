:local cPath "MTM/Facts/Models/Interfaces/WlansWave2.rsc";
:local s [:toarray ""];

:set ($s->"getAll") do={

	:global MtmFacts;
	:local self [($MtmFacts->"get") "getModels()->getInterfaces()->getWlans()"];
	:local c 0;
	:local rObjs [:toarray ""];
	:foreach id in=[/interface/wifiwave2/find] do={
		:set ($rObjs->$c) [($self->"getById") $id];
		:set c ($c + 1);
	}
	:return $rObjs;
}
:set ($s->"getAllHardware") do={

	:global MtmFacts;
	:local self [($MtmFacts->"get") "getModels()->getInterfaces()->getWlans()"];
	:local c 0;
	:local rObjs [:toarray ""];
	:foreach id in=[/interface/wifiwave2/find where master-interface=[:nothing]] do={
		:set ($rObjs->$c) [($self->"getById") $id];
		:set c ($c + 1);
	}
	:return $rObjs;
}
:set ($s->"getAllVirtual") do={

	:global MtmFacts;
	:local self [($MtmFacts->"get") "getModels()->getInterfaces()->getWlans()"];
	:local c 0;
	:local rObjs [:toarray ""];
	:foreach id in=[/interface/wifiwave2/find where master-interface!=[:nothing]] do={
		:set ($rObjs->$c) [($self->"getById") $id];
		:set c ($c + 1);
	}
	:return $rObjs;
}
:set ($s->"getById") do={

	:local cPath "MTM/Facts/Interfaces/WlansWave2.rsc/getById";
	:if ([:typeof $0] != "id") do={
		:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
	}
	:global MtmIds1;
	:local sysId [:tostr ("wlan".$0)];
	:if ([:typeof ($MtmIds1->$sysId)] = "nothing") do={
		:global MtmFacts;
		:local mVal [/interface/wifiwave2/get $0 master-interface];
		:if ([:typeof $mVal] = "str") do={
			:set mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Models/Interfaces/VirtualWlan.rsc");
		} else={
			:set mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Models/Interfaces/WlanWave2.rsc");
		}
		:local key [($MtmFacts->"lock") "MtmId" 5 7];
		:global MtmId;
		:set MtmId $0;
		:set mVal [($MtmFacts->"importFile") $mVal];
		:set key [($MtmFacts->"unlock") "MtmId" $key];
	}
	:return ($MtmIds1->$sysId);
}

:global MtmModelIfs1;
:set ($MtmModelIfs1->"wlans") $s;