:set ($s->"getLastByScriptName") do={
	## get the newest job with a specific script name 
	:global MtmFacts;
	:local method "Tools->Scripts->Jobs->getLastByScriptName";
	:if ($0 = false) do={
		[($MtmFacts->"throwException") method=$method msg="Script name is mandatory"];
	}
	
	
	:return $rData;
}
