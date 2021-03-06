:set ($s->"getName") do={
	:return [/interface list get |MTMD| name];
}
:set ($s->"getInterfaceNames") do={
	:global MtmFacts;
	:local c 0;
	:local rDatas [:toarray ""];
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:foreach id in=[/interface list member find list=[($self->"getName")]] do={
		:set ($rDatas->"$c") [/interface list member get $id interface];
		:set c ($c + 1);
	}
	:return $rDatas;
}
:set ($s->"getEnabledInterfaceNames") do={
	:global MtmFacts;
	:local c 0;
	:local rDatas [:toarray ""];
	:local disabled;
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local list [($self->"getName")];
	:foreach ifName in=[($self->"getInterfaceNames")] do={
		:set disabled [/interface list member get [find interface=$ifName && list=$list] disabled];
		:if ($disabled = false) do={
			:set ($rDatas->"$c") $ifName;
			:set c ($c + 1);
		}
	}
	:return $rDatas;
}
:set ($s->"getMembers") do={
	:global MtmFacts;
	:local c 0;
	:local rObjs [:toarray ""];
	:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getListMembers()"];
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:foreach id in=[/interface list member find list=[($self->"getName")]] do={
		:set ($rObjs->"$c") [($factObj->"getById") $id];
		:set c ($c + 1);
	}
	:return $rDatas;
}
:set ($s->"getMemberByInterfaceName") do={
	:global MtmFacts;
	:local method "Models->Interfaces->List->getMemberByInterfaceName";
	:if ($0 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Interface Name is mandatory"];
	}
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local id [/interface list member find where list=[($self->"getName")] && interface=$0];
	:if ([:typeof $id] != "nil") do={
		:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getListMembers()"];
		:return [($factObj->"getById") $id];
	}
	:return [($MtmFacts->"getNull")];
}