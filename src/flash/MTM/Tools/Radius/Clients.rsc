:local classId "tool-radius-clients";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:if (($MtmFacts->"c"->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"monitorOnce") do={

		:global MtmFacts;
		:local method "Tools->Radius->Clients->monitorOnce";
		:local param1;
		:if ($0 != nil) do={
			:set param1 $0;
		} else={
			:if ($name != nil) do={
				:set param1 $name;
			} else={
				[($MtmFacts->"throwException") method=$method msg="Radius client id is mandatory"];
			}
		}
		:local fileTool [($MtmFacts->"execute") nsStr="getTools()->getFiles()"];
		:local tmpFile [($MtmFacts->"getMtmTempFile") true];
		
		/radius monitor $param1 once without-paging file=$tmpFile;
		:local mData [($fileTool->"getContent") $tmpFile];
		:local nsStr "getTools()->getParsing()->getMonitorData()->getV1(data='$mData')";
		:return [($MtmFacts->"execute") nsStr=$nsStr];
	}
	:set ($MtmFacts->"c"->$classId) $s;
}
