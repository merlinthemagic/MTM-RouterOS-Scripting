:local cPath "MTM/Tools/FS/Files.rsc";
:local s [:toarray ""];

:set ($s->"getExists") do={

	:global MtmFacts;
	:local cPath "MTM/Tools/FS/Files.rsc/getExists";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
	}
	:if ([:typeof $1] = "num") do={
		##wait $1 miliseconds. Allow the file to be created. MT file I/O is quite slow
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
		:return true;
	} else={
		:return false;
	}
}
:set ($s->"getTemp") do={

	:global MtmFacts;
	:local cPath "MTM/Tools/FS/Files.rsc/getTemp";
	
	:local strTool [($MtmFacts->"get") "getTools()->getTypes()->getStrings()"];
	
	:global MtmToolFs1;
	:local self ($MtmToolFs1->"files");
	
	:local isDone false;
	:local max 50;
	:local cur 0;
	:local fileName "";
	:local mVal "";
	:local key [($MtmFacts->"lock") "makeTmpFile" 10 12];
	
	:while ($isDone = false) do={
		
		:if ($cur > $max) do={
			:set mVal [($toolObj->"unlock") "makeTmpFile" $key];
			:error ($cPath.": Failed to create unique new temp file. Too many attempts");
		}
		:set fileName ([($strTool->"getRandom") [:tonum 12]].".txt");
		:if ([($self->"getExists") $fileName] = false) do={
			:do {
				:set mVal [($self->"create") $fileName];
			} on-error={
				:set mVal [($toolObj->"unlock") "makeTmpFile" $key];
				:error ($cPath.": Failed to create unique new temp file. Create returned error");
			}
			:set isDone true;
		}
		:set cur ($cur + 1);
	}
	:set mVal [($toolObj->"unlock") "makeTmpFile" $key];
	:return $fileName;
}
:set ($s->"create") do={

	:global MtmFacts;
	:local cPath "MTM/Tools/FS/Files.rsc/create";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
	}
	:local mVal "";
	
	:global MtmToolFs1;
	:local self ($MtmToolFs1->"files");
	
	:if ([($self->"getExists") $0] = false) do={
		:set mVal [/file print file=$0];
		#wait for the file to be created
		:if ([($self->"getExists") $0 [:tonum 1500]] = false) do={
			:error ($cPath.": Failed to create file: '".$0."'");
		}
		##empty the new file
		:set mVal [($self->"setContent") $0 ""];
	} else={
		:error ($cPath.": Cannot create, file exists '".$0."'");
	}
	:return true;
}
:set ($s->"delete") do={

	:global MtmFacts;
	:local cPath "MTM/Tools/FS/Files.rsc/delete";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
	}
	:local mVal "";
	
	:global MtmToolFs1;
	:local self ($MtmToolFs1->"files");
	
	:if ([($self->"getExists") $0] = true) do={
		:set mVal [/file remove $0];
		:local tTime 1500;
		:while ($tTime > 0) do={
			:if ([($self->"getExists") $0] = false) do={
				:set tTime 0;
			} else={
				:set tTime ($tTime - 100);
				:if ($tTime > 0) do={
					:delay 0.1s;
				} else={
					:error ($cPath.": Failed to delete file '".$0."'");
				}
			}
		}
		#wait for the file to be created
		:if ([($self->"getExists") $0 [:tonum 1500]] = true) do={
			:error ($cPath.": Failed to create file: '".$0."'");
		}
		
	} else={
		:error ($cPath.": Cannot delete, file does not exists '".$0."'");
	}
	:return true;
}
:set ($s->"setContent") do={

	:global MtmFacts;
	:local cPath "MTM/Tools/FS/Files.rsc/setContent";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input file name has invalid type '".[:typeof $0]."'");
	}
	:if ([:typeof $1] != "str") do={
		:error ($cPath.": Input content has invalid type '".[:typeof $1]."'");
	}
	:local mVal "";

	:global MtmToolFs1;
	:local self ($MtmToolFs1->"files");

	:if ([($self->"getExists") $0] = false) do={
		:set mVal [($self->"create") $0];
	}
	:local newSize [:len $1];
	:local curSize [($self->"getSize") $0];
	:if ($newSize != 0 || $curSize != 0) do={
		:set mVal [/file set [find where name=$0] content=$1];
		:if ([($self->"isSize") $0 $newSize [:tonum 1500]] = false) do={
			:error ($cPath.": Failed to set content. Size mismatch for file '".$0."'");
		}
	}
	:return true;
}
:set ($s->"getContent") do={

	:global MtmFacts;
	:local cPath "MTM/Tools/FS/Files.rsc/getContent";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input file name has invalid type '".[:typeof $0]."'");
	}

	:local mVal "";
	
	:global MtmToolFs1;
	:local self ($MtmToolFs1->"files");

	:if ([($self->"getExists") $0] = false) do={
		:error ($cPath.": Cannot get content, file does not exists '".$0."'");
	}
	:if ([($self->"getSize") $0] < 4096) do={
		:return [/file get [find where name=$0] content];
	} else={
		:error ($cPath.": Cannot get content, file is too large '".$0."'");
		#:local rObj [($self->"getFetchUser")];
		#:if ($rObj = false) do={
		#	[($MtmFacts->"throwException") method=$method msg=("File exceeds the 4095 byte limit: '$param1', it is: '$size' bytes. Set Fetch user to overcome")];
		#} else={
		#	#large file lets see if we have a way to download it via fetch
		#	:local fetchTool [($MtmFacts->"execute") nsStr="getTools()->getFetch()->getDownload()"];
		#	:if (($rObj->"service") = "ftp") do={
		#		:return ([($fetchTool->"ftpAsVariable") $param1 ($rObj->"address") ($rObj->"user") ($rObj->"pass") ($rObj->"port")])
		#	} else={
		#		[($MtmFacts->"throwException") method=$method msg=("Fetch not handled for service: ".($rObj->"service"))];
		#	}
		#}
	}
}
:set ($s->"getSize") do={

	:global MtmFacts;
	:local cPath "MTM/Tools/FS/Files.rsc/getSize";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input file name has invalid type '".[:typeof $0]."'");
	}
	:local mVal "";
	
	:global MtmToolFs1;
	:local self ($MtmToolFs1->"files");
	
	:if ([($self->"getExists") $0] = false) do={
		:error ($cPath.": File does not exist: '".$0."'");
	}
	:return [:tonum [/file get [find where name=$0] size]];
}
:set ($s->"isSize") do={

	:global MtmFacts;
	:local cPath "MTM/Tools/FS/Files.rsc/isSize";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input file name has invalid type '".[:typeof $0]."'");
	}
	:if ([:typeof $1] != "num") do={
		:error ($cPath.": Input file size has invalid type '".[:typeof $1]."'");
	}
	:if ([:typeof $2] = "num") do={
		##wait $2 miliseconds. Allow the file to reach the right size. MT file I/O is quite slow
		:local tTime $2;
		:while ($tTime > 0) do={
			:if ([:tonum [/file get [find where name=$0] size]] = $1) do={
				:set tTime 0;
			} else={
				:set tTime ($tTime - 100);
				:delay 0.1s;
			}
		}
	}
	:if ([:tonum [/file get [find where name=$0] size]] = $1) do={
		:return true;
	} else={
		:return false;
	}
}
:global MtmToolFs1;
:set ($MtmToolFs1->"files") $s;
