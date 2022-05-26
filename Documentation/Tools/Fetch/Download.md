#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local nsStr "getTools()->getFetch()->getDownload()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:

### getHttpToFile:

```
:local url "https://www.example.com/public/folder/file.php";
:local dstFile "flash/myConfig.rsc"; #where to save the return data. optional default is "/fetchDownload.txt"
:local port 443; #optional, if url is https and no port is set then port will be 443, http sets port to 80
:local throw false; #optional, default is false

:local result [($toolObj->"getHttpToFile") $url $dstFile $port $throw];
:put ($result); #"return obj from fetch + dst file location";
```


### ftpAsVariable:

```
:local srcPath "public/folder/here";
:local address "www.example.com";
:local username "myUsername";
:local password "mySecretPassword";
:local port 21; ##optional, defaults to 21

:local result [($toolObj->"ftpAsVariable") $srcPath $address $username $password $port];
:put ($result); #"string data from fetch";
```
