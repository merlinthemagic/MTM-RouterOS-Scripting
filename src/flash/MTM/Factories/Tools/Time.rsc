:local classId "fact-tool-time";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmT;
:if (($MtmT3->$classId) = nil) do={

	:local s [:toarray ""];
	:set ($s->"getEpoch") do={
		:global MtmT3;
		:local classId "tool-time-epoch";
		:if ($MtmT3->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Time/Epoch.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT3->$classId);
	}
	:set ($s->"getRos") do={
		:global MtmT3;
		:local classId "tool-time-ros";
		:if ($MtmT3->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Time/ROS.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT3->$classId);
	}
	:set ($MtmT->$classId) $s;
}
