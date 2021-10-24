:set ($s->"scanOnce") do={

	:global MtmFacts;
	:local method "Tools->Interfaces->Wireless->scanOnce";
	:local param1;
	:if ($0 != nil) do={
		:set param1 $0;
	} else={
		[($MtmFacts->"throwException") method=$method msg="Interface name is mandatory"];
	}
	:local fileTool [($MtmFacts->"execute") nsStr="getTools()->getFiles()"];
	:local tmpFile [($MtmFacts->"getMtmTempFile") true];
	:local nullFile [($MtmFacts->"getMtmNullFile")];
	
	:local params [:toarray ""];
	:set ($params->"error") "";
	:set ($params->"isDone") 0;
	:set ($params->"outFile") $tmpFile;
	:set ($params->"ifName") $param1;
	
	[($MtmFacts->"setMtmTempVar") $params];
	
	:local scr (":global MtmFacts;\r\n");
	:set scr ($scr.":local params [(\$MtmFacts->\"getMtmTempVar\")];\r\n");
	:set scr ($scr.":do {\r\n");
	:set scr ($scr.":local outFile (\$params->\"outFile\");\r\n");
	:set scr ($scr.":local ifname (\$params->\"ifName\");\r\n");
	:set scr ($scr."/interface wireless scan [ find where name=\$ifname ] background=yes rounds=1 passive=yes save-file=\$outFile;\r\n");
	:set scr ($scr."} on-error={\r\n");
	:set scr ($scr.":set (\$params->\"error\") \"Scan failed\";\r\n");
	:set scr ($scr."}\r\n");
	:set scr ($scr.":set (\$params->\"isDone\") 1;\r\n");
	:set scr ($scr.":error \"\";\r\n");
	
	#trigger the script
	:local exeRes [:execute script=$scr file=$nullFile];
	
	:local tCount 150;
	:while ($tCount > 0) do={
		:set tCount ($tCount - 1);
		:if ($tCount = 0) do={
			##TODO: make check for interface being in initializing state.
			## if this is the case a scan cannot run and will stall
			[($MtmFacts->"throwException") method=$method msg=("Scan process failed to complete for interface: '".$param1."'")];
		} else={
			:delay 0.25s;
		}
		:if (($params->"isDone") = 1) do={
			:if (($params->"error") = "") do={
				:set tCount 0;
			} else={
				[($MtmFacts->"throwException") method=$method msg=("Scan process for interface: '".$param1."', retured error: '".($params->"error")."'")];
			}
		}
	}
	
	#wait for the file size to settle
	[($fileTool->"waitForStableSize") $tmpFile];
	:local mData [($fileTool->"getContent") $tmpFile];

	:local parseTool [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getWlanScan()"];
	:return [($parseTool->"getV1") $mData];
}