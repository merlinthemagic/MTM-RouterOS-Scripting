:local classId "fact-system";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmS;
:if (($MtmS->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getOS") do={
		:global MtmS;
		:local classId "fact-system-os";
		:if ($MtmS->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Factories/System/OS.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmS->$classId);
	}
	:set ($s->"getRouterboard") do={
		:global MtmS;
		:local classId "fact-system-routerboard";
		:if ($MtmS->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Factories/System/Routerboard.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmS->$classId);
	}
	:set ($s->"getResources") do={
		:global MtmS;
		:local classId "fact-system-resource";
		:if ($MtmS->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Factories/System/Resources.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmS->$classId);
	}
	:set ($s->"getIdentity") do={
		:global MtmS;
		:local classId "fact-system-identity";
		:if ($MtmS->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Factories/System/Identity.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmS->$classId);
	}
	:set ($MtmS->$classId) $s;
}
