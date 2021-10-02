:local s [:toarray ""];
:set ($s->"getId") do={
	:return "|MTMD|";
}
:set ($s->"getInterfaceName") do={
	:return [/interface list member get |MTMD| interface];
}
:set ($s->"getListName") do={
	:return [/interface list member get |MTMD| list];
}
:set ($s->"getDisabled") do={
	:return [/interface list member get |MTMD| disabled];
}
:set ($s->"setDisabled") do={
	:global MtmFacts;
	:local method "Models->Interfaces->ListMember->setDisabled";
	:if ($0 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Disable bool is mandatory"];
	}
	#the joy of dealing with MT primitives
	:local toolObj [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getPrimitives()"];
	:local param1 [($toolObj->"toBool") $0];
	:global MtmO;
	:local self ($MtmO->"|MTMC|");
	:if ([($self->"getDisabled")] != $param1) do= {
		:if ($param1 = true) do= {
			[/interface list member set |MTMD| disabled=yes];
		} else={
			[/interface list member set |MTMD| disabled=no];
		}
	}
	:return $self;
}