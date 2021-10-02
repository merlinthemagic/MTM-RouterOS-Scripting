# An on demand loaded library of functions for ROS scripting

100's of already built functions e.g. JSON encode, fetch API and string functions (trim, replace, split etc), get epoch.

Breaks up functionallity into class like files, Auto loader like functionallity (lazy loader to save memory).

Namespace like functionallity placing classes and methods in a hierarchy. Call methods with arguments on a single line

## Requires:

ROS v6.40 or so (cant remember when the new array syntax changed)

## Install:

Upload the 'src/flash' folder into the root of the device storage

## Use:

```
#initialize
/import flash/MTM/Facts.rsc;
:global MtmFacts;

##epoch example
:local epoch [($MtmFacts->"execute") nsStr="getTools()->getTime()->getEpoch()->getCurrent()"];
:put ($epoch); #1633175531

##md5 hash example
:local md5Tool [($MtmFacts->"execute") nsStr="getTools()->getHashing()->getMD5()"];
:put ([($md5Tool->"hash") "my string data"]); ##"8240143bd807e5a52b1f9d7dd5e21ef3"

##trim string example
:local strTool [($MtmFacts->"execute") nsStr="getTools()->getStrings()"];
:local myStr " My string with leading and traling spaces and line breaks and chr returns \n\r";
:put [($strTool->"trim") str=$myStr]; #"My string with leading and traling spaces and line breaks and chr returns";
```

## Debugging:

```
[($MtmFacts->"setDebug") true];
```

Lots of function calls are handed off to separate process for better performance, setting the debug to true 
makes (almost) everything run in the same foreground pipeline and echos step by step as well as errors

## Documentation:

Check out the Documentations folder for example code: https://github.com/merlinthemagic/MTM-RouterOS-Scripting/tree/main/Documentation

Yes, its lacking there are tons of functions that are not documented, but many of the common ones are.

Yes, the api is likely to change.


## Your turn:

Change: flash/MTM/Factories/Test.rsc

Then run: /import file-name=flash/MTM/Factories/Test.rsc

Note: If you want to expand/fix errors in the MTM classes then load MTM like so:

```
:global MtmFacts;
:set MtmFacts; #clears cache, will rebuild automatically
/import flash/MTM/Facts.rsc;

##...use MTM again
```



