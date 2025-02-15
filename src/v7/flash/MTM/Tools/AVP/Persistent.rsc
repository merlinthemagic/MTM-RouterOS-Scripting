:local cPath "MTM/Tools/AVP/Persistent.rsc";

:global MtmAvpPersist;
:if ([:typeof $MtmAvpPersist] = "nothing") do={
	
	:global MtmFacts;
	
	:local mVal "";
	:local mVals [:toarray ""];
	:set mVal [($MtmFacts->"getEnv") "mtm.root.path"];
	:local dirTool [($MtmFacts->"get") "getTools()->getFileSystem()->getDirectories()"];
	:local dirPath ($mVal."/AVPs/Persist");
	:set mVal [($dirTool->"create") $dirPath (false)];
	:set mVals [($dirTool->"list") $dirPath];
	
	:local avps [:toarray ""];
	:if ([:len $mVals] > 0) do={
		:local fileTool [($MtmFacts->"get") "getTools()->getFileSystem()->getFiles()"];
		:local strTool [($MtmFacts->"get") "getTools()->getTypes()->getStrings()"];
		:local rObj [:toarray ""];
		:local mPos 0;
		:local mAttr "";
		:foreach item in=$mVals do={
			:if (($item->"name") ~ "^avps") do={
				:set mVal [($fileTool->"getContent") ($dirPath."/".($item->"name"))];
				:set mVal [($strTool->"split") $mVal ("\n")];
				:foreach avp in=$mVal do={
					:if ([:len $avp] > 0) do={
						:set mPos [:find $avp "="];
						:if ([:typeof $mPos] = "num") do={
	
							:set rObj [:toarray ""];
							:set ($rObj->"val") [:pick $avp ($mPos + 1) [:len $avp]];
							:set ($rObj->"file") ($item->"name");	

							:set mAttr [:pick $avp 0 $mPos];
							:set ($avps->$mAttr) $rObj;
						}
					}
				}
			}
		}
	}
	:set MtmAvpPersist $avps;
}

:local s [:toarray ""];

:set ($s->"get") do={

	:local cPath "MTM/Tools/AVP/Persistent.rsc/get";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input attribute must be string, but has invalid type '".[:typeof $0]."'");
	}
	:local mThrow false;
	:if ([:typeof $1] != "nothing") do={
		:if ([:typeof $1] = "bool") do={
			:set mThrow $1;
		} else={
			:error ($cPath.": Throw on not set must be boolean, but has invalid type '".[:typeof $1]."'");
		}
	}
	:global MtmAvpPersist;
	
	
	
	
	:if ([:typeof ($MtmAvpPersist->$0)] != "nothing") do={
		:return ($MtmAvpPersist->$0->"val");
	} else={
		
		
	
		:if ($mThrow = true) do={
			:error ($cPath.": Attribute: '".$0."' does not exist");
		} else={
			:return nil;
		}
	}
}
:set ($s->"set") do={

	:local cPath "MTM/Tools/AVP/Persistent.rsc/set";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input attribute must be string, but has invalid type '".[:typeof $0]."'");
	}
	:if ([:typeof $1] != "str" && [:typeof $1] != "num") do={
		:error ($cPath.": Input value must be string or number, but has invalid type '".[:typeof $1]."'");
	}
	
	:global MtmAvpPersist;
	:if ([:typeof ($MtmAvpPersist->$0)] != "nothing") do={
		:if (($MtmAvpPersist->$0) = $1) do={
			##no change in value
			:return true;
		}
	}
	
	
	
	:global MtmFacts;
	
	:local mAttr $0;
	:local mVal $1;
	:local lockHold "10";
	:local lockWait "2";
	:local procName "setAvpPersist";
	:local key [($MtmFacts->"lock") $procName $lockHold $lockWait];
	

}

:global MtmToolAvps1;
:set ($MtmToolAvps1->"persist") $s;