:local cPath "MTM/Facts/Tools/Jobs.rsc";
:local s [:toarray ""];

:set ($s->"getStatus") do={

	:global MtmToolJobs1;
	:if ([:typeof ($MtmToolJobs1->"status")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Tools/Jobs/Status.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmToolJobs1->"status");
}
:set ($s->"getSignals") do={

	:global MtmToolJobs1;
	:if ([:typeof ($MtmToolJobs1->"signal")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Tools/Jobs/Signals.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmToolJobs1->"signal");
}
:set ($s->"getTracking") do={

	:global MtmToolJobs1;
	:if ([:typeof ($MtmToolJobs1->"track")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Tools/Jobs/Tracking.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmToolJobs1->"track");
}
:set ($s->"getScripts") do={

	:global MtmToolJobs1;
	:if ([:typeof ($MtmToolJobs1->"scripts")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Tools/Jobs/Scripts.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmToolJobs1->"scripts");
}

:global MtmToolJobs1;
:set MtmToolJobs1 [:toarray ""];

:global MtmTools;
:set ($MtmTools->"jobs") $s;