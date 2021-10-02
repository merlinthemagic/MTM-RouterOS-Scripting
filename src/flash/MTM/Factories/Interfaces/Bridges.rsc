:local classId "fact-if-bridges";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:if (($MtmFacts->"c"->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getById") do={
	
		:global MtmFacts;
		:local method "Facts->Interfaces->Bridges->getById";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Id is mandatory"];
		}
		:global MtmO1;
		:local classId ("model-if-brd-".$0);
		:if ($MtmO1->$classId = nil) do={
			:local path "Models/Interfaces";
			:local paths [:toarray "$path/Astance.rsc,$path/Bridge/Base.rsc,$path/Bridge/Hosts.rsc,$path/Bridge/Zstance.rsc"];
			:local objTool [($MtmFacts->"execute") nsStr="getTools()->getObjects()"];
			[($objTool->"getInstanceV1") paths=$paths id=$0 classId=$classId objCacheId=1];
		}
		:return ($MtmO1->$classId);
	}
	:set ($s->"getAll") do={
		:global MtmFacts;
		:local c 0;
		:local rObjs [:toarray ""];
		:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getBridges()"];
		:foreach id in=[/interface bridge find ] do={
			:set ($rObjs->"$c") [($factObj->"getById") $id];
			:set c ($c + 1);
		}
		:return $rObjs;
	}
	:set ($s->"getByName") do={
		:global MtmFacts;
		
		:local method "Facts->Interfaces->Bridges->getByName";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Name is mandatory"];
		}

		:local id [/interface bridge find where name=$0];
		:if ([:len $id] > 0) do={
			:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getBridges()"];
			:return [($factObj->"getById") ($id->0)];
		}
		:return [($MtmFacts->"getNull")];
	}
	:set ($MtmFacts->"c"->$classId) $s;
}
