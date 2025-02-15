:local cPath "MTM/Tools/FS/Directories.rsc";
:local s [:toarray ""];

:set ($s->"getExists") do={

	:global MtmFacts;
	:local cPath "MTM/Tools/FS/Directories.rsc/getExists";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
	}
	:if ([:typeof $1] = "num") do={
		##wait $1 miliseconds. Allow the directory to be created. MT file I/O is quite slow
		:local tTime $1;
		:while ($tTime > 0) do={
			:if ([:len [/file find where name=$0]] > 0) do={
				:set tTime 0;
			} else={
				:set tTime ($tTime - 100);
				:delay 0.1s;
			}
		}
	}
	:if ([:len [/file find where name=$0]] > 0) do={
		:if ([/file/get [find where name=$0] type] = "directory") do={
			:return true;
		} else={
			:error ($cPath.": Exists, but not a directory. '".$0."' is a '".[/file/get [find where name=$0] type]."'");
		}
	} else={
		:return false;
	}
}
:set ($s->"create") do={

	:global MtmFacts;
	:local cPath "MTM/Tools/FS/Directories.rsc/create";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
	}
	
	:local doThrow true;
	:if (([:typeof $1] = "bool" && $1 = false) || ([:typeof $1] = "str" && $1 = "false")) do={
		:set doThrow false;
	}

	:local mVal "";
	
	:global MtmToolFs1;
	:local self ($MtmToolFs1->"dirs");
	
	:if ([($self->"getExists") $0] = false) do={
	
		:local plFile ($0."/mtmPl.txt"); ##place holder, need to trim trailing / is exists
		:do {
			:set mVal [/tool fetch dst-path=$plFile url="https://127.0.0.1/" duration=0.01 check-certificate=no];
		} on-error={
			##do nothing, needs to fail
		}
		#wait for the directory to be created
		:if ([($self->"getExists") $0 [:tonum 1500]] = false) do={
			:error ($cPath.": Failed to create directory: '".$0."'");
		}
		:if ([:len [/file/find where name=$plFile]] > 0) do={
			:set mVal [/file/remove [find where name=$plFile]];
		}
	} else={
		:if ($doThrow = true) do={
			:error ($cPath.": Cannot create, directory exists '".$0."'");
		}
	}
	:return true;
}
:set ($s->"list") do={

	:global MtmFacts;
	:local cPath "MTM/Tools/FS/Directories.rsc/list";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
	}
	:global MtmToolFs1;
	:local self ($MtmToolFs1->"dirs");
	
	:if ([($self->"getExists") $0] = true) do={
		
		:local rObjs [:toarray ""];
		:local rObj [:toarray ""];
		:local mPos ([:len $0] + 1);
		:local mVal "";
		:foreach id in=[/file/find where name~"^$0"] do={
			:set mVal [/file/get $id name];
			:set mVal [:pick $mVal $mPos [:len $mVal]];
			:if ([:typeof [:find $mVal "/"]] != "num" && [:len $mVal] > 0) do={
				:set rObj [:toarray ""];
				:set ($rObj->"name") $mVal;
				:set ($rObj->"type") [/file/get $id type];
				:set ($rObjs->([:len $rObjs])) $rObj;
			}
		}
		:return $rObjs;
		
	} else={
		:error ($cPath.": Cannot list, directory does not exist '".$0."'");
	}
}


:global MtmToolFs1;
:set ($MtmToolFs1->"dirs") $s;
