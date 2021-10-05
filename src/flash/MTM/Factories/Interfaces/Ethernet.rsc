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
		:local classId ("mtm-if-eth-".$0);
		:if ($MtmO2->$classId = nil) do={
			:local paths [:toarray ""];
			:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Models/Base.rsc");
			:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Models/Interfaces/Base.rsc");
			:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Models/Interfaces/Ethernet/Base.rsc");
			:set ($paths->3) ([($MtmFacts->"getMtmPath")]."Models/Interfaces/Ethernet/Attrs.rsc");
			:set ($paths->4) ([($MtmFacts->"getMtmPath")]."Models/Interfaces/Ethernet/PoE.rsc");
			:set ($paths->5) ([($MtmFacts->"getMtmPath")]."Models/Interfaces/Ethernet/Traffic.rsc");
			:set ($paths->6) ([($MtmFacts->"getMtmPath")]."Models/Zstance.rsc");

			:local objTool [($MtmFacts->"execute") nsStr="getTools()->getObjects()"];
			:return [($objTool->"getInstanceV3") $paths $classId $0 $MtmO2 "MtmO2"];
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
