:set ($s->"infoOnce") do={

	:global MtmFacts;
	:local method "Tools->Interfaces->LTE->infoOnce";
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
	:local rData [:toarray ""];
	
	:do {
		/interface lte info [find where name=$param1] once without-paging file=$tmpFile;
		:local mData [($fileTool->"getContent") $tmpFile];
		:local nsStr "getTools()->getParsing()->getMonitorData()->getV1(data='$mData')";
		:set rData [($MtmFacts->"execute") nsStr=$nsStr];
		:set ($rData->"infoSupported") true;

	} on-error={
		##info not supported
		:set ($rData->"infoSupported") false;
	}
	:return $rData;
}