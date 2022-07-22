:set ($s->"getRegistrations") do={

	:global MtmFacts;
	:local attrs;
	:if ($0 = nil) do={
		:global |MTMS|;
		:local self ($|MTMS|->"|MTMC|");
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