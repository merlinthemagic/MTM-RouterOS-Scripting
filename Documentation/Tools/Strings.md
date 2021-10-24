#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local nsStr "getTools()->getStrings()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### trim:

```
:local myStr " My string with leading and traling spaces and line breaks and chr returns \n\r";
:local result [($toolObj->"trim") str=$myStr];
:put ($result); #"My string with leading and traling spaces and line breaks and chr returns";
```

### replace:

```
:local myStr "Hello World";
:local find "Hell";
:local replace "gkTks";

:local result [($toolObj->"replace") str=$myStr find=$find replace=$replace];
:put ($result); #"gkTkso World";
```

### split:

NOTE: If trying to echo the result via :put ($result) you might not see the lines you expect. But they are there, loop over them or check the length of the returned array

```
:local myStr "Hello World\nMy World";
:local delimitor "\n"; #use a variable for the delimitor, funky results with inline args or use ("\n") for inline args

:local result [($toolObj->"split") str=$myStr delimitor=$delimitor];
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
