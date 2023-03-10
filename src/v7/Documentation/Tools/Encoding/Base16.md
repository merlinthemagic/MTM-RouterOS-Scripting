#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local toolObj [($MtmFacts->"get") "getTools()->getEncoding()->getBase16()"];
```

## Methods:

### encode:

```
:local myStr "My string";
:put ([($toolObj->"encode") $myStr]); #4D7920737472696E67
```

### decode:

```
:local myHex "4D7920737472696E67";
:put ([($toolObj->"decode") $myHex]); #My string
```


##Test:

```

:local input "My string i want to encode";

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

```