:local cPath "MTM/Models/Radius/Client.rsc";
:global MtmId;
:local s [:toarray ""];
:local mVal "";

:set mVal ":return \"radius-client\";";
:set ($s->"getType") [:parse $mVal];

:set mVal ":return [/radius/get $MtmId src-address];";
:set ($s->"getSrcAddress") [:parse $mVal];

:set mVal ":return [/radius/get $MtmId accounting-backup];";
:set ($s->"getAccountingBackup") [:parse $mVal];

:set mVal ":return [/radius/get $MtmId address];";
:set ($s->"getAddress") [:parse $mVal];

:set mVal ":return [/radius/get $MtmId called-id];";
:set ($s->"getCalledId") [:parse $mVal];

:set mVal ":return [/radius/get $MtmId comment];";
:set ($s->"getComment") [:parse $mVal];

:set mVal ":return [/radius/get $MtmId accounting-port];";
:set ($s->"getAccountingPort") [:parse $mVal];

:set mVal ":return [/radius/get $MtmId disabled];";
:set ($s->"getDisabled") [:parse $mVal];

:set mVal ":return [/radius/get $MtmId protocol];";
:set ($s->"getProtocol") [:parse $mVal];

:set mVal ":return [/radius/get $MtmId secret];";
:set ($s->"getSecret") [:parse $mVal];

:set mVal ":return [/radius/get $MtmId domain];";
:set ($s->"getDomain") [:parse $mVal];

:set mVal ":return [/radius/get $MtmId realm];";
:set ($s->"getRealm") [:parse $mVal];

:set mVal ":return [/radius/get $MtmId service];";
:set ($s->"getServices") [:parse $mVal];

:set mVal ":return [/radius/get $MtmId timeout];";
:set ($s->"getTimeout") [:parse $mVal];

:set mVal ":return ([/radius/monitor $MtmId once as-value]->\"accepts\");";
:set ($s->"getAcceptCount") [:parse $mVal];

:set mVal ":return ([/radius/monitor $MtmId once as-value]->\"bad-replies\");";
:set ($s->"getBadReplyCount") [:parse $mVal];

:set mVal ":global MtmFacts; :local tObj [(\$MtmFacts->\"get\") \"getTools()->getTime()->getRos()\"]; :return ([(\$tObj->\"getMiliFromFormat\") [:tostr ([/radius/monitor $MtmId once as-value]->\"last-request-rtt\")] \"h:i:s.u\"]);";
:set ($s->"getLastRtt") [:parse $mVal];

:set mVal ":return ([/radius/monitor $MtmId once as-value]->\"pending\");";
:set ($s->"getPendingCount") [:parse $mVal];

:set mVal ":return ([/radius/monitor $MtmId once as-value]->\"rejects\");";
:set ($s->"getRejectedCount") [:parse $mVal];

:set mVal ":return ([/radius/monitor $MtmId once as-value]->\"requests\");";
:set ($s->"getRequestCount") [:parse $mVal];

:set mVal ":return ([/radius/monitor $MtmId once as-value]->\"resends\");";
:set ($s->"getResendCount") [:parse $mVal];

:set mVal ":return ([/radius/monitor $MtmId once as-value]->\"timeouts\");";
:set ($s->"getTimeoutCount") [:parse $mVal];

:global MtmIds2;
:set ($MtmIds2->([:tostr ("radc".$MtmId)])) $s;