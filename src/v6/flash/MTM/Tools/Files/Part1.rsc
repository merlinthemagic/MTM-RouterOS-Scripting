:set ($s->"setFetchUser") do={
		
	#user allowed to get large files via some service
	:global MtmFacts;
	:local method "Tools->Files->setFetchUser";

	:if ($0 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Username is mandatory"];
	}
	:if ($1 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Password is mandatory"];
	}
	:if ($2 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Service address is mandatory"];
	}
	:if ($3 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Service name is mandatory"];
	}
	:if ($4 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Service port is mandatory"];
	}
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local sObj [:toarray ""];
	:set ($sObj->"user") $0;
	:set ($sObj->"pass") $1;
	:set ($sObj->"address") $2;
	:set ($sObj->"service") $3;
	:set ($sObj->"port") $4;
	:set ($self->"fetchUser") $sObj;
	:return $sObj;
}
:set ($s->"getFetchUser") do={
	
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:if (($self->"fetchUser") = nil) do={
		:return false;
	} else={
		:return ($self->"fetchUser");
	}
}
:set ($s->"exists") do={

	:global MtmFacts;
	:local method "Tools->Files->exists";
	:local param1;
	:if ($0 != nil) do={
		:set param1 $0;
	} else={
		:if ($path != nil) do={
			:set param1 $path;
		} else={
			[($MtmFacts->"throwException") method=$method msg="File path is mandatory"];
		}
	}
	
	:if ([:len [/file find where name=$param1]] > 0) do={
		:return true;
	}
	:return false;
}
:set ($s->"create") do={

	:global MtmFacts;
	:local method "Tools->Files->create";
	:local param1;
	:if ($0 != nil) do={
		:set param1 $0;
	} else={
		:if ($path != nil) do={
			:set param1 $path;
		} else={
			[($MtmFacts->"throwException") method=$method msg="File path is mandatory"];
		}
	}
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:if (([($self->"exists") path=$param1]) = false) do={
		#needs to be created, file system can be a bit slow to report at times
		/file print file=$param1;
		#wait for the file to be created
		[($self->"waitForExists") $param1 true 1500];
	}
	#dont return anything yet, might wanna return a file object at some point
	:return false;
}
:set ($s->"delete") do={

	:global MtmFacts;
	:local method "Tools->Files->delete";
	:local param1;
	:if ($0 != nil) do={
		:set param1 $0;
	} else={
		[($MtmFacts->"throwException") method=$method msg="File path is mandatory"];
	}
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:if (([($self->"exists") path=$param1]) = true) do={
		#needs to be deleted, file system can be a bit slow to report at times
		/file remove $param1;
		#wait for the file to be deleted
		[($self->"waitForExists") $param1 false 1500];
	}
	#dont return anything yet
	:return false;
}
:set ($s->"getContent") do={

	:global MtmFacts;
	:local method "Tools->Files->getContent";
	:local param1;
	:if ($0 != nil) do={
		:set param1 $0;
	} else={
		:if ($path != nil) do={
			:set param1 $path;
		} else={
			[($MtmFacts->"throwException") method=$method msg="File path is mandatory"];
		}
	}
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:local size [($self->"getSize") path=$param1];
	:if ($size > 4095) do={
		:local rObj [($self->"getFetchUser")];
		:if ($rObj = false) do={
			[($MtmFacts->"throwException") method=$method msg=("File exceeds the 4095 byte limit: '$param1', it is: '$size' bytes. Set Fetch user to overcome")];
		} else={
			#large file lets see if we have a way to download it via fetch
			:local fetchTool [($MtmFacts->"execute") nsStr="getTools()->getFetch()->getDownload()"];
			:if (($rObj->"service") = "ftp") do={
				:return ([($fetchTool->"ftpAsVariable") $param1 ($rObj->"address") ($rObj->"user") ($rObj->"pass") ($rObj->"port")])
			} else={
				[($MtmFacts->"throwException") method=$method msg=("Fetch not handled for service: ".($rObj->"service"))];
			}
		}

	}
	:return [/file get [find where name=$param1] content];
}