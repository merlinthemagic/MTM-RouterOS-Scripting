:local classId "fact-system-resource";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmS;
:if (($MtmS->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getAvgCpuLoad") do={
		:return [/system resource get cpu-load];
	}
	:set ($s->"getCpuLoads") do={
		:local c 0;
		:local rData [:toarray ""];
		:foreach id in=[/system resource cpu find] do={
			:set ($rData->"$c") [/system resource cpu get $id load];
			:set c ($c + 1);
		}
		:return $rData;
	}
	:set ($s->"getFreeMemory") do={
		:return [/system resource get free-memory];
	}
	:set ($s->"getFreeHddSpace") do={
		:return [/system resource get free-hdd-space];
	}
	:set ($s->"getUptime") do={
		:global MtmFacts;
		:local toolObj [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getDateTime()"];
		:return [($toolObj->"toSeconds") ([/system resource get uptime])];
	}
	:set ($s->"getCpuModel") do={
		:return [/system resource get cpu];
	}
	:set ($s->"getBadHddBlocks") do={
		:return [/system resource get bad-blocks];
	}
	:set ($MtmS->$classId) $s;
}
