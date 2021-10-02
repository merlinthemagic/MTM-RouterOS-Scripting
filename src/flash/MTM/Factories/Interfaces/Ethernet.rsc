:local classId "fact-if-ethernet";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:if (($MtmFacts->"c"->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getById") do={
	
		:global MtmFacts;
		:local method "Facts->Interfaces->Ethernet->getById";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Id is mandatory"];
		}
		:global MtmO2;
		:local classId ("model-if-eth-".$0);
		:if ($MtmO2->$classId = nil) do={
			:local path "Models/Interfaces";
			:local paths [:toarray "$path/Astance.rsc,$path/Ethernet/Base.rsc,$path/Ethernet/Attrs.rsc,$path/Ethernet/PoE.rsc,$path/Ethernet/Traffic.rsc,$path/Zstance.rsc"];
			:local objTool [($MtmFacts->"execute") nsStr="getTools()->getObjects()"];
			[($objTool->"getInstanceV1") paths=$paths id=$0 classId=$classId objCacheId=2];
		}
		:return ($MtmO2->$classId);
	}
	:set ($s->"getAll") do={
		:global MtmFacts;
		:local c 0;
		:local rObjs [:toarray ""];
		:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getEthernet()"];
		:foreach id in=[/interface ethernet find ] do={
			:set ($rObjs->"$c") [($factObj->"getById") $id];
			:set c ($c + 1);
		}
		:return $rObjs;
	}
	:set ($s->"getByName") do={
		:global MtmFacts;
		
		:local method "Facts->Interfaces->Ethernet->getByName";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Name is mandatory"];
		}
		:local id [/interface ethernet find where name=$0];
		:if ([:len $id] > 0) do={
			:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getEthernet()"];
			:return [($factObj->"getById") ($id->0)];
		}
		:return [($MtmFacts->"getNull")];
	}
	:set ($MtmFacts->"c"->$classId) $s;
}
