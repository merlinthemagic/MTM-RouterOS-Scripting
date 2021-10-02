:local classId "fact-if-vlan";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:if (($MtmFacts->"c"->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getById") do={
	
		:global MtmFacts;
		:local method "Facts->Interfaces->VLAN->getById";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Id is mandatory"];
		}
		:global MtmO;
		:local classId ("model-if-vlan-".$0);
		:if ($MtmO->$classId = nil) do={
			:local path "Models/Interfaces";
			:local paths [:toarray "$path/Astance.rsc,$path/VLAN/Base.rsc,$path/Zstance.rsc"];
			:local objTool [($MtmFacts->"execute") nsStr="getTools()->getObjects()" ];
			[($objTool->"getInstanceV1") paths=$paths id=$0 classId=$classId];
		}
		:return ($MtmO->$classId);
	}
	:set ($s->"getAll") do={
		:global MtmFacts;
		:local c 0;
		:local rObjs [:toarray ""];
		:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getVLAN()"];
		:foreach id in=[/interface vlan find ] do={
			:set ($rObjs->"$c") [($factObj->"getById") $id];
			:set c ($c + 1);
		}
		:return $rObjs;
	}
	:set ($s->"getByName") do={
		:global MtmFacts;
		
		:local method "Facts->Interfaces->VLAN->getByName";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Name is mandatory"];
		}
		:local id [/interface vlan find where name=$0];
		:if ([:len $id] > 0) do={
			:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getVLAN()"];
			:return [($factObj->"getById") ($id->0)];
		}
		:return [($MtmFacts->"getNull")];
	}
	:set ($MtmFacts->"c"->$classId) $s;
}
