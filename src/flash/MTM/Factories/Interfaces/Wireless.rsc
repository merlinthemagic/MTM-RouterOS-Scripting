:local classId "fact-if-wireless";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:if (($MtmFacts->"c"->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getById") do={
	
		:global MtmFacts;
		:local method "Facts->Interfaces->Wireless->getById";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Id is mandatory"];
		}
		:global MtmO;
		:local classId ("mtm-if-wlan-".$0);
		:if ($MtmO->$classId = nil) do={
		
			:local paths [:toarray ""];
			:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Models/Base.rsc");
			:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Models/Interfaces/Base.rsc");
			:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Models/Interfaces/Wireless/Base.rsc");
			:set ($paths->3) ([($MtmFacts->"getMtmPath")]."Models/Interfaces/Wireless/Attrs.rsc");
			:set ($paths->4) ([($MtmFacts->"getMtmPath")]."Models/Interfaces/Wireless/Clients.rsc");
			:set ($paths->5) ([($MtmFacts->"getMtmPath")]."Models/Interfaces/Wireless/Traffic.rsc");
			:set ($paths->6) ([($MtmFacts->"getMtmPath")]."Models/Zstance.rsc");

			:local objTool [($MtmFacts->"execute") nsStr="getTools()->getObjects()"];
			:return [($objTool->"getInstanceV3") $paths $classId $0 $MtmO "MtmO"];
		}
		:return ($MtmO->$classId);
	}
	:set ($s->"getAll") do={
		:global MtmFacts;
		:local c 0;
		:local rObjs [:toarray ""];
		:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getWireless()"];
		:foreach id in=[/interface wireless find ] do={
			:set ($rObjs->"$c") [($factObj->"getById") $id];
			:set c ($c + 1);
		}
		:return $rObjs;
	}
	:set ($s->"getAllHardware") do={
		:global MtmFacts;
		:local c 0;
		:local rObjs [:toarray ""];
		:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getWireless()"];
		:foreach id in=[/interface wireless find where interface-type!=virtual] do={
			:set ($rObjs->"$c") [($factObj->"getById") $id];
			:set c ($c + 1);
		}
		:return $rObjs;
	}
	:set ($s->"getByName") do={
		:global MtmFacts;
		
		:local method "Facts->Interfaces->Wireless->getByName";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Name is mandatory"];
		}
		:local id [/interface wireless find where name=$0];
		:if ([:len $id] > 0) do={
			:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getWireless()"];
			:return [($factObj->"getById") ($id->0)];
		}
		:return [($MtmFacts->"getNull")];
	}
	:set ($MtmFacts->"c"->$classId) $s;
}
