#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local toolObj [($MtmFacts->"get") "getTools()->getFileSystem()->getFiles()"];
```

## Methods:

### getExists:

```
:local filePath "flash/path/to/my/file.txt";
:local wait 1500; #optional, miliseconds to wait. Allow the file be created in this time

:local result [($toolObj->"getExists") $filePath [:tonum $wait]];
:put ($result); #bool
```

### getTemp:

```
:local result [($toolObj->"getTemp") $filePath];
:put ($result); #string e.g. ji673hffie.txt
```

### create:

```
:local filePath "flash/path/to/my/file.txt";
:local result [($toolObj->"create") $filePath];
:put ($result); #bool or error
```

### setContent:

```
:local filePath "flash/path/to/my/file.txt";
:local content "bla bla bla";
:local result [($toolObj->"setContent") $filePath $content];
:put ($result); #bool or error
```

### getContent:

```
:local filePath "flash/path/to/my/file.txt";
:local result [($toolObj->"getContent") $filePath];
:put ($result); #bla bla bla
```



### getSize:

```
:local filePath "flash/path/to/my/file.txt";
:local result [($toolObj->"getSize") $filePath];
:put ($result); #num, file size in bytes or error
```

### isSize:

```
:local filePath "flash/path/to/my/file.txt";
:local size 33; #size in bytes
:local wait 1500; #optional, miliseconds to wait. Allow the file to reach this size

:local result [($toolObj->"isSize") $filePath [:tonum $size] [:tonum $wait]];
:put ($result); #bool

```