:local classId "fact-tool-fetch";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmTF;
:if (($MtmTF->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getUpload") do={
		:global MtmTF;
		:local classId "tool-fetch-upload";
		:if ($MtmTF->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Fetch/Upload.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmTF->$classId);
	}
	:set ($s->"getDownload") do={
		:global MtmTF;
		:local classId "tool-fetch-download";
		:if ($MtmTF->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Fetch/Download.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmTF->$classId);
	}
	:set ($MtmTF->$classId) $s;
}
