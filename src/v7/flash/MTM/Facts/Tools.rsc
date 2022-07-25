:local cPath "MTM/Facts/Tools.rsc";
:local s [:toarray ""];

:set ($s->"getTypes") do={
	:global MtmTools;
	:if ([:typeof ($MtmTools->"types")] = "nothing") do={
		:global MtmFacts;
		:local mVal "";
		:set mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Facts/Tools/Types.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmTools->"types");
}
:set ($s->"getHashing") do={
	:global MtmTools;
	:if ([:typeof ($MtmTools->"hashing")] = "nothing") do={
		:global MtmFacts;
		:local mVal "";
		:set mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Facts/Tools/Hashing.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmTools->"hashing");
}
:set ($s->"getJson") do={
	:global MtmTools;
	:if ([:typeof ($MtmTools->"json")] = "nothing") do={
		:global MtmFacts;
		:local mVal "";
		:set mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Facts/Tools/Json.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmTools->"json");
}
:global MtmTools;
:set MtmTools [:toarray ""];

:global MtmFaObjs;
:set ($MtmFaObjs->"tools") $s;