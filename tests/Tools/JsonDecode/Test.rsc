## /import file-name=flash/tests/Tools/JsonDecode/Test.rsc;

/import flash/MTM/Enable.rsc;
:global MtmFacts;
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
:set expect "alice";
:set result ($rData->0);
:if ($expect != $result) do={
	:error ("Error in test ID: '".$tId."', expected: '".$expect."' received: '".$result."'")
}
:set expect "bob";
:set result ($rData->1);
:if ($expect != $result) do={
	:error ("Error in test ID: '".$tId."', expected: '".$expect."' received: '".$result."'")
}
:set expect 7;
:set result ($rData->2);
:if ($expect != $result) do={
	:error ("Error in test ID: '".$tId."', expected: '".$expect."' received: '".$result."'")
}


:set tId "objectWithNestedArray";
:set input "{\"users\":[\"alice\",\"bob\"],\"count\":199,\"text\":\"helloWorld\"}";
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
:set expect "num";
:set result [:typeof ($rData->"count")];
:if ($expect != $result) do={
	:error ("Error in test ID: '".$tId."', expected: '".$expect."' received: '".$result."'")
}
:set expect 199;
:set result ($rData->"count");
:if ($expect != $result) do={
	:error ("Error in test ID: '".$tId."', expected: '".$expect."' received: '".$result."'")
}
:set expect "str";
:set result [:typeof ($rData->"text")];
:if ($expect != $result) do={
	:error ("Error in test ID: '".$tId."', expected: '".$expect."' received: '".$result."'")
}
:set expect "helloWorld";
:set result ($rData->"text");
:if ($expect != $result) do={
	:error ("Error in test ID: '".$tId."', expected: '".$expect."' received: '".$result."'")
}
:set expect "array";
:set result [:typeof ($rData->"users")];
:if ($expect != $result) do={
	:error ("Error in test ID: '".$tId."', expected: '".$expect."' received: '".$result."'")
}
:set expect 2;
:set result [:len ($rData->"users")];
:if ($expect != $result) do={
	:error ("Error in test ID: '".$tId."', expected: '".$expect."' received: '".$result."'")
}
:set expect "str";
:set result [:typeof ($rData->"users"->0)];
:if ($expect != $result) do={
	:error ("Error in test ID: '".$tId."', expected: '".$expect."' received: '".$result."'")
}
:set expect "str";
:set result [:typeof ($rData->"users"->1)];
:if ($expect != $result) do={
	:error ("Error in test ID: '".$tId."', expected: '".$expect."' received: '".$result."'")
}
:set expect "alice";
:set result ($rData->"users"->0);
:if ($expect != $result) do={
	:error ("Error in test ID: '".$tId."', expected: '".$expect."' received: '".$result."'")
}
:set expect "bob";
:set result ($rData->"users"->1);
:if ($expect != $result) do={
	:error ("Error in test ID: '".$tId."', expected: '".$expect."' received: '".$result."'")
}

:local eTime [($MtmFacts->"execute") nsStr="getTools()->getTime()->getEpoch()->getCurrent()"];
:put ("Success. Duration: ".$eTime-$sTime);