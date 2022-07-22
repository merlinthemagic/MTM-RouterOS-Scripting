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
	
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
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
	:return false;
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
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
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
	
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
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
	:return false;
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
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
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
	:return false;
}