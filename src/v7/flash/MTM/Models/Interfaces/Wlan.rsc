:local cPath "MTM/Models/Interfaces/Wlan.rsc";
:global MtmId;
:local s [:toarray ""];
:local mVal "";

:set mVal ":return \"wlan\";";
:set ($s->"getType") [:parse $mVal];

:set mVal ":return [/interface/wireless/get $MtmId name];";
:set ($s->"getName") [:parse $mVal];

:set mVal ":return [/interface/wireless/get $MtmId mac-address];";
:set ($s->"getMacAddress") [:parse $mVal];

:set mVal ":return [:tonum [/interface/wireless/get $MtmId antenna-gain]];";
:set ($s->"getAntennaGain") [:parse $mVal];

:set mVal ":local c [:len [/interface/wireless/registration-table/find where interface=([/interface/wireless/get $MtmId name])]]; :if ([/interface/wireless/get $MtmId interface-type] !=\"virtual\")  do={ :local c2 0; :foreach id in=[/interface/wireless/find where master-interface=([/interface/wireless/get $MtmId name])] do={ :set c2 [:len [/interface/wireless/registration-table/find where interface=([/interface/wireless/get \$id name])]]; :set c (\$c + \$c2); }}; :return \$c;";
:set ($s->"getClientCount") [:parse $mVal];

:set mVal ":global MtmFacts; :local tObj [(\$MtmFacts->\"get\") \"getTools()->getInterfaces()->getWlans()\"]; :return ([(\$tObj->\"getScan\") ([/interface/wireless/get $MtmId name])]);";
:set ($s->"getScan") [:parse $mVal];

:global MtmIds1;
:set ($MtmIds1->([:tostr ("wlan".$MtmId)])) $s;