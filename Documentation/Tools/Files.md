#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local nsStr "getTools()->getFiles()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];
```

## Methods:



### exists:

Checks if a file exists on the path already

```
:local path "flash/myFile.txt";
:local result [($toolObj->"exists") path=$path];
:put ($result); #Bool;
```

### create:

Creates an empty file if it does not exists, else nothing

```
:local path "flash/myFile.txt";
:local result [($toolObj->"create") $path];
:put ($result); #nil for now, reserved for object in the future
```

### delete:

Deletes a file if it exists

```
:local path "flash/myFile.txt";
:local result [($toolObj->"delete") $path];
:put ($result); #nil for now, reserved for object in the future
```

### getContent:

```
:local path "flash/myFile.txt";
:local result [($toolObj->"getContent") path=$path];
:put ($result); #string containing the content of the file
```

### setContent:

```
:local path "flash/myFile.txt";
:local data "Stuff i want to store in the file";
:local result [($toolObj->"setContent") path=$path content=$data];
:put ($result); #nil for now, reserved for object in the future
```

### getSize:

```
:local path "flash/myFile.txt";
:local result [($toolObj->"getSize") $path];
:put ($result); #byte count
```

### join:

joins the content of several files into a singe new file that can be larger than 4095 bytes
Each input can only be < 4095.

Note: adds a "\r\n" after the content of each input

```
:local paths [:toarray "flash/myFile1.txt,flash/myFile2.txt"];
:local output "flash/myFile3.txt";

:local result [($toolObj->"join") $paths $output];
:put ($result);  #nil for now, reserved for object in the future
```

### setFetchUser:

Sets a service, port and credentials for a user able to fetch local files 

```
:local uName "someUsername"; 
:local uPass "verySecretPassword";
:local address "127.0.0.1";
:local serviceName "ftp"; ## ftp, http, https
:local servicePort 21; 

[($toolObj->"setFetchUser") $uName $uPass $address $serviceName $servicePort];
:put ($result); #obj;

```