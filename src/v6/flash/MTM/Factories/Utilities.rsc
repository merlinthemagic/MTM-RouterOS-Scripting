:local classId "fact-utilities";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmU;
:if (($MtmU->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getEvents") do={
		:global MtmU;
		:local classId "fact-utility-event";
		:if ($MtmU->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Factories/Utilities/Events.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmU->$classId);
	}
	:set ($s->"getFetch") do={
		:global MtmU;
		:local classId "fact-utility-fetch";
		:if ($MtmU->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Factories/Utilities/Fetch.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmU->$classId);
	}
	:set ($MtmU->$classId) $s;
}
