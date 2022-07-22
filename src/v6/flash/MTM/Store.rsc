:global MtmStore;
:if ($MtmStore = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"stores") [:toarray ""];
	
	:set ($s->"getStore") do={
		:global MtmFacts;
		:global MtmStore;
		:local method "MtmStore->getStore";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Store name is mandatory"];
		}
		:if ($MtmStore->"stores"->$0 = nil) do={
			:local storeObj [:toarray ""];
			:set ($storeObj->"name") $0;
			:set ($storeObj->"data") [:toarray ""];
			:set ($MtmStore->"stores"->$0) $storeObj;
		}
		:return ($MtmStore->"stores"->$0);
	}
	:set MtmStore $s;
};