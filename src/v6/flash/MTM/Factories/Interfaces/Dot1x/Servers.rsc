:set ($s->"getById") do={
	:global MtmFacts;
	:local method "Facts->Interfaces->Dot1x->Servers->getById";
	:if ($0 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Id is mandatory"];
	}
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") ("mtm-if-dot1x-server-".$0)];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Models/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Models/Interfaces/Dot1x/Server/Base.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Models/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $0 ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}
:set ($s->"getAll") do={
	:global MtmFacts;
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local c 0;
	:local rObjs [:toarray ""];
	:foreach id in=[/interface dot1x server find ] do={
		:set ($rObjs->"$c") [($self->"getById") $id];
		:set c ($c + 1);
	}
	:return $rObjs;
}
:set ($s->"getByInterface") do={

	:global MtmFacts;
	:local method "Facts->Interfaces->Dot1x->Servers->getByInterface";
	:if ($0 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Interface name is mandatory"];
	}
	:local id [/interface dot1x server find where interface=$0];
	:if ([:typeof $id] != "nil") do={
		:global |MTMS|;
		:local self ($|MTMS|->"|MTMC|");
		:return [($self->"getById") $id];
	}
	:return [($MtmFacts->"getNull")];
}