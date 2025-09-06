#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local nsStr "getTools()->getParsing()->getMonitorData()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];

```

## Methods:

### getV1:

```
:local tmpFile "myTmp.txt";

#execute monitoring command and store in file
/interface ethernet monitor [find where name=$param1] once without-paging file=$tmpFile;

#read the file content
:local nsStr "getTools()->getFiles()->getContent(path='$tmpFile')";
:local mData [($MtmFacts->"execute") nsStr=$nsStr];

#parse the monitoring data
:local nsStr "getTools()->getParsing()->getMonitorData()->getV1(data='$mData')";
:local result [($MtmFacts->"execute") nsStr=$nsStr];

:put ($result); #"array of attributes and values formatted string";
```
