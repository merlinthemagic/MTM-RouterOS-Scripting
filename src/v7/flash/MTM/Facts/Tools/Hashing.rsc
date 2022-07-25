:local cPath "MTM/Facts/Tools/Hashing.rsc";
:local s [:toarray ""];

:set ($s->"getMD5") do={

	:global MtmToolHashing1;
	:if ([:typeof ($MtmToolHashing1->"md5")] = "nothing") do={
		:global MtmFacts;
		:local mVal "";
		:set mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Tools/Hashing/MD5.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmToolHashing1->"md5");
}

:global MtmToolHashing1;
:set MtmToolHashing1 [:toarray ""];

:global MtmTools;
:set ($MtmTools->"hashing") $s;