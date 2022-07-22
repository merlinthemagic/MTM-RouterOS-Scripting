:set ($s->"get") do={
	## generate guids in format: [11B8AA12-E644-0399-71D6-B2AA561233EB]
	:global MtmFacts;
	:local method "Tools->Guids->V4->get";
	:local inclBraces true;
	:if ($0 = false) do={
		:set inclBraces false;
	}
	
	:local strTool [($MtmFacts->"execute") nsStr="getTools()->getStrings()"];
	:local randStr ([/certificate scep-server otp generate minutes-valid=0 as-value]->"password");
	:set randStr ($randStr.([/certificate scep-server otp generate minutes-valid=0 as-value]->"password"));
	:set randStr [($strTool->"toUpper") $randStr];
	
	:local rData "";
	:if ($inclBraces = true) do={
		:set rData ($rData."[");
	}
	:for x from=0 to=35 do={
		:if ($x = 8 || $x = 13 || $x = 18 || $x = 23) do={
			:set rData ($rData."-");
		} else={
			:set rData ($rData.[:pick $randStr $x]);
		}
	}
	:if ($inclBraces = true) do={
		:set rData ($rData."]");
	}
	:return $rData;
}
