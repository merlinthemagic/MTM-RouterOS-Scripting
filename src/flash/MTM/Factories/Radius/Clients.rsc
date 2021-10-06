:local classId "fact-radius-clients";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:if (($MtmFacts->"c"->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getById") do={
	
		:global MtmFacts;
		:local method "Facts->Radius->Clients->getById";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Id is mandatory"];
		}
		:global MtmO;
		:local classId ("mtm-radius-client-".$0);
		:if ($MtmO->$classId = nil) do={
			
			:local paths [:toarray ""];
			:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Models/Base.rsc");
			:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Models/Radius/Client/Base.rsc");
			:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Models/Radius/Client/Attrs.rsc");
			:set ($paths->3) ([($MtmFacts->"getMtmPath")]."Models/Zstance.rsc");

			:local objTool [($MtmFacts->"execute") nsStr="getTools()->getObjects()"];
			:return [($objTool->"getInstanceV3") $paths $classId $0 $MtmO "MtmO"];
		}
		:return ($MtmO->$classId);
	}
	:set ($s->"getAll") do={
		:global MtmFacts;
		:local c 0;
		:local rObjs [:toarray ""];
		:local factObj [($MtmFacts->"execute") nsStr="getRadius()->getClients()"];
		:foreach id in=[/radius find] do={
			:set ($rObjs->"$c") [($factObj->"getById") $id];
			:set c ($c + 1);
		}
		:return $rObjs;
	}
	:set ($MtmFacts->"c"->$classId) $s;
}
