:local cPath "MTM/Models/Interfaces/VirtualWlan.rsc";
:global MtmId;
:local s [:toarray ""];
:local mVal "";

:set mVal ":return \"vwlan\";";
:set ($s->"getType") [:parse $mVal];


:global MtmIds1;
:set ($MtmIds1->$MtmId) $s;