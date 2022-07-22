:set ($s->"getLastByScriptName") do={
	## get the newest job with a specific script name 
	:global MtmFacts;
	:local method "Tools->Scripts->Jobs->getLastByScriptName";
	:if ($0 = false) do={
		[($MtmFacts->"throwException") method=$method msg="Script name is mandatory"];
	}
	
	:local scriptName $0;
	:local sIds [/system script job find script=$scriptName];
	:if ([:len $sIds] > 0) do={
	
		:local timeTool [($MtmFacts->"execute") nsStr="getTools()->getTime()->getEpoch()"];
		:local ljObj [:toarray ""];
		:set ($ljObj->"started") 0;
		:set ($ljObj->"jobId");
		:set ($ljObj->"scriptName") $scriptName;
		:local val;
		:foreach id in=[/system script job find script=$scriptName] do={
			:set val ([($timeTool->"getFromFormat") "m/d/Y h:i:s" ([/system script job get $id started])]);
			:if (($ljObj->"started") < $val) do={
				:set ($ljObj->"started") $val;
				:set ($ljObj->"jobId") $id;
			}
		}
		:return $ljObj;
	} else {
		:return [:nothing];
	}
}
