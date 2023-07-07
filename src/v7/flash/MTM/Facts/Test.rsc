:global MtmFacts;
#:set MtmFacts;

/import flash/MTM/Facts.rsc;
:global MtmFacts;

[($MtmFacts->"setDebug") true];

##remove specific tool from cache
#:local sysId "tool-time-epoch";
#:local objFact [($MtmFacts->"getObjects")];
#:local sObj [($objFact->"getStore") $sysId];
#:set ($sObj->"obj"->($sObj->"hash"));

#:local result [($MtmFacts->"get") "getTools()->getTime()->getEpoch()->getCurrent()"];
#:put ("Current Epoch: ".$result); #epoch time

:local input "7.11rc5 (development)";##[/system/resource/get version];
#:local input "7.11.4rc3";
:local input "7.11.4beta3";
:local input "7.11";
:local mVer $input;
:local mVer [/system/resource/get version];
:local mPos 0;


:local major "";
:local minor "na";
:local patch "na";
:local preType "na";

:local found 0;
:if ($found = 0) do={
	:set mPos [:find $mVer "rc"];
	:if ([:typeof $mPos] = "num") do={
		:set preType [:pick $mVer $mPos ([:len $mVer])];
		:set mVer [:pick $mVer 0 $mPos];
		:set found 1;
	}
}
:if ($found = 0) do={
	:set mPos [:find $mVer "beta"];
	:if ([:typeof $mPos] = "num") do={
		:set preType [:pick $mVer $mPos ([:len $mVer])];
		:set mVer [:pick $mVer 0 $mPos];
		:set found 1;
	}
}
:if ($found = 0) do={
	:set mPos [:find $mVer "alpha"];
	:if ([:typeof $mPos] = "num") do={
		:set preType [:pick $mVer $mPos ([:len $mVer])];
		:set mVer [:pick $mVer 0 $mPos];
		:set found 1;
	}
}

:set mPos [:find $mVer "."];
:if ([:typeof $mPos] = "num") do={
	:set major [:tonum [:pick $mVer 0 $mPos]];
	:set mVer [:pick $mVer ($mPos + 1) [:len $mVer]];
	
	:set mPos [:find $mVer "."];
	:if ([:typeof $mPos] = "num") do={
		:set minor [:tonum [:pick $mVer 0 $mPos]];
		:set mVer [:pick $mVer ($mPos + 1) [:len $mVer]];
		
		:if ([:len $mVer] > 0) do={
			:set patch [:tonum $mVer];
		}
	} else={
		:if ([:len $mVer] > 0) do={
			:set minor [:tonum $mVer];
		}
	}
}


:put ("Full: ".$input);
:put ("Remain: ".$mVer);
:put ("major: ".$major);
:put ("minor: ".$minor);
:put ("patch: ".$patch);
:put ("pre: ".$preType);




#:if ([($MtmFacts->"getEnv") "minor"] > 0) do={
#	:set mVal [($MtmFacts->"setEnv") "patch" [:tonum [:pick $mVer 0 $mPos]]];
#} else={
#	:set mVal [($MtmFacts->"setEnv") "minor" [:tonum [:pick $mVer 0 $mPos]]];
#}