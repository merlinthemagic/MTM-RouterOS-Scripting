:local classId "fact-tool-hash";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmT2;
:if (($MtmT2->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getMD5") do={
		:global MtmT3;
		:local classId "tool-hash-md5";
		:if ($MtmT3->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Hashing/MD5.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT3->$classId);
	}
	:set ($MtmT2->$classId) $s;
}
