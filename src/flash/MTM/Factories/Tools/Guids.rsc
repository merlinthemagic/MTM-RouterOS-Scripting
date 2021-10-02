:local classId "fact-tool-guids";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmT2;
:if (($MtmT2->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getV4") do={
		:global MtmT3;
		:local classId "tool-guids-v4";
		:if ($MtmT3->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Guids/V4.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT3->$classId);
	}
	:set ($MtmT2->$classId) $s;
}
