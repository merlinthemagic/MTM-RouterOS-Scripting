# An on demand loaded library of functions for ROS v7 scripting

100's of already built functions e.g. JSON/Base64/Base16 encode/decode, fetch API and string functions (trim, replace, split, chunk), get epoch etc.

Breaks up functionallity into class like files, Auto loader like functionallity (lazy loader to save memory).

Namespace like functionallity placing classes and methods in a hierarchy. Call methods with arguments on a single line

## Requires:

ROS v7

## Install:

Upload the 'src/v7/flash/Facts.rsc', 'src/v7/flash/MtmEnv.env' and 'src/v7/flash/mtmRoot.hint' files to a folder on your ROS device. Then edit 'MtmEnv.env' if needed. The defaults will work fine

## Remote loading

While Facts.rsc, MtmEnv.env and mtmRoot.hint are the only required files, look at MtmEnv.env for additional options. You can make a copy of the lib and store it on your own server, then have MTM load files from there whenever they are missing locally. The default config fetches files from master on github. But you dont have to trust me, download, verify and then only use your own copy of the repository on your devices.


## Initialize MTM:

You can load MTM by specifying the path to the Enable.rsc file, or dynamically using the code block below.
In mos environments you know where the lib is located, so just load it statically

### Static load (replace with your path)

```
/import file-name="flash/MTM/Enable.rsc" verbose=no;

```

### Dynamic load

```
:local rootPath "";
:local hintFile "mtmRoot.hint";
:local mVal [/file/find name~$hintFile];
:if ([:len $mVal] = 0) do={
	:error ("Hint file: '".$hintFile."' does not exist");
}
:set mVal [/file/get $mVal name];
:set rootPath [:pick $mVal 0 ([:len $mVal] - 13)];
/import file-name=($rootPath."/Enable.rsc") verbose=no;

```


## Use examples:

```
#initialize by importing the Enable.rsc file 
:global MtmFacts;

##md5 hash example
:local myInput "my string data";
:local toolObj [($MtmFacts->"get") "getTools()->getHashing()->getMD5()"];
:put ([($toolObj->"hash") $myInput]); #string 8240143bd807e5a52b1f9d7dd5e21ef3

##Base64 encode example
:local myInput "My string i want to encode";
:local toolObj [($MtmFacts->"get") "getTools()->getEncoding()->getBase64()"];
:put ([($toolObj->"encode") $myInput]); #string TXkgc3RyaW5nIGkgd2FudCB0byBlbmNvZGU=

##trim string example
:local strTool [($MtmFacts->"get") "getTools()->getTypes()->getStrings()"];
:local myStr " My string with leading and traling spaces and line breaks and chr returns \n\r";
:put [($strTool->"trim") $myStr]; #string "My string with leading and traling spaces and line breaks and chr returns"
```

## Documentation:

Work in progress, but check the <a href="https://github.com/merlinthemagic/MTM-RouterOS-Scripting/tree/main/src/v7/Documentation">Documentation folder</a> for examples.

## Debugging:

```
[($MtmFacts->"setDebug") "true"];
```

Lots of function calls are handed off to separate process for better performance, setting the debug to true 
makes (almost) everything run in the same foreground pipeline and echos step by step as well as errors
