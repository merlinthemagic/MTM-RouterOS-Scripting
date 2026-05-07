:local cPath "MTM/Tools/Guids/V4.rsc";
:local s [:toarray ""];
:set ($s->"get") do={
	## generate guids in format: 11B8AA12-E644-0399-71D6-B2AA561233EB
	:global MtmFacts;
	:local cPath "MTM/Tools/Guids/V4.rsc/get";
	
	:local strTool [($MtmFacts->"get") "getTools()->getTypes()->getStrings()"];
	:local randStr [($strTool->"getRandom") [:tonum 36]];
	:set randStr [($strTool->"toUpper") $randStr];
		:local rData "";
	:for x from=0 to=35 do={
		:if ($x = 8 || $x = 13 || $x = 18 || $x = 23) do={
			:set rData ($rData."-");
		} else={
			:set rData ($rData.[:pick $randStr $x]);
		}
	}
	:return $rData;
}
:global MtmToolGuid1;
:set ($MtmToolGuid1->"v4") $s;
