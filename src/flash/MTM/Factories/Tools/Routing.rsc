:local classId "fact-tool-routing";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmT;
:if (($MtmT->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getIPv4") do={
		:global MtmFacts;
		:local classId "tool-routing-ipv4";
		:if ($MtmFacts->"c"->$classId = nil) do={
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Routing/IPv4.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmFacts->"c"->$classId);
	}
	:set ($MtmT->$classId) $s;
}
