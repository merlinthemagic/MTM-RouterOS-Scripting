:local classId "fact-tool-ifs";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmT;
:if (($MtmT->$classId) = nil) do={
	
	:local s [:toarray ""];	
	:set ($s->"getEthernet") do={
		:global MtmFacts;
		:local classId "tool-ifs-eth";
		:if ($MtmFacts->"c"->$classId = nil) do={
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Interfaces/Ethernet.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmFacts->"c"->$classId);
	}
	:set ($s->"getWireless") do={
		:global MtmFacts;
		:local classId "tool-ifs-wlan";
		:if ($MtmFacts->"c"->$classId = nil) do={
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Interfaces/Wireless.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmFacts->"c"->$classId);
	}
	:set ($s->"getBridge") do={
		:global MtmFacts;
		:local classId "tool-ifs-brd";
		:if ($MtmFacts->"c"->$classId = nil) do={
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Interfaces/Bridge.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmFacts->"c"->$classId);
	}
	:set ($s->"getCommon") do={
		:global MtmFacts;
		:local classId "tool-ifs-common";
		:if ($MtmFacts->"c"->$classId = nil) do={
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Interfaces/Common.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmFacts->"c"->$classId);
	}
	:set ($MtmT->$classId) $s;
}
