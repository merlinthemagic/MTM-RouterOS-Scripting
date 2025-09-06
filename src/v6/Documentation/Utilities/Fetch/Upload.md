#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local nsStr "getUtilities()->getFetch()->getUpload()";
:local utilObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:


### newJob:

this method will store the new data and trigger a send of all data

```
:local url "https://my.example.com/path/script.php";
:local data "{\"my\":\"jsonData\"}";
:local timeout 1800; #keep trying to deliver for 30 min, retries will happen on newjob or by calling trigger
:local minPause 30; #minimum wait between sending attempts 
:local method "post";
:local dataType "json";

:local result [($utilObj->"newJob") $url $data $timeout $minPause $method $dataType];
:put ($result); #nil
```

### addJob:

this method will store the new data, but not trigger the send

```
:local url "https://my.example.com/path/script.php";
:local data "{\"my\":\"jsonData\"}";
:local timeout 1800; #keep trying to deliver for 30 min, retries will happen on newjob or by calling trigger
:local minPause 30; #minimum wait between sending attempts 
:local method "post";
:local dataType "json";

:local result [($utilObj->"addJob") $url $data $timeout $minPause $method $dataType];
:put ($result); #nil
```

### trigger:

this method will trigger a send

```
:local result [($utilObj->"trigger")];
:put ($result); #nil
```