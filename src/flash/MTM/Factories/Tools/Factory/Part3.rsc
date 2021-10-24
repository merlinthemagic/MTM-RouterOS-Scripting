:set ($s->"getRadius") do={
	:global MtmFacts;
	:local sysId "fact-tool-radius";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Factories/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Factories/Tools/Radius.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Factories/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}
:set ($s->"getFetch") do={
	:global MtmFacts;
	:local sysId "fact-tool-fetch";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Factories/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Factories/Tools/Fetch.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Factories/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}
:set ($s->"getRouting") do={
	:global MtmFacts;
	:local sysId "fact-tool-routing";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Factories/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Factories/Tools/Routing.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Factories/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}