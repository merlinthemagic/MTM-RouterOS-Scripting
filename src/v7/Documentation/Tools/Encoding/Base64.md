#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local toolObj [($MtmFacts->"get") "getTools()->getEncoding()->getBase64()"];
```

## Methods:

### encode:

```
:local myStr "My string i want to encode";
:put ([($toolObj->"encode") $myStr]); #TXkgc3RyaW5nIGkgd2FudCB0byBlbmNvZGU=
```

### decode:

```
:local myBase64 "TXkgc3RyaW5nIGkgd2FudCB0byBlbmNvZGU=";
:put ([($toolObj->"decode") $myBase64]); #My string i want to encode
```


##Test:

```

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

```
