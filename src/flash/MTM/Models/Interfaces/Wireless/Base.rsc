:set ($s->"isVirtual") do={
	:local type [/interface wireless get |MTMD| interface-type];
	:if ($type = "virtual") do={
		:return true;
	} else={
		:return false;
	}
}
:set ($s->"getAntennaGain") do={
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:if ([($self->"isVirtual")] = false) do={
		:return [:tonum [/interface wireless get |MTMD| antenna-gain]];
	} else={
		:global MtmFacts;
		:return [($MtmFacts->"getNull")];
	}
}
:set ($s->"getMode") do={
	:return [/interface wireless get |MTMD| mode];
}
:set ($s->"getSsid") do={
	:return [/interface wireless get |MTMD| ssid];
}