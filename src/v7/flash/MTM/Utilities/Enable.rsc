:local cPath "MTM/Utilities/Enable.rsc";
:local mVal "";

:global MtmUtilitiesLoaded;
:if ($MtmUtilitiesLoaded != true) do={
	:global MtmUtilitiesLoaded false;

	##Load APP
	:local hintFile "mtmUtilitiesRoot.hint";
	:set mVal [/file/find name~$hintFile];
	:if ([:len $mVal] != 1) do={
		:set mVal [/system/script/environment/remove [find where name="mtmUtilitiesLoaded"]];
		:error ($cPath.": Hint file: '".$hintFile."' is invalid");
	}
	:set mVal [/file/get $mVal name];
	:local rootPath [:pick $mVal 0 ([:len $mVal] - (([:len $hintFile]) + 1))];

	##Load the factory class
	:set mVal [/import file-name=($rootPath."/Facts.rsc") verbose=no];

	:global MtmFacts;
	:if ([:typeof $MtmFacts] = "nothing") do={
		:set mVal [/system/script/environment/remove [find where name="MtmUtilitiesLoaded"]];
		:error ($cPath.": Loading MtmFacts failed");
	}

	##start loading in the environment
	:set mVal [($MtmFacts->"setEnv") "mtm.root.path" $rootPath];
	
	##load the environment files
	:foreach id in=[/file/find where name~("^".$rootPath."/Envs/")] do={
		:set mVal [/file/get $id name];
		:set mVal [($MtmFacts->"loadEnvFile") $mVal (true)];
	}

	:global MtmUtilitiesLoaded true;
	
} else={
	#MTM Utilities is already loaded
}