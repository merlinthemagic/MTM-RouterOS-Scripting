:set ($s->"getMD5") do={
	:global MtmSM0;
	:local classId "tool-hash-md5";
	:if ($MtmSM0->$classId = nil) do={
		:global MtmFacts;
		:local path ([($MtmFacts->"getMtmPath")]."Tools/Hashing/MD5/Full.rsc");
		[($MtmFacts->"importFile") $path];
	}
	:return ($MtmSM0->$classId);
}