:set ($s->"getById") do={
	
	:global MtmFacts;
	:local method "Facts->Radius->Clients->getById";
	:if ($0 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Id is mandatory"];
	}
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") ("mtm-radius-client-".$0)];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Models/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Models/Radius/Client/Base.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Models/Radius/Client/Attrs.rsc");
		:set ($paths->3) ([($MtmFacts->"getMtmPath")]."Models/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $0 ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}
:set ($s->"getAll") do={
	:global MtmFacts;
	:local c 0;
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local rObjs [:toarray ""];
	:foreach id in=[/radius find] do={
		:set ($rObjs->"$c") [($self->"getById") $id];
		:set c ($c + 1);
	}
	:return $rObjs;
}