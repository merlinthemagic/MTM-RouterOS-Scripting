:local classId "fact-system-routerboard";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmS;
:if (($MtmS->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getModel") do={
		:return [/system routerboard get model];
	}
	:set ($MtmS->$classId) $s;
}
