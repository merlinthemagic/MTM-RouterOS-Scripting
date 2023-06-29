#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local toolObj [($MtmFacts->"get") "getTools()->getParse()->getLogs()"];
```

## Methods:

### getFromStr:

```
:local mData "Jun/29/2023 13:35:36 ntp,debug Peer IP exists. Try again after 30 seconds.\n
Jun/29/2023 13:35:36 ntp,debug Peer IP exists. Try again after 30 seconds.";

:put ([($toolObj->"getFromStr") $mData]); #array
```

####Example logs from file

##setup log to file for wireless events
#/system/logging/action/add disk-file-count=2 disk-file-name=flash/wlanLog disk-lines-per-file=10 name=wlanSyslog target=disk;
#/system/logging/add action=wlanSyslog disabled=no topics=wireless;


```
:local mVal "";
:local mData $0;
:local rObjs [:toarray ""];

:global MtmFacts;
:local toolObj [($MtmFacts->"get") "getTools()->getParse()->getLogs()"];

:foreach id in=[/file/find where name~"^flash/wlanLog+"] do={
	:set mVal [/file/get $id size];
	:if ($mVal > 0) do={
		:if ($mVal < 4096) do={
		
			:set mData [/file/get $id contents];
			:set mVal [/file/set $id contents=""];
			:set rObjs [($toolObj->"getFromStr") $mData];
			##do something with the wireless logs
	
		} else= {
			:put ("Data too large");
			:set mVal [/file/set $id contents=""];
		}

	} else={
		:put ("No Data");
	}
}

```