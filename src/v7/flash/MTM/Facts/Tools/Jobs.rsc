:local cPath "MTM/Facts/Tools/Jobs.rsc";
:local s [:toarray ""];

:set ($s->"getStatus") do={

	:global MtmToolJobs1;
	:if ([:typeof ($MtmToolJobs1->"status")] = "nothing") do={
		:global MtmFacts;
		:local mVal "";
		:set mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Tools/Jobs/Status.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmToolJobs1->"status");
}
:global MtmToolJobs1;
:set MtmToolJobs1 [:toarray ""];

:global MtmTools;
:set ($MtmTools->"jobs") $s;