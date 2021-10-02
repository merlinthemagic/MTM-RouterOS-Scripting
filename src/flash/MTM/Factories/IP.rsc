:local classId "fact-ip";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmI;
:if (($MtmI->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getDhcpServers") do={
		:global MtmI;
		:local classId "fact-ip-dhcp-servers";
		:if ($MtmI->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Factories/IP/DhcpServers.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmI->$classId);
	}
	:set ($s->"getAddresses") do={
		:global MtmI;
		:local classId "fact-ip-addrs";
		:if ($MtmI->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Factories/IP/Addresses.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmI->$classId);
	}
	:set ($MtmI->$classId) $s;
}
