# An on demand loaded library of functions for ROS v7 scripting

100's of already built functions e.g. JSON encode/decode, fetch API and string functions (trim, replace, split, chunk), get epoch etc.

Breaks up functionallity into class like files, Auto loader like functionallity (lazy loader to save memory).

Namespace like functionallity placing classes and methods in a hierarchy. Call methods with arguments on a single line

## Requires:

ROS v7

## Install:

Upload the 'src/v7/Facts.rsc' and 'src/v7/MtmEnv.rsc' files to a folder on your ROS device. Then edit 'MtmEnv.rsc' so the environmental variable 'mtm.root.path' reflects your path.

Example:

You placed the files in 'flash/MTM'.
This is the line as it should be in 'MtmEnv.rsc':


```
:set mVal [($MtmFacts->"setEnv") "mtm.root.path" "flash/MTM"];

```

##Remote loading

While 'src/v7/Facts.rsc' and 'src/v7/MtmEnv.rsc' are the only required files, look at MtmEnv.rsc for additional options. You can make a copy of the lib and store it on your own server, then have MTM load files from there whenever they are missing locally. The default config fetches files from master on github. But you dont have to trust me, download, verify and then only use your own copy of the repository on your devices.


## Use:

```
#initialize
/import flash/MTM/Facts.rsc;
:global MtmFacts;


##md5 hash example
:local toolObj [($MtmFacts->"get") "getTools()->getHashing()->getMD5()"];
:put ([($toolObj->"hash") "my string data"]); #string 8240143bd807e5a52b1f9d7dd5e21ef3

##trim string example
:local strTool [($MtmFacts->"get") "getTools()->getTypes()->getStrings()"];
:local myStr " My string with leading and traling spaces and line breaks and chr returns \n\r";
:put [($strTool->"trim") $myStr]; #string "My string with leading and traling spaces and line breaks and chr returns"
```

## Debugging:

```
[($MtmFacts->"setDebug") "true"];
```

Lots of function calls are handed off to separate process for better performance, setting the debug to true 
makes (almost) everything run in the same foreground pipeline and echos step by step as well as errors

## Documentation:

Work in progress, but check the Documentation folder for examples
