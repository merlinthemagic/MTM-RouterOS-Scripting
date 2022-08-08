:local cPath "MTM/Tools/Interfaces/Wlans.rsc";
:local s [:toarray ""];

:set ($s->"getScan") do={

	:global MtmFacts;
	:local cPath "MTM/Tools/Interfaces/Wlans.rsc/getScan";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input has invalid type '".[:typeof $0]."' must be wlan interface name");
	}
	:local mVal "";
	:local strTool [($MtmFacts->"get") "getTools()->getTypes()->getStrings()"];

	##do background by default so we dont loose DFS status. If not using background we get lots of errors: scan not running interrupted
	## cannot catch those errors, then terminate the script, we would need to send them to a child process
	##with background scan you loose snr and noise floor
	:local bgScan "yes";
	:local mStatus ([/interface/wireless/monitor [find where name=$0] once as-value]->"status");
	:if ($mStatus != "running-ap") do={
		##we dont want to be the ones who enable/disable or change config just to do a scan
		:error ($cPath.": Cannot perform scan when radio status is '".$mStatus."'");
	}
	
	:local datas ([/interface/wireless/scan [find where name=$0] background=$bgScan rounds=1 passive=yes as-value]);
	:local rObjs [:toarray ""];
	:local rObj [:toarray ""];
	:local r 0;

	:foreach i,cells in=$datas do={
		:set rObj [:toarray ""];
		:set ($rObj->"bssid") [($strTool->"replace") ($cells->"address") ":" ""];
		:set ($rObj->"protocol") "802.11";
		:set ($rObj->"signal") ([:tonum ($cells->"sig")]);
		:set ($rObj->"channel") ($cells->"channel");
		:set ($rObj->"ssid") ([:tostr ($cells->"ssid")]);
		:set ($rObj->"radio-name") ([:tostr ($cells->"radio-name")]);
		:set ($rObj->"ros-version") ([:tostr ($cells->"routeros-version")]);
		:set ($rObjs->$r) $rObj;
		:set r ($r + 1);
	}
	:return $rObjs;
}

:global MtmToolIfs1;
:set ($MtmToolIfs1->"wlans") $s;