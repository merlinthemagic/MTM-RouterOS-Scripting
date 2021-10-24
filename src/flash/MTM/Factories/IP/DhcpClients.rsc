:local classId "fact-ip-dhcp-clients";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmI;
:if (($MtmI->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getById") do={
	
		:global MtmFacts;
		:local method "Facts->IP->DhcpClients->getById";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Id is mandatory"];
		}
		:global MtmO3;
		:local classId ("mtm-ip-dhcp-cli-".$0);
		:if ($MtmO3->$classId = nil) do={
		
			:local paths [:toarray ""];
			:set ($paths->0) ([($MtmFacts->"getMtmPath")]."Models/Base.rsc");
			:set ($paths->1) ([($MtmFacts->"getMtmPath")]."Models/IP/DHCP/Client/Base.rsc");
			:set ($paths->2) ([($MtmFacts->"getMtmPath")]."Models/Zstance.rsc");

			:local objTool [($MtmFacts->"execute") nsStr="getTools()->getObjects()"];
			:return [($objTool->"getInstanceV3") $paths $classId $0 $MtmO3 "MtmO3"];
		}
		:return ($MtmO3->$classId);
	}
	:set ($s->"getAll") do={
		:global MtmFacts;
		:local c 0;
		:local rObjs [:toarray ""];
		:local factObj [($MtmFacts->"execute") nsStr="getIP()->getDhcpClients()"];
		:foreach id in=[/ip dhcp-client find] do={
			:set ($rObjs->"$c") [($factObj->"getById") $id];
			:set c ($c + 1);
		}
		:return $rObjs;
	}
	:set ($s->"getByInterfaceName") do={
		:global MtmFacts;
		
		:local method "Facts->IP->DhcpClients->getByInterfaceName";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Interface name is mandatory"];
		}
		:local id [/ip dhcp-client find where interface=$0];
		:if ([:len $id] > 0) do={
			:local factObj [($MtmFacts->"execute") nsStr="getIP()->getDhcpClients()"];
			:return [($factObj->"getById") ($id->0)];
		}
		:return [($MtmFacts->"getNull")];
	}
	:set ($MtmI->$classId) $s;
}
