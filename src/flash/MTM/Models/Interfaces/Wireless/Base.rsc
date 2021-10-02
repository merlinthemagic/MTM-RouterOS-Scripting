:set ($s->"isVirtual") do={
	:local type [/interface wireless get |MTMD| interface-type];
	:if ($type = "virtual") do={
		:return true;
	} else={
		:return false;
	}
}