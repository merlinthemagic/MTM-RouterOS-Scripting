:local cPath "MTM/Facts/Models/Interfaces.rsc";
:local s [:toarray ""];

:set ($s->"getWlans") do={

	:global MtmModelIfs1;
	:if ([:typeof ($MtmModelIfs1->"wlans")] = "nothing") do={
		:global MtmFacts;
		:local mVal "";
		:if ([:len [/system/package/find where name~"wifi-qcom" && disabled=no]] > 0 || [:len [/system/package/find where name~"wifiwave2" && disabled=no]] > 0) do= {
			:set mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Facts/Models/Interfaces/WlansWave2.rsc");
		} else={
			:if ([:len [/system/package/find where name~"wireless" && disabled=no]] > 0) do= {
				:set mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Facts/Models/Interfaces/Wlans.rsc");
			} else={
				:set mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Facts/Models/Interfaces/NoWlans.rsc");
			}
		}
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmModelIfs1->"wlans");
}

:global MtmModelIfs1;
:set MtmModelIfs1 [:toarray ""];

:global MtmModels;
:set ($MtmModels->"ifs") $s;