:local cPath "MTM/Enable.rsc";
:global MtmLoaded;
:if ([:typeof $MtmLoaded] = "nothing") do={

	##use the root hint file to locate MTM, that way it can be located anywhere on disk
	:local mVal "";
	:local hintFile "mtmRoot.hint";
	:local rootPath "";
	:set mVal [/file/find name~$hintFile];
	:if ([:len $mVal] = 0) do={
		:error ($cPath.": Hint file: '".$hintFile."' does not exist");
	}
	:set mVal [/file/get $mVal name];
	:set rootPath [:pick $mVal 0 ([:len $mVal] - 13)];

	##Load the factory class
	:set mVal [/import file-name=($rootPath."/Facts.rsc") verbose=no];
	:global MtmFacts;

	##start loading in the environment
	:set mVal [($MtmFacts->"setEnv") "mtm.root.path" $rootPath];
	
	##load the rest from the environment file
	:local envFile ($rootPath."/MtmEnv.env");
	:set mVal [($MtmFacts->"loadEnvFile") $envFile (true)];

	:global MtmLoaded true;
	
} else={
	#MTM is already loaded
}