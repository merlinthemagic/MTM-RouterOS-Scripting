#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local toolObj [($MtmFacts->"get") "getTools()->getTypes()->getStrings()"];
```

## Methods:

### trim:

```
:local myStr " My string with leading and traling spaces and line breaks and chr returns \n\r";
:local result [($toolObj->"trim") $myStr];
:put ($result); #"My string with leading and traling spaces and line breaks and chr returns";
```

### replace:

```
:local myStr "Hello World";
:local find "Hell";
:local replace "gkTks";

:local result [($toolObj->"replace") $myStr $find $replace];
:put ($result); #"gkTkso World";
```

####replace nulls before converting to json

```
:local myStr "some string with null\00 values";
:local find "\00";
:local replace "";

:local result [($toolObj->"replace") $myStr $find $replace];
:put ($result); #"some string with null values";
```

### split:

NOTE: If trying to echo the result via :put ($result) you might not see the lines you expect. But they are there, loop over them or check the length of the returned array

```
:local myStr "Hello World\nMy World";
:local delimitor "\n"; #use a variable for the delimitor, funky results with inline args or use ("\n") for inline args

:local result [($toolObj->"split") $myStr $delimitor];
:put ($result); #array of lines broken up by the delimitor, delimitor removed
```

### toLower:

```
:local myStr "Hello World";

:local result [($toolObj->"toLower") $myStr];
:put ($result); #string "hello world"
```

### toUpper:

```
:local myStr "Hello World";

:local result [($toolObj->"toUpper") $myStr];
:put ($result); #string "HELLO WORLD"
```

### chunk:

```
:local myStr "HelloWorld";
:local chunkLen 5; #optional, default 76

:local result [($toolObj->"chunk") $myStr $chunkLen];
:put ($result); #array e.g. ["Hello", "World"]
```

### getRandom:

```
:local result [($toolObj->"getRandom") [:tonum 32]];
:put ($result); #string e.g. 'ca11d7ba70826abb715f3a5bbb4885db'
```
