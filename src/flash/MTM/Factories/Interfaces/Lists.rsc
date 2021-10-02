:local classId "fact-if-lists";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:if (($MtmFacts->"c"->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"a") [:toarray ""];
	
	:set ($s->"getById") do={
	
		:global MtmFacts;
		:local method "Facts->Interfaces->Lists->getById";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Id is mandatory"];
		}
		:global MtmO;
		:local classId ("model-if-list-".$0);
		:if ($MtmO->$classId = nil) do={
			:local path "Models/Interfaces/List";
			:local paths [:toarray "$path/Part1.rsc,$path/Part2.rsc"];
			:local objTool [($MtmFacts->"execute") nsStr="getTools()->getObjects()" ];
			[($objTool->"getInstanceV1") paths=$paths id=$0 classId=$classId];
		}
		:return ($MtmO->$classId);
	}
	:set ($s->"getAll") do={
		:global MtmFacts;
		:local c 0;
		:local rObjs [:toarray ""];
		:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getLists()"];
		:foreach id in=[/interface list find ] do={
			:set ($rObjs->"$c") [($factObj->"getById") $id];
			:set c ($c + 1);
		}
		:return $rObjs;
	}
	:set ($s->"getByName") do={
		:global MtmFacts;
		
		:local method "Facts->Interfaces->Lists->getByName";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Name is mandatory"];
		}
		:local id [/interface list find where name=$0];
		:if ([:typeof $id] != "nil") do={
			:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getLists()"];
			:return [($factObj->"getById") $id];
		}
		:return [($MtmFacts->"getNull")];
	}
	:set ($MtmFacts->"c"->$classId) $s;
}
