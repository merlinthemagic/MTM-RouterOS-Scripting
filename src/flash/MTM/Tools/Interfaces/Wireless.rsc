:local classId "tool-ifs-wlan";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:if (($MtmFacts->"c"->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getRegistrations") do={

		:global MtmFacts;
		:local attrs;
		:if ($0 = nil) do={
			:local self [($MtmFacts->"execute") nsStr="getTools()->getInterfaces()->getWireless()"];
			:set attrs [($self->"getRegistrationProperties")];
		} else={
			:set attrs $0;
		}
	
		:local strTool [($MtmFacts->"execute") nsStr="getTools()->getStrings()"];
		:local dateTool [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getDateTime()"];
		:local rObjs [:toarray ""];
		:local rObj [:toarray ""];
		:local count 0;
		:local val;
		:local tmp;
		:foreach id in=[/interface wireless registration-table find] do={
			:set rObj [:toarray ""];
			:foreach attr in=$attrs do={
				:set val [/interface wireless registration-table get $id $attr];
				:if ($attr = "uptime") do={
					:set val [($dateTool->"toSeconds") $val];
				}
				:if ($attr = "last-activity") do={
					#TODO: make function that can parse to ms for this format "00:00:12.770"
					#:set val [($dateTool->"toSeconds") $val];
				}
				
				:if ($attr = "hw-frames" || $attr = "frames" || $attr = "bytes" || $attr = "packets" || $attr = "frame-bytes" || $attr = "hw-frame-bytes") do={
					:set tmp [($strTool->"split") $val ","];
					:set val [:toarray ""];
					:set ($val->"tx") ($tmp->0);
					:set ($val->"rx") ($tmp->1);
				}
				:set ($rObj->$attr) $val;
			}
			:set ($rObjs->$count) $rObj;
			:set count ($count + 1);
		}
		:return $rObjs;
	}
	:set ($s->"getRegistrationProperties") do={

		:global MtmFacts;
		:local method "Tools->Interfaces->Wireless->getRegistrationProperties";

		:local rData [:toarray ""];
		:local i 0;
		:foreach prop,val in=[/interface wireless registration-table get 0 ] do={
			:if ($prop != ".id") do={
				:set ($rData->$i) $prop;
				:set i ($i + 1);
			}
		}

		:return $rData;
	}
	:set ($s->"monitorOnce") do={

		:global MtmFacts;
		:local method "Tools->Interfaces->Wireless->monitorOnce";
		:local param1;
		:if ($0 != nil) do={
			:set param1 $0;
		} else={
			:if ($name != nil) do={
				:set param1 $name;
			} else={
				[($MtmFacts->"throwException") method=$method msg="Interface name is mandatory"];
			}
		}
		:local fileTool [($MtmFacts->"execute") nsStr="getTools()->getFiles()"];
		:local tmpFile [($MtmFacts->"getMtmTempFile") true];
		
		/interface wireless monitor [find where name=$param1] once without-paging file=$tmpFile;
		:local mData [($fileTool->"getContent") $tmpFile];
		:local nsStr "getTools()->getParsing()->getMonitorData()->getV1(data='$mData')";
		:return [($MtmFacts->"execute") nsStr=$nsStr];
	}
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
	:set ($MtmFacts->"c"->$classId) $s;
}