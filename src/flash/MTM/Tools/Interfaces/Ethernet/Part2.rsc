:set ($s->"monitorOnce") do={

	:global MtmFacts;
	:local method "Tools->Interfaces->Ethernet->monitorOnce";
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
	
	/interface ethernet monitor [find where name=$param1] once without-paging file=$tmpFile;
	:local mData [($fileTool->"getContent") $tmpFile];
	
	:local nsStr "getTools()->getParsing()->getMonitorData()->getV1(data='$mData')";
	:return [($MtmFacts->"execute") nsStr=$nsStr];
}
:set ($s->"monitorPoeOnce") do={

	:global MtmFacts;
	:local method "Tools->Interfaces->Ethernet->monitorPoeOnce";
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
	:local tmpFile [($MtmFacts->"getMtmTempFile")];
	:local rData;
	
	/interface ethernet poe monitor [find where name=$param1] once without-paging file=$tmpFile;
	:local nsStr "getTools()->getFiles()->getContent(path='$tmpFile')";
	:local mData [($MtmFacts->"execute") nsStr=$nsStr];
	
	:local nsStr "getTools()->getParsing()->getMonitorData()->getV1(data='$mData')";
	:return [($MtmFacts->"execute") nsStr=$nsStr];
}