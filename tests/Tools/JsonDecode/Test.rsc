## /import file-name=flash/tests/Tools/JsonDecode/Test.rsc;

/import flash/MTM/Facts.rsc;
:global MtmFacts;

[($MtmFacts->"setDebug") true];

:local sTime [($MtmFacts->"execute") nsStr="getTools()->getTime()->getEpoch()->getCurrent()"];

##remove specific tool from cache
:local sysId "tool-parsing-json-dec";
:global MtmSM0;
:if (($MtmSM0->$sysId) != nil) do={
	:set ($MtmSM0->$sysId);
}

:local toolObj [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getJsonDecode()"];

:local tId "";
:local input "";
:local rData "";
:local expect "";
:local result "";

:set tId "simpleArray";
:set input "[\"alice\",\"bob\",7]";
:set rData [($toolObj->"getFromString") $input];
:set expect "array";
:set result [:type $rData];
:if ($expect != $result) do={
	:error ("Error in test ID: '".$tId."', expected: '".$expect."' received: '".$result."'")
}

:set expect 3;
:set result [:len $rData];
:if ($expect != $result) do={
	:error ("Error in test ID: '".$tId."', expected: '".$expect."' received: '".$result."'")
}

:set expect "str";
:set result [:typeof ($rData->0)];
:if ($expect != $result) do={
	:error ("Error in test ID: '".$tId."', expected: '".$expect."' received: '".$result."'")
}

:set expect "str";
:set result [:typeof ($rData->1)];
:if ($expect != $result) do={
	:error ("Error in test ID: '".$tId."', expected: '".$expect."' received: '".$result."'")
}
:set expect "num";
:set result [:typeof ($rData->2)];
:if ($expect != $result) do={
	:error ("Error in test ID: '".$tId."', expected: '".$expect."' received: '".$result."'")
}

#:if ([:len $rData] != 5) do={
#	:error ("Error: Expected array length 2 for test: '".$tId."', received: '".."'")
#}
#:local input "{\"authKey\":\"wef\\\"wfbb\",\"srcFile\":\"https://example.com/serial.rsc\",\"dstFile\":\"flash/init.rsc\",\"bingo\":1}";
#:local input "{\"users\":[\"alice\", \"bob\"],\"hello\":\"world\",\"bingo\":1}";
#:local result [:toarray "num,alice;num,bob"];

#:put ($rData);
#:foreach index,value in=$rData do={
#		:put ("prop->".$index."<-prop");
#		:if ([:type $value] = "array") do={
##			:foreach cp2,cv2 in=$value do={
#				:put ("sub-prop->".$cp2."<-sub-prop");
#				:put ("sub-value->".$cv2."<-sub-value");
#			}
#		} else={
#			:put ("value->".$value."<-value");
#		}
#	}


#:local input "{\"authKey\":\"_E-49brzcZ64eedE\\\"gY+Gs47XGB5#ty2Xc+9yB5yw\",\"srcFile\":\"https://rps-grp.dynamic-data.io/public/serial.rsc\",\"dstFile\":\"flash/init.rsc\",\"bingo\":1}";
#:local input "{\"authKey\":\"_E-49brzcZ64eedEgY+Gs47XGB5#ty2Xc+9yB5yw\",\"srcFile\":\"https://rps-grp.dynamic-data.io/public/serial.rsc\",\"dstFile\":\"flash/init.rsc\",\"bingo\":1}";
#:local input "{\"authKey\":{\"bob\": \"_E-49brzcZ64eedEgY+Gs47XGB5#ty2Xc+9yB5yw\"},\"srcFile\":\"https://rps-grp.dynamic-data.io/public/serial.rsc\",\"dstFile\":\"flash/init.rsc\",\"bingo\":1}";
#:local input "{\"authKey\":{\"bob\": \"_E-49brzcZ64eedEgY+Gs47XGB5#ty2Xc+9yB5yw\", \"dave\": \"Friend\"},\"srcFile\":\"https://rps-grp.dynamic-data.io/public/serial.rsc\",\"dstFile\":\"flash/init.rsc\",\"bingo\":1}";
#:local input "{\"authKey\":[\"alice\", \"bob\"],\"srcFile\":\"https://rps-grp.dynamic-data.io/public/serial.rsc\",\"dstFile\":\"flash/init.rsc\",\"bingo\":1}";





:local eTime [($MtmFacts->"execute") nsStr="getTools()->getTime()->getEpoch()->getCurrent()"];
:put ("Duration: ".$eTime-$sTime);
