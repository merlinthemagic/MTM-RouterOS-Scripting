:set ($s->"getRegCount") do={
	:global MtmFacts;
	:local inclVirtual false;
	:if ($0 = true) do={
		#count registrations on virtual interfaces that use this interface as master
		:set inclVirtual true;
	}
	:global MtmO;
	:local self ($MtmO->"|MTMC|");
	:local regCount [:len [/interface wireless registration-table find where interface=[($self->"getName")]]];
	:if ($inclVirtual = true && [($self->"isVirtual")] = false) do={
		:local ifObj;
		:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getWireless()"];
		:foreach id in=[/interface wireless find master-interface=[($self->"getName")]] do={
			:set ifObj [($factObj->"getById") $id]
			:set regCount ($regCount + [($ifObj->"getRegCount")]);	
		}
	}
	:return $regCount;
}