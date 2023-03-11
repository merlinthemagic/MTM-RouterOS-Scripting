:global MtmFacts;
#:set MtmFacts;

/import flash/MTM/Facts.rsc;
:global MtmFacts;

[($MtmFacts->"setDebug") true];

##remove specific tool from cache
#:local sysId "tool-time-epoch";
#:local objFact [($MtmFacts->"getObjects")];
#:local sObj [($objFact->"getStore") $sysId];
#:set ($sObj->"obj"->($sObj->"hash"));

#:local result [($MtmFacts->"get") "getTools()->getTime()->getEpoch()->getCurrent()"];
#:put ("Current Epoch: ".$result); #epoch time



:local input ":local v1 [\$chr2int [:pick \$input 0 1] \$charsString]";

:local toolObj [($MtmFacts->"get") "getTools()->getEncoding()->getBase16()"];
:local orig $input;
:local output ""; 
:put ("Original is: '".$orig."', type: '".[:typeof $orig]."', length: '".[:len $orig]."'");

:set output [($toolObj->"encode") $input];
:put ("Base64 is: '".$output."'");

:set output [($toolObj->"decode") $output];
:put ("Decoded is : '".$output."', type: '".[:typeof $output]."', length: '".[:len $output]."'");

:if ($orig = $output) do={
	:put ("It is a match");
} else={
	:put ("It is NOT a match");
}