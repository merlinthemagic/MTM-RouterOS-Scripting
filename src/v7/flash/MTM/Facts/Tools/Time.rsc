:local cPath "MTM/Facts/Tools/Time.rsc";
:local s [:toarray ""];

:set ($s->"getEpoch") do={

	:global MtmToolTime1;
	:if ([:typeof ($MtmToolTime1->"epoch")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Tools/Time/Epoch.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmToolTime1->"epoch");
}
:set ($s->"getRos") do={

	:global MtmToolTime1;
	:if ([:typeof ($MtmToolTime1->"ros")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Tools/Time/ROS.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmToolTime1->"ros");
}

:global MtmToolTime1;
:set MtmToolTime1 [:toarray ""];

:global MtmTools;
:set ($MtmTools->"time") $s;