:set ($s->"getV4") do={
	:global MtmFacts;
	:local sysId "tool-guid-v4";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Tools/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Tools/Guids/V4/Part1.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Tools/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}