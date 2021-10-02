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
		:local classId ("model-ip-addr-v4-".$0);
		:if ($MtmO->$classId = nil) do={
			:local path "Models/IP/Address/V4";
			:local paths [:toarray "$path/Base.rsc,$path/Zstance.rsc"];
			:local objTool [($MtmFacts->"execute") nsStr="getTools()->getObjects()"];
			[($objTool->"getInstanceV1") paths=$paths id=$0 classId=$classId];
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
		:local classId ("model-ip-addr-v6-".$0);
		:if ($MtmFacts->"c"->$classId = nil) do={
			:local path "Models/IP/Address/V6";
			:local paths [:toarray "$path/Base.rsc,$path/Zstance.rsc"];
			:local objTool [($MtmFacts->"execute") nsStr="getTools()->getObjects()"];
			[($objTool->"getInstanceV1") paths=$paths id=$0 classId=$classId];
		}
		:return ($MtmO->$classId);
	}
	:set ($MtmI->$classId) $s;
}
