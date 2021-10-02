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
			:local path "Models/Interfaces/ListMember";
			:local paths [:toarray "$path/Part1.rsc,$path/Part2.rsc"];
			:local objTool [($MtmFacts->"execute") nsStr="getTools()->getObjects()" ];
			[($objTool->"getInstanceV1") paths=$paths id=$0 classId=$classId];
		}
		:return ($MtmO->$classId);
	}
	:set ($MtmFacts->"c"->$classId) $s;
}
