:local cPath "MTM/Facts/Models/Interfaces/Wlans.rsc";
:local s [:toarray ""];

:set ($s->"getAll") do={

	:global MtmFacts;
	:local self [($MtmFacts->"get") "getModels()->getInterfaces()->getWlans()"];
	:local c 0;
	:local rObjs [:toarray ""];
	:foreach id in=[/interface/wireless/find] do={
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
	:foreach id in=[/interface/wireless/find where interface-type!="virtual"] do={
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
	:foreach id in=[/interface/wireless/find where interface-type="virtual"] do={
		:set ($rObjs->$c) [($self->"getById") $id];
		:set c ($c + 1);
	}
	:return $rObjs;
}
:set ($s->"getById") do={

	:local cPath "MTM/Facts/Interfaces/Wlans.rsc/getById";
	:if ([:typeof $0] != "id") do={
		:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
	}
	:global MtmIds1;
	:if ([:typeof ($MtmIds1->$0)] = "nothing") do={
		:global MtmFacts;
		:local mVal [/interface/wireless/get $0 interface-type];
		:if ($mVal = "virtual") do={
			:set mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Models/Interfaces/VirtualWlan.rsc");
		} else={
			:set mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Models/Interfaces/Wlan.rsc");
		}
		:local key [($MtmFacts->"lock") "MtmId" 5 7];
		:global MtmId;
		:set MtmId [:tostr $0];
		:set mVal [($MtmFacts->"importFile") $mVal];
		:set key [($MtmFacts->"unlock") "MtmId" $key];
	}
	:return ($MtmIds1->$0);
}

:global MtmModelIfWlans1;
:set MtmModelIfWlans1 [:toarray ""];

:global MtmModelIfs1;
:set ($MtmModelIfs1->"wlans") $s;