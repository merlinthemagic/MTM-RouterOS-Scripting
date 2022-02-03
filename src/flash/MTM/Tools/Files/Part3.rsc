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
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
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
	:return false;
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