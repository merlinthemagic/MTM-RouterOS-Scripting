:set ($s->"getInterfaceUp") do={
	:global MtmFacts;
	:local sysId "util-events-ifup";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Utilities/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Utilities/Events/InterfaceUp/Part1.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Utilities/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}