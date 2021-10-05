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
		:local classId ("mtm-if-brd-".$0);
		:if ($MtmO1->$classId = nil) do={
		
			:local paths [:toarray ""];
			:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Models/Base.rsc");
			:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Models/Interfaces/Base.rsc");
			:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Models/Interfaces/Bridge/Base.rsc");
			:set ($paths->3) ([($MtmFacts->"getMtmPath")]."Models/Interfaces/Bridge/Hosts.rsc");
			:set ($paths->4) ([($MtmFacts->"getMtmPath")]."Models/Zstance.rsc");

			:local objTool [($MtmFacts->"execute") nsStr="getTools()->getObjects()"];
			:return [($objTool->"getInstanceV3") $paths $classId $0 $MtmO1 "MtmO1"];
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
