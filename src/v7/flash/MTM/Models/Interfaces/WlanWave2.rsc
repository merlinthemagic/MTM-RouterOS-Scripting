:local cPath "MTM/Models/Interfaces/Wlan.rsc";
:global MtmId;
:local s [:toarray ""];
:local mVal "";

:set mVal ":return \"wlan\";";
:set ($s->"getType") [:parse $mVal];

:set mVal ":if ([/interface/wifiwave2/get $MtmId disabled] = false) do={ :return true; } else={ :return false; }";
:set ($s->"getEnabled") [:parse $mVal];

:set mVal ":if ([:typeof \$0] != \"bool\") do={ :error ($cPath\": Input must be bool\"); }; :local mVal \"\"; :if (\$0 = true) do={ :set mVal \"no\"; } else={ :set mVal \"yes\"; }; :set mVal [/interface/wifiwave2/set $MtmId disabled=\$mVal]; :return true;";
:set ($s->"setEnabled") [:parse $mVal];

:set mVal ":return [/interface/wifiwave2/get $MtmId name];";
:set ($s->"getName") [:parse $mVal];

:set mVal ":return [/interface/wifiwave2/get $MtmId mac-address];";
:set ($s->"getMacAddress") [:parse $mVal];

:set mVal ":return [:tonum [/interface/wifiwave2/get $MtmId antenna-gain]];";
:set ($s->"getAntennaGain") [:parse $mVal];

:set mVal ":local c [:len [/interface/wifiwave2/registration-table/find where interface=([/interface/wifiwave2/get $MtmId name])]]; :if ([/interface/wifiwave2/get $MtmId interface-type] !=\"virtual\")  do={ :local c2 0; :foreach id in=[/interface/wifiwave2/find where master-interface=([/interface/wifiwave2/get $MtmId name])] do={ :set c2 [:len [/interface/wifiwave2/registration-table/find where interface=([/interface/wifiwave2/get \$id name])]]; :set c (\$c + \$c2); }}; :return \$c;";
:set ($s->"getClientCount") [:parse $mVal];

:set mVal ":global MtmFacts; :local tObj [(\$MtmFacts->\"get\") \"getTools()->getInterfaces()->getWlans()\"]; :return ([(\$tObj->\"getScan\") ([/interface/wifiwave2/get $MtmId name])]);";
:set ($s->"getScan") [:parse $mVal];

:set mVal ":return ([/interface/wifiwave2/monitor $MtmId once as-value]->\"status\")";
:set ($s->"getStatus") [:parse $mVal];

:set mVal ":return ([/interface/wifiwave2/monitor $MtmId once as-value]->\"overall-tx-ccq\")";
:set ($s->"getTxCcq") [:parse $mVal];

:global MtmIds1;
:set ($MtmIds1->([:tostr ("wlan".$MtmId)])) $s;