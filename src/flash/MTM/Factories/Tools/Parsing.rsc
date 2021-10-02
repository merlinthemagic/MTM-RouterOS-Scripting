:local classId "fact-tool-parsing";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmT;
:if (($MtmT->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getPrimitives") do={
		:global MtmT;
		:local classId "tool-parsing-primis";
		:if ($MtmT->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Parsing/Primitives.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT->$classId);
	}
	:set ($s->"getJsonEncode") do={
		:global MtmT;
		:local classId "tool-parsing-json-enc";
		:if ($MtmT->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Parsing/JsonEncode.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT->$classId);
	}
	:set ($s->"getMonitorData") do={
		:global MtmT;
		:local classId "tool-parsing-monitor-data";
		:if ($MtmT->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Parsing/MonitorData.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT->$classId);
	}
	:set ($s->"getDateTime") do={
		:global MtmT;
		:local classId "tool-parsing-date-time";
		:if ($MtmT->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Parsing/DateTime.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT->$classId);
	}
	:set ($s->"getIPv4") do={
		:global MtmT;
		:local classId "tool-parsing-ipv4";
		:if ($MtmT->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Parsing/IPv4.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT->$classId);
	}
	:set ($s->"getIPv6") do={
		:global MtmT;
		:local classId "tool-parsing-ipv6";
		:if ($MtmT->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Parsing/IPv6.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT->$classId);
	}
	:set ($s->"getPing") do={
		:global MtmT;
		:local classId "tool-parsing-ping";
		:if ($MtmT->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Parsing/Ping.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT->$classId);
	}
	:set ($s->"getWlanScan") do={
		:global MtmT;
		:local classId "tool-parsing-wlan-scan";
		:if ($MtmT->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Parsing/WlanScan.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT->$classId);
	}
	:set ($MtmT->$classId) $s;
}
