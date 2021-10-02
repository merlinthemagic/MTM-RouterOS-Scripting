:local classId "fact-ip-dhcp-servers";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmI;
:if (($MtmI->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getById") do={
	
		:global MtmFacts;
		:local method "Facts->IP->DhcpServers->getById";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Id is mandatory"];
		}
		:global MtmO3;
		:local classId ("model-ip-dhcp-serv-".$0);
		:if ($MtmO3->$classId = nil) do={
			:local path "Models/IP/DHCP/Server";
			:local paths [:toarray "$path/Base.rsc,$path/Zstance.rsc"];
			:local objTool [($MtmFacts->"execute") nsStr="getTools()->getObjects()"];
			[($objTool->"getInstanceV1") paths=$paths id=$0 classId=$classId objCacheId=3];
		}
		:return ($MtmO3->$classId);
	}
	:set ($s->"getAll") do={
		:global MtmFacts;
		:local c 0;
		:local rObjs [:toarray ""];
		:local factObj [($MtmFacts->"execute") nsStr="getIP()->getDhcpServers()"];
		:foreach id in=[/ip dhcp-server find] do={
			:set ($rObjs->"$c") [($factObj->"getById") $id];
			:set c ($c + 1);
		}
		:return $rObjs;
	}
	:set ($s->"getByName") do={
		:global MtmFacts;
		
		:local method "Facts->IP->DhcpServers->getByName";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Name is mandatory"];
		}
		:local id [/ip dhcp-server find where name=$0];
		:if ([:len $id] > 0) do={
			:local factObj [($MtmFacts->"execute") nsStr="getIP()->getDhcpServers()"];
			:return [($factObj->"getById") ($id->0)];
		}
		:return [($MtmFacts->"getNull")];
	}
	:set ($MtmI->$classId) $s;
}
