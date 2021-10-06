:local classId "fact-ip-addrs";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmI;
:if (($MtmI->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"a") [:toarray ""];
	
	:set ($s->"getV4ById") do={
	
		:global MtmFacts;
		:local method "Facts->IP->Addresses->getV4ById";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Id is mandatory"];
		}
		:global MtmO;
		:local classId ("mtm-ip-v4-".$0);
		:if ($MtmO->$classId = nil) do={
		
			:local paths [:toarray ""];
			:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Models/Base.rsc");
			:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Models/IP/Address/V4/Base.rsc");
			:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Models/Zstance.rsc");

			:local objTool [($MtmFacts->"execute") nsStr="getTools()->getObjects()"];
			:return [($objTool->"getInstanceV3") $paths $classId $0 $MtmO "MtmO"];
		}
		:return ($MtmO->$classId);
	}
	:set ($s->"getV6ById") do={
	
		:global MtmFacts;
		:local method "Facts->IP->Addresses->getV6ById";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Id is mandatory"];
		}
		:global MtmO;
		:local classId ("mtm-ip-v6-".$0);
		:if ($MtmFacts->"c"->$classId = nil) do={
			:local paths [:toarray ""];
			:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Models/Base.rsc");
			:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Models/IP/Address/V6/Base.rsc");
			:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Models/Zstance.rsc");

			:local objTool [($MtmFacts->"execute") nsStr="getTools()->getObjects()"];
			:return [($objTool->"getInstanceV3") $paths $classId $0 $MtmO "MtmO"];
		}
		:return ($MtmO->$classId);
	}
	:set ($MtmI->$classId) $s;
}
