:local classId "fact-system-identity";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmS;
:if (($MtmS->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getName") do={
		:return [/system identity get name];
	}
	:set ($MtmS->$classId) $s;
}
