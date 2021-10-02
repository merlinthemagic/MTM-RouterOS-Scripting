:local classId "fact-if-dot1x-servers";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:if (($MtmFacts->"c"->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"a") [:toarray ""];
	
	:set ($s->"getById") do={
	
		:global MtmFacts;
		:local method "Facts->Interfaces->Dot1x->Servers->getById";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Id is mandatory"];
		}
		:global MtmO;
		:local classId ("model-if-dot1x-server-".$0);
		:if ($MtmO->$classId = nil) do={
			:local path "Models/Interfaces/Dot1x/Server";
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
		:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getDot1x()->getServers()"];
		:foreach id in=[/interface dot1x server find ] do={
			:set ($rObjs->"$c") [($factObj->"getById") $id];
			:set c ($c + 1);
		}
		:return $rObjs;
	}
	:set ($s->"getByInterface") do={
	
		:global MtmFacts;
		:local method "Facts->Interfaces->Dot1x->Servers->getByInterface";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Interface name is mandatory"];
		}
		:local id [/interface dot1x server find where interface=$0];
		:if ([:typeof $id] != "nil") do={
			:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getDot1x()->getServers()"];
			:return [($factObj->"getById") $id];
		}
		:return [($MtmFacts->"getNull")];
	}
	:set ($MtmFacts->"c"->$classId) $s;
}
