:local classId "fact-if-list-members";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:if (($MtmFacts->"c"->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"a") [:toarray ""];
	
	:set ($s->"getById") do={
	
		:global MtmFacts;
		:local method "Facts->Interfaces->ListMembers->getById";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Id is mandatory"];
		}
		:global MtmO;
		:local classId ("model-if-list-member-".$0);
		:if ($MtmO->$classId = nil) do={
			
			:local paths [:toarray ""];
			:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Models/Base.rsc");
			:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Models/Interfaces/ListMember/Base.rsc");
			:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Models/Zstance.rsc");

			:local objTool [($MtmFacts->"execute") nsStr="getTools()->getObjects()"];
			:return [($objTool->"getInstanceV3") $paths $classId $0 $MtmO "MtmO"];
		}
		:return ($MtmO->$classId);
	}
	:set ($MtmFacts->"c"->$classId) $s;
}
