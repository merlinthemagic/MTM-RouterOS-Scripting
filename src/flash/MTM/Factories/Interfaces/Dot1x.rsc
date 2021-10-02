:local classId "fact-if-dot1x";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:if (($MtmFacts->"c"->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getServers") do={
		:global MtmFacts;
		:local classId "fact-if-dot1x-servers";
		:if ($MtmFacts->"c"->$classId = nil) do={
			:local path ([($MtmFacts->"getMtmPath")]."Factories/Interfaces/Dot1x/Servers.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmFacts->"c"->$classId);
	}
	:set ($MtmFacts->"c"->$classId) $s;
}
