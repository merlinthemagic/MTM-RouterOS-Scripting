#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local nsStr "getTools()->getFetch()->getUpload()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### postJson:

```
:local url "https://www.example.net/Path/EndPoint.php";  #required
:local data [:toarray "my,data,and,objects"]; #required, can be array or already parsed json string
:local throw false; #optional, throws on error, defaults to false
:local port 443; #optional, defaults to 443 for https and 80 for http

:local result [($toolObj->"postJson") url=$url data=$data throw=$throw port=$port];
:put ($result); #"result array from fetch";
```

Example take some ethernet attributes and post to http endpoint as json:

```
:local nsStr "getTools()->getInterfaces()->getEthernet()";
:local ifTool [($MtmFacts->"execute") nsStr=$nsStr];

:local ifName "ether1";
:local attrs [:toarr "name,mac-address,tx-bytes,rx-bytes"];
:local data [($ifTool->"getAttributes") name=$ifName attrs=$attrs];

:local url "https://www.example.net/Path/EndPoint.php";
:local result [($toolObj->"postJson") url=$url data=$data];

:put ($result); #array:"downloaded=0;duration=00:00:01;status=finished;total=0";

```