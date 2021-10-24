:set ($s->"getById") do={
	:global MtmFacts;
	:local method "Facts->Interfaces->ListMembers->getById";
	:if ($0 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Id is mandatory"];
	}
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") ("mtm-if-list-member-".$0)];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Models/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Models/Interfaces/ListMember/Base.rsc");
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
	:foreach id in=[/interface list member find ] do={
		:set ($rObjs->"$c") [($self->"getById") $id];
		:set c ($c + 1);
	}
	:return $rObjs;
}