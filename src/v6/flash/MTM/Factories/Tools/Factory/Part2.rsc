:set ($s->"getTime") do={
	:global MtmFacts;
	:local sysId "fact-tool-time";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Factories/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Factories/Tools/Time.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Factories/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}
:set ($s->"getInterfaces") do={
	:global MtmFacts;
	:local sysId "fact-tool-ifs";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Factories/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Factories/Tools/Interfaces.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Factories/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}
:set ($s->"getParsing") do={
	:global MtmFacts;
	:local sysId "fact-tool-parsing";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Factories/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Factories/Tools/Parsing/Part1.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Factories/Tools/Parsing/Part2.rsc");
		:set ($paths->3) ([($MtmFacts->"getMtmPath")]."Factories/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}
:set ($s->"getHashing") do={
	:global MtmFacts;
	:local sysId "fact-tool-hashing";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Factories/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Factories/Tools/Hashing.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Factories/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}
:set ($s->"getGuids") do={
	:global MtmFacts;
	:local sysId "fact-tool-guids";
	:local objFact [($MtmFacts->"getObjects")];
	:local sObj [($objFact->"getStore") $sysId];
	:if ($sObj->"obj"->($sObj->"hash") = nil) do={
		:local paths [:toarray ""];
		:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Factories/Base.rsc");
		:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Factories/Tools/Guids.rsc");
		:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Factories/Zstance.rsc");
		:return [($objFact->"getInstance") ($sObj->"obj") ($sObj->"name") $paths $sysId ($sObj->"hash")];
	}
	:return ($sObj->"obj"->($sObj->"hash"));
}