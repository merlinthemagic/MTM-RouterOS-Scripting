:local classId "fact-ifs";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmIF;
:if (($MtmIF->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getDot1x") do={
		:global MtmFacts;
		:local classId "fact-if-dot1x";
		:if ($MtmFacts->"c"->$classId = nil) do={
			:local path ([($MtmFacts->"getMtmPath")]."Factories/Interfaces/Dot1x.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmFacts->"c"->$classId);
	}
	:set ($s->"getEthernet") do={
		:global MtmFacts;
		:local classId "fact-if-ethernet";
		:if ($MtmFacts->"c"->$classId = nil) do={
			:local path ([($MtmFacts->"getMtmPath")]."Factories/Interfaces/Ethernet.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmFacts->"c"->$classId);
	}
	:set ($s->"getWireless") do={
		:global MtmFacts;
		:local classId "fact-if-wireless";
		:if ($MtmFacts->"c"->$classId = nil) do={
			:local path;
			:if ([/system package get [find name=wireless] disabled] = false) do= {
				:set path ([($MtmFacts->"getMtmPath")]."Factories/Interfaces/Wireless.rsc");
			} else={
				## Wireless package not enabled or installed
				:set path ([($MtmFacts->"getMtmPath")]."Factories/Interfaces/WirelessMissing.rsc");
			}
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmFacts->"c"->$classId);
	}
	:set ($s->"getBridges") do={
		:global MtmFacts;
		:local classId "fact-if-bridges";
		:if ($MtmFacts->"c"->$classId = nil) do={
			:local path ([($MtmFacts->"getMtmPath")]."Factories/Interfaces/Bridges.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmFacts->"c"->$classId);
	}
	:set ($s->"getVLAN") do={
		:global MtmFacts;
		:local classId "fact-if-vlan";
		:if ($MtmFacts->"c"->$classId = nil) do={
			:local path ([($MtmFacts->"getMtmPath")]."Factories/Interfaces/VLAN.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmFacts->"c"->$classId);
	}
	:set ($s->"getLTE") do={
		:global MtmFacts;
		:local classId "fact-if-lte";
		:if ($MtmFacts->"c"->$classId = nil) do={
			:local path ([($MtmFacts->"getMtmPath")]."Factories/Interfaces/LTE.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmFacts->"c"->$classId);
	}
	:set ($s->"getLists") do={
		:global MtmFacts;
		:local classId "fact-if-lists";
		:if ($MtmFacts->"c"->$classId = nil) do={
			:local path ([($MtmFacts->"getMtmPath")]."Factories/Interfaces/Lists.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmFacts->"c"->$classId);
	}
	:set ($s->"getListMembers") do={
		:global MtmFacts;
		:local classId "fact-if-list-members";
		:if ($MtmFacts->"c"->$classId = nil) do={
			:local path ([($MtmFacts->"getMtmPath")]."Factories/Interfaces/ListMembers.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmFacts->"c"->$classId);
	}
	:set ($MtmIF->$classId) $s;
}
