:set ($s->"getById") do={
	:global MtmFacts;
	:local method "Facts->Interfaces->Ethernet->getById";
	:if ($0 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Id is mandatory"];
	}
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") ("mtm-if-eth-".$0)];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Models/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Models/Interfaces/Base.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Models/Interfaces/Ethernet/Base.rsc");
		:set ($paths->3) ([($MtmFacts->"getMtmPath")]."Models/Interfaces/Ethernet/Attrs.rsc");
		:set ($paths->4) ([($MtmFacts->"getMtmPath")]."Models/Interfaces/Ethernet/PoE.rsc");
		:set ($paths->5) ([($MtmFacts->"getMtmPath")]."Models/Interfaces/Ethernet/Traffic.rsc");
		:set ($paths->6) ([($MtmFacts->"getMtmPath")]."Models/Zstance.rsc");
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
	:foreach id in=[/interface ethernet find ] do={
		:set ($rObjs->"$c") [($self->"getById") $id];
		:set c ($c + 1);
	}
	:return $rObjs;
}
:set ($s->"getByName") do={
	:global MtmFacts;
	
	:local method "Facts->Interfaces->Ethernet->getByName";
	:if ($0 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Name is mandatory"];
	}
	:local id [/interface ethernet find where name=$0];
	:if ([:len $id] > 0) do={
		:global |MTMS|;
		:local self ($|MTMS|->"|MTMC|");
		:return [($self->"getById") ($id->0)];
	}
	:return [($MtmFacts->"getNull")];
}