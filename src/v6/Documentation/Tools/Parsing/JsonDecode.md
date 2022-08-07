#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local nsStr "getTools()->getParsing()->getJsonDecode()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];

```

## Methods:

### getFromString:

```
:local data "[\"alice\", \"bob\"]"; #required
:local result [($toolObj->"getFromString") $data];
:put ($result); #"alice;bob"
:put ("First user: ".($result->0)); #"alice"
:put ("Second user: ".($result->1)); #"bob"
```

#### Examples:

##### object with escaped string chars
```
:local data "{\"authKey\":\"wef\\\"wfbb\",\"srcFile\":\"https://example.com/serial.rsc\",\"dstFile\":\"flash/init.rsc\",\"bingo\":1}";
:local result [($toolObj->"getFromString") data=$data];
:put ($result); #"authKey=wef\"wfbb;bingo=1;dstFile=flash/init.rsc;srcFile=https://example.com/serial.rsc"
```

##### simple array
```
:local data "[\"alice\",\"bob\"]";
:local result [($toolObj->"getFromString") data=$data];
:put ($result); #"alice;bob" indexed 0,1
```

##### object with nested array
```
:local data "{\"users\":[\"alice\", \"bob\"],\"hello\":\"world\",\"bingo\":1}";
:local result [($toolObj->"getFromString") data=$data];
:put ($result); #"bingo=1;hello=world;users=alice;bob"
:put ("First user: ".($result->"users"->0)); #"alice"
```

##### array with mixed data types
```
:local data "[\"alice\",\"bob\",99]";
:local result [($toolObj->"getFromString") data=$data];
:put ($result); #"alice;bob;99" indexes 0,1 will be str, index 2 will be num 
```