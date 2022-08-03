:local cPath "MTM/Facts/Tools.rsc";
:local s [:toarray ""];

:set ($s->"getTypes") do={
	:global MtmTools;
	:if ([:typeof ($MtmTools->"types")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Facts/Tools/Types.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmTools->"types");
}
:set ($s->"getHashing") do={
	:global MtmTools;
	:if ([:typeof ($MtmTools->"hashing")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Facts/Tools/Hashing.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmTools->"hashing");
}
:set ($s->"getJson") do={
	:global MtmTools;
	:if ([:typeof ($MtmTools->"json")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Facts/Tools/Json.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmTools->"json");
}
:set ($s->"getJobs") do={
	:global MtmTools;
	:if ([:typeof ($MtmTools->"jobs")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Facts/Tools/Jobs.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmTools->"jobs");
}
:set ($s->"getTime") do={
	:global MtmTools;
	:if ([:typeof ($MtmTools->"time")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Facts/Tools/Time.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmTools->"time");
}
:set ($s->"getGuids") do={
	:global MtmTools;
	:if ([:typeof ($MtmTools->"guids")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Facts/Tools/Guids.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmTools->"guids");
}
:set ($s->"getInterfaces") do={
	:global MtmTools;
	:if ([:typeof ($MtmTools->"ifs")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Facts/Tools/Interfaces.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmTools->"ifs");
}
:global MtmTools;
:set MtmTools [:toarray ""];

:global MtmFaObjs;
:set ($MtmFaObjs->"tools") $s;