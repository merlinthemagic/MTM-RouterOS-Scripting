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

:local nsStr "getTools()->getTime()->getEpoch()->getCurrent()";
:local result [($MtmFacts->"execute") nsStr=$nsStr];
:put ($result); #epoch time
```

##Debugging:

```
[($MtmFacts->"setDebug") true];

```

Lots of function calls are handed off to separate process for better performance, setting the debug to true 
makes (almost) everything run in the same foreground pipeline and echos step by step as well as errors

##Documentation:

Yes, its lacking there are tons of functions that are not documented, but many of the common ones are.
The api is likely to change.

Check out the Documentations folder for example code

## You try:

Change: flash/MTM/Factories/Test.rsc

Then run: /import file-name=flash/MTM/Factories/Test.rsc

Note: If you want to expand/fix errors in the MTM classes then load MTM like so:

```
:global MtmFacts;
:set MtmFacts; #clears cache, will rebuild automatically
/import flash/MTM/Facts.rsc;

##...use MTM again

```



