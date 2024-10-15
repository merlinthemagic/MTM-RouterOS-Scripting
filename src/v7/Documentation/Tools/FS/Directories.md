#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local toolObj [($MtmFacts->"get") "getTools()->getFileSystem()->getDirectories()"];
```

## Methods:

### getExists:

```
:local dirPath "flash/path/to/my/dir"; ##no trailing /'s for now please
:local wait 1500; #optional, miliseconds to wait. Allow the directory be created in this time

:local result [($toolObj->"getExists") $dirPath [:tonum $wait]];
:put ($result); #bool
```

### create:

```
:local dirPath "flash/path/to/my/dir"; ##no trailing /'s for now please
:local result [($toolObj->"create") $dirPath];
:put ($result); #bool or error
```
