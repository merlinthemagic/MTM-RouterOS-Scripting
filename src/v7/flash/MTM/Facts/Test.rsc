:global MtmFacts;
:set MtmFacts;

/import flash/MTM/Facts.rsc;
:global MtmFacts;

[($MtmFacts->"setDebug") true]

##remove specific tool from cache
#:local sysId "tool-time-epoch";
#:local objFact [($MtmFacts->"getObjects")];
#:local sObj [($objFact->"getStore") $sysId];
#:set ($sObj->"obj"->($sObj->"hash"));

#:local result [($MtmFacts->"get") "getTools()->getTime()->getEpoch()->getCurrent()"];
#:put ("Current Epoch: ".$result); #epoch time


#:local toolObj [($MtmFacts->"get") "getTools()->getEncoding()->getBase16()"];
#:local myStr "My string";
#:put ("MD5 hash is: ".[($toolObj->"encode") $myStr]);


:local input "My string i want to encode";

:local toolObj [($MtmFacts->"get") "getTools()->getEncoding()->getBase64()"];
:local orig $input;
:local output ""; 
:put ("Original is: ".$input);

:set output [($toolObj->"encode") $input];
:put ("Base64 is: ".$output);

:set output [($toolObj->"decode") $output];
:put ("Decoded is : ".$output);

:if ($orig = $output) do={
	:put ("Its a match");
} else={
	:put ("Its NOT a match");
}