:local cPath "MTM/Facts/Tools/FS.rsc";
:local s [:toarray ""];

:set ($s->"getFiles") do={

	:global MtmToolFs1;
	:if ([:typeof ($MtmToolFs1->"files")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Tools/FS/Files.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmToolFs1->"files");
}
:set ($s->"getDirectories") do={

	:global MtmToolFs1;
	:if ([:typeof ($MtmToolFs1->"dirs")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Tools/FS/Directories.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmToolFs1->"dirs");
}

:global MtmToolFs1;
:set MtmToolFs1 [:toarray ""];

:global MtmTools;
:set ($MtmTools->"fs") $s;