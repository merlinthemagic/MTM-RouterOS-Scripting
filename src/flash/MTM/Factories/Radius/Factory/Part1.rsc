:set ($s->"getClients") do={
	:global MtmFacts;
	:local sysId "fact-radius-clients";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Factories/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Factories/Radius/Clients.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Factories/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}