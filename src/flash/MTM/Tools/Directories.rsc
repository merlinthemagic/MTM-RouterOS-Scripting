:local classId "tool-directories";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmT2;
:if (($MtmT2->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"create") do={
	
		:global MtmFacts;
		:local method "Tools->Directories->create";
		:local param1;
		:if ($0 != nil) do={
			:set param1 $0;
		} else={
			:if ($path != nil) do={
				:set param1 $path;
			} else={
				[($MtmFacts->"throwException") method=$method msg="Directory path is mandatory"];
			}
		}
		[($MtmFacts->"throwException") method=$method msg="Not ready"];
		
		#get self
		:global MtmT2;
		:local self ($MtmT2->"tool-directories");
		:if (([($self->"exists") path=$param1]) = false) do={
			#needs to be created, file system can be a bit slow to report at times
			## TODO: make sure ends in /
			
			##src: https://forum.mikrotik.com/viewtopic.php?t=169738
			/tool fetch address=127.0.0.1 port=443 mode=https src-path="NotExist" dst-path=$path duration=1;
			
			#wait for the file to be created
			[($self->"waitForExists") $param1 true 1500];
		}
		#dont return anything yet, might wanna return a file object at some point
		:return 0;
	}
	
	:set ($MtmT2->$classId) $s;
}
