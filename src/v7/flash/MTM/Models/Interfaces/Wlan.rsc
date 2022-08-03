:local cPath "MTM/Models/Interfaces/Wlan.rsc";
:global MtmId;
:local s [:toarray ""];
:local mVal "";

:set mVal ":return \"wlan\";";
:set ($s->"getType") [:parse $mVal];

:set mVal ":return [:tonum [/interface/wireless/get $MtmId antenna-gain]];";
:set ($s->"getAntennaGain") [:parse $mVal];

:global MtmIds1;
:set ($MtmIds1->$MtmId) $s;