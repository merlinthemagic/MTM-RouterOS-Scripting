:set ($s->"getLastLinkUpTime") do={
	:global MtmFacts;
	:local method "Tools->Interfaces->Common->getLastLinkUpTime";
	:if ($0 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Interface name is mandatory"];
	}
	:local val0 [/interface get [find name=$0] last-link-up-time];
	:if ([:typeof $val0] != "nil") do={
		:local toolObj [($MtmFacts->"execute") nsStr="getTools()->getTime()->getEpoch()"];
		:return [($toolObj->"getFromFormat") "m/d/Y h:i:s" $val0];
	} else={
		:return 0;
	}
}
:set ($s->"getLastLinkDownTime") do={
	:global MtmFacts;
	:local method "Tools->Interfaces->Common->getLastLinkDownTime";
	:if ($0 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Interface name is mandatory"];
	}
	:local val0 [/interface get [find name=$0] last-link-down-time];
	:if ([:typeof $val0] != "nil") do={
		:local toolObj [($MtmFacts->"execute") nsStr="getTools()->getTime()->getEpoch()"];
		:return [($toolObj->"getFromFormat") "m/d/Y h:i:s" $val0];
	} else={
		:return 0;
	}
}