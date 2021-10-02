:local classId "tool-files";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmT2;
:if (($MtmT2->$classId) = nil) do={
	
	:local s [:toarray ""];
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
		:global MtmT2;
		:local self ($MtmT2->"tool-files");
		
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
		
		:global MtmT2;
		:local self ($MtmT2->"tool-files");
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
		} else={
			:return false;
		}
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
		#get self
		:global MtmT2;
		:local self ($MtmT2->"tool-files");
		:if (([($self->"exists") path=$param1]) = false) do={
			#needs to be created, file system can be a bit slow to report at times
			/file print file=$param1;
			#wait for the file to be created
			[($self->"waitForExists") $param1 true 1500];
		}
		#dont return anything yet, might wanna return a file object at some point
		:return 0;
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
		#get self
		:global MtmT2;
		:local self ($MtmT2->"tool-files");
		:if (([($self->"exists") path=$param1]) = true) do={
			#needs to be deleted, file system can be a bit slow to report at times
			/file remove $param1;
			#wait for the file to be deleted
			[($self->"waitForExists") $param1 false 1500];
		}
		#dont return anything yet
		:return 0;
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
		#get self
		:global MtmT2;
		:local self ($MtmT2->"tool-files");
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

		} else={
			:return [/file get [find where name=$param1] content];
		}
	}
	:set ($s->"setContent") do={
	
		:global MtmFacts;
		:local method "Tools->Files->setContent";
		:local param1;
		:local param2;
		:if ($0 != nil) do={
			:set param1 $0;
			:if ($1 != nil) do={
				:set param2 $1;
			}
		} else={
			:if ($path != nil) do={
				:set param1 $path;
				:if ($content != nil) do={
					:set param2 $content;
				}
			} else={
				[($MtmFacts->"throwException") method=$method msg="File path is mandatory"];
			}
		}
		:if ($param2 = nil) do={
			:set param2 "";
		}
		
		#get self
		:global MtmT2;
		:local self ($MtmT2->"tool-files");
		:if (([($self->"exists") path=$param1]) = false) do={
			[($self->"create") path=$param1]; #needs to be created first
		}
		:local newSize [:len $param2];
		:local curSize [($self->"getSize") path=$param1];
		:if ($newSize = 0 && $curSize = 0) do={
			#nothing to do here
			:return [($MtmFacts->"getNull")];
		}
		
		/file set [find where name=$param1] content=$param2;
		
		#wait for the right size
		[($self->"waitForSize") $param1 $newSize 1600];
		:return 0;
	}
	:set ($s->"getSize") do={
	
		:global MtmFacts;
		:local method "Tools->Files->getSize";
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
		#get self
		:global MtmT2;
		:local self ($MtmT2->"tool-files");
		:if (([($self->"exists") path=$param1]) = false) do={
			[($MtmFacts->"throwException") method=$method msg=("File does not exist: '$param1'")];
		}
		:return [/file get [find where name=$param1] size];
	}
	:set ($s->"waitForSize") do={
	
		# MT i/o is slow to update, this function helps us wait until an update is complete
		:global MtmFacts;
		:local method "Tools->Files->waitForSize";
		:local param1; #path
		:local param2; #byte count
		:local param3; #timeout milisecs
		:if ($0 != nil) do={
			:set param1 $0;
			:set param2 $1;
			:set param3 $2;
		} else={
			[($MtmFacts->"throwException") method=$method msg="File path is mandatory"];
		}
		
		:global MtmT2;
		:local self ($MtmT2->"tool-files");
		:local size;
		:while ($param3 > 0) do={
			:set size [($self->"getSize") path=$param1];
			:if ($size = $param2) do={
				:set param3 0;
			} else={
				:set param3 ($param3 - 100);
				:if ($param3 < 1) do={
					[($MtmFacts->"throwException") method=$method msg=("File : '$param1', did not meet the requested size: '$param2', current size: '$size'")];
				} else={
					:delay 0.1;
				}
			}
		}
		:return 0;
	}
	:set ($s->"waitForExists") do={
	
		# MT i/o is slow to update, this function helps us wait until a create / delete is done
		:global MtmFacts;
		:local method "Tools->Files->waitForExists";
		:local param1; #path
		:local param2; #bool
		:local param3; #timeout milisecs
		:if ($0 != nil) do={
			:set param1 $0;
			:set param2 [:tostr $1]; #:tobool does not work, so we have to compare strings https://forum.mikrotik.com/viewtopic.php?t=149315
			:set param3 $2;
		} else={
			[($MtmFacts->"throwException") method=$method msg="File path is mandatory"];
		}
		:global MtmT2;
		:local self ($MtmT2->"tool-files");
		:local exists;
		:while ($param3 > 0) do={
			:set exists [($self->"exists") path=$param1];
			:if ([:tostr $exists] = $param2) do={
				:set param3 0;
			} else={
				:set param3 ($param3 - 100);
				:if ($param3 < 1) do={
					[($MtmFacts->"throwException") method=$method msg=("File: '".$param1."', did not meet the requested exists status: '$param2', current status: '$exists'")];
				} else={
					:delay 0.1s;
				}
			}
		}
		:return 0;
	}
	:set ($s->"waitForStableSize") do={
	
		# MT i/o is slow to update, this function helps us wait until a file is done being written to
		:global MtmFacts;
		:local method "Tools->Files->waitForStableSize";
		:local param1; #path
		:local param2 8; #minimum 100ms ticks of not changing size
		:local param3 5000; #timeout milisecs
		:if ($0 != nil) do={
			:set param1 $0;
		} else={
			[($MtmFacts->"throwException") method=$method msg="File path is mandatory"];
		}
		:if ($1 != nil) do={
			:set param2 $1;
		}
		:if ($2 != nil) do={
			:set param3 $2;
		}
		
		:local lastSize;
		:local curSize 0;
		:local stableCount 0;
		:global MtmT2;
		:local self ($MtmT2->"tool-files");
		:local isDone false;
		:while ($isDone = false) do={
			:set param3 ($param3 - 100);
			:if ($param3 < 1) do={
				[($MtmFacts->"throwException") method=$method msg=("File : '$param1', did not meet the requested stable count: '$param2'")];
			} else={
				:delay 0.1s;
			}
			:set curSize [($toolObj->"getSize") path=$param1];
			:if ($curSize = $lastSize) do={
				:set stableCount ($stableCount + 1);
				:if ($stableCount = $param2) do={
					:set isDone true;
				}
			} else={
				:set stableCount 0;
				:set lastSize $curSize;
			}
		}
		:return 0;
	}
	:set ($s->"join") do={
	
		#allows you to create large files/scripts from multiple 4095 byte chunks
		#for now each chunk has an extra "\r\n" after it, caused by the use of :put ()
		:global MtmFacts;
		:local method "Tools->Files->join";
		:local param1; #array of input files
		:local param2; #output file
		:if ($0 != nil) do={
			:set param1 $0;
			:set param2 $1;
		} else={
			[($MtmFacts->"throwException") method=$method msg="Input file paths is mandatory"];
		}

		#https://forum.mikrotik.com/viewtopic.php?t=127093
		:local toolObj [($MtmFacts->"execute") nsStr="getTools()->getFiles()"];
		:local counter 0;
		:local sumSize 0;
		:local content [:toarray ""];
		:foreach path in=$param1 do={
			:set ($content->$counter) ([($toolObj->"getContent") path=$path]);
			:set counter ($counter + 1);
			:set sumSize ($sumSize + 2 + ([($toolObj->"getSize") path=$path]));
		}
		:set ($MtmFacts->"getMtmTempGlob") $content;
		:local script ":global MtmFacts; :foreach c in=[(\$MtmFacts->\"getMtmTempGlob\")] do={ :put (\$c) }";
		[:execute script=$script file=$param2];
		
		
		#wait for the right size
		[($toolObj->"waitForSize") $param2 $sumSize 1500];

		#dont return anything yet, might wanna return a file object at some point
		:return 0;
	}
	:set ($MtmT2->$classId) $s;
}
