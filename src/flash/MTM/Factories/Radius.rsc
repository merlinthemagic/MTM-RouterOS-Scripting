:local classId "fact-radius";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:if (($MtmFacts->"c"->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getClients") do={
		:global MtmFacts;
		:local classId "fact-radius-clients";
		:if ($MtmFacts->"c"->$classId = nil) do={
			:local path ([($MtmFacts->"getMtmPath")]."Factories/Radius/Clients.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmFacts->"c"->$classId);
	}
	:set ($MtmFacts->"c"->$classId) $s;
}
