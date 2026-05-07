:local cPath "MTM/Facts/Models/Interfaces/NoWlans.rsc";
:local s [:toarray ""];

:set ($s->"getAll") do={

	:local rObjs [:toarray ""];
	:return $rObjs;
}
:set ($s->"getAllHardware") do={

	:local rObjs [:toarray ""];
	:return $rObjs;
}
:set ($s->"getAllVirtual") do={

	:local rObjs [:toarray ""];
	:return $rObjs;
}
:set ($s->"getById") do={

	:return [:nothing];
}

:global MtmModelIfs1;
:set ($MtmModelIfs1->"wlans") $s;