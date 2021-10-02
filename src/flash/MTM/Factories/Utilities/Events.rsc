:local classId "fact-utility-event";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmU;
:if (($MtmU->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getInterfaceUp") do={
		:global MtmU;
		:local classId "utility-events-ifup";
		:if ($MtmU->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Utilities/Events/InterfaceUp.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmU->$classId);
	}
	:set ($MtmU->$classId) $s;
}
