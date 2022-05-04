## /import file-name=flash/tests/Tools/JsonDecode/Test.rsc;

/import flash/MTM/Facts.rsc;
:global MtmFacts;

[($MtmFacts->"setDebug") true];

:local sTime [($MtmFacts->"execute") nsStr="getTools()->getTime()->getEpoch()->getCurrent()"];

:local toolObj [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getJsonDecode()"];

:local input "[\"alice\", \"bob\"]";
:local input "{\"authKey\":\"wef\\\"wfbb\",\"srcFile\":\"https://example.com/serial.rsc\",\"dstFile\":\"flash/init.rsc\",\"bingo\":1}";
:local input "{\"users\":[\"alice\", \"bob\"],\"hello\":\"world\",\"bingo\":1}";
:local result [:toarray "num,alice;num,bob"];
:local rData [($toolObj->"getFromString") $input];
:put ($rData);
:foreach index,value in=$rData do={
		:put ("prop->".$index."<-prop");
		:if ([:type $value] = "array") do={
			:foreach cp2,cv2 in=$value do={
				:put ("sub-prop->".$cp2."<-sub-prop");
				:put ("sub-value->".$cv2."<-sub-value");
			}
		} else={
			:put ("value->".$value."<-value");
		}
	}


#:local input "{\"authKey\":\"_E-49brzcZ64eedE\\\"gY+Gs47XGB5#ty2Xc+9yB5yw\",\"srcFile\":\"https://rps-grp.dynamic-data.io/public/serial.rsc\",\"dstFile\":\"flash/init.rsc\",\"bingo\":1}";
#:local input "{\"authKey\":\"_E-49brzcZ64eedEgY+Gs47XGB5#ty2Xc+9yB5yw\",\"srcFile\":\"https://rps-grp.dynamic-data.io/public/serial.rsc\",\"dstFile\":\"flash/init.rsc\",\"bingo\":1}";
#:local input "{\"authKey\":{\"bob\": \"_E-49brzcZ64eedEgY+Gs47XGB5#ty2Xc+9yB5yw\"},\"srcFile\":\"https://rps-grp.dynamic-data.io/public/serial.rsc\",\"dstFile\":\"flash/init.rsc\",\"bingo\":1}";
#:local input "{\"authKey\":{\"bob\": \"_E-49brzcZ64eedEgY+Gs47XGB5#ty2Xc+9yB5yw\", \"dave\": \"Friend\"},\"srcFile\":\"https://rps-grp.dynamic-data.io/public/serial.rsc\",\"dstFile\":\"flash/init.rsc\",\"bingo\":1}";
#:local input "{\"authKey\":[\"alice\", \"bob\"],\"srcFile\":\"https://rps-grp.dynamic-data.io/public/serial.rsc\",\"dstFile\":\"flash/init.rsc\",\"bingo\":1}";





:local eTime [($MtmFacts->"execute") nsStr="getTools()->getTime()->getEpoch()->getCurrent()"];
:put ("Duration: ".$eTime-$sTime);
