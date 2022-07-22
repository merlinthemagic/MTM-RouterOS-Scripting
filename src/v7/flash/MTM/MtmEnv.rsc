:local className "MTM->MtmEnv.rsc";
:global MtmFacts;
:if ($MtmFacts != nil) do={

	:local mVal [($MtmFacts->"getEnv") "mtm.env.loaded" false];
	:if ([:typeof $mVal] = "nil") do={
		:set mVal [($MtmFacts->"setEnv") "mtm.root.path" "flash/MTM"];
		:set mVal [($MtmFacts->"setEnv") "mtm.debug.enabled" "false"];
		:set mVal [($MtmFacts->"setEnv") "mtm.env.loaded" "true"];
	}
	
} else={
	:error ($className.": MtmFacts is not loaded");
}
