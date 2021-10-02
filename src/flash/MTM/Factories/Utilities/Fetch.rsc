:local classId "fact-utility-fetch";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmU;
:if (($MtmU->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getUpload") do={
		:global MtmU;
		:local classId "utility-fetch-upload";
		:if ($MtmU->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Utilities/Fetch/Upload.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmU->$classId);
	}
	:set ($MtmU->$classId) $s;
}
