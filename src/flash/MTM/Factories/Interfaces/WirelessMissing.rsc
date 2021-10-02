##invoke if wireless package is not installed
##methods must mirror Wireless returns

:local classId "fact-if-wireless";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:if (($MtmFacts->"c"->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getById") do={
		:global MtmFacts;
		:return [($MtmFacts->"getNull")];
	}
	:set ($s->"getAll") do={
		:return [:toarray ""];
	}
	:set ($s->"getAllHardware") do={
		:return [:toarray ""];
	}
	:set ($s->"getByName") do={
		:global MtmFacts;
		:return [($MtmFacts->"getNull")];
	}
	:set ($MtmFacts->"c"->$classId) $s;
}
