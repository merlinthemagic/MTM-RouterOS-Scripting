:local cPath "MTM/Facts/Tools/AVP.rsc";
:local s [:toarray ""];

:set ($s->"getPersistent") do={

	:global MtmToolAvps1;
	:if ([:typeof ($MtmToolAvps1->"persist")] = "nothing") do={
		:global MtmFacts;
		:local mVal ([($MtmFacts->"getEnv") "mtm.root.path"]."/Tools/AVP/Persistent.rsc");
		:set mVal [($MtmFacts->"importFile") $mVal];
	}
	:return ($MtmToolAvps1->"persist");
}

:global MtmToolAvps1;
:set MtmToolAvps1 [:toarray ""];

:global MtmTools;
:set ($MtmTools->"avp") $s;