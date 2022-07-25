:local cPath "MTM/MtmEnv.rsc";
:global MtmFacts;
:if ($MtmFacts != nil) do={

	:local mVal [($MtmFacts->"getEnv") "mtm.env.loaded" false];
	:if ([:typeof $mVal] = "nil") do={
		:set mVal [($MtmFacts->"setEnv") "mtm.root.path" "flash/MTM"]; ##root path to the MTM files, every file is relative to this path (no trailing / please)
		:set mVal [($MtmFacts->"setEnv") "mtm.debug.enabled" "false"]; ##debugging default value
		
		##remote loading settings, this is where you can enable a device to download 
		:set mVal [($MtmFacts->"setEnv") "mtm.remote.enabled" "true"]; ##allow fetching from remote server
		:set mVal [($MtmFacts->"setEnv") "mtm.remote.host" "https://raw.githubusercontent.com"]; ##fetching from this remote server/fqdn
		:set mVal [($MtmFacts->"setEnv") "mtm.remote.url" "/merlinthemagic/MTM-RouterOS-Scripting/main/src/v7"]; ##path on server to files (no trailing / please)
		:set mVal [($MtmFacts->"setEnv") "mtm.remote.port" ""]; ##remote port
		:set mVal [($MtmFacts->"setEnv") "mtm.remote.user" ""]; ##remote basic auth username
		:set mVal [($MtmFacts->"setEnv") "mtm.remote.pass" ""]; ##remote basic auth password
		
		:set mVal [($MtmFacts->"setEnv") "mtm.remote.save.enabled" "false"]; ##save files to local path so fetching is not needed next time
		:set mVal [($MtmFacts->"setEnv") "mtm.remote.save.path" ""]; ##path on local device to save files. Differs from the root allowing you to save in RAM if wanted files are then only fetched on reboot (no trailing / please)
		
		:set mVal [($MtmFacts->"setEnv") "mtm.env.loaded" "true"];
	}

} else={
	:error ($cPath.": MtmFacts is not loaded");
}
