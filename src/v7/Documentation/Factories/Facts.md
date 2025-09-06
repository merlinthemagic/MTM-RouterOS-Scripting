#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local factObj $MtmFacts;
```

## Methods:

### setDebug:

```
:local mObjs [($factObj->"setDebug") (true)];
```

### setEnv:

```
:local myKey "my.project.env.var";
:local myVal "mystring I want in vars";
:local mVar [($factObj->"setEnv") $myKey $myVal];

```

### getEnv:

```
:local myKey "my.project.env.var";
:local result [($factObj->"getEnv") $myKey];
:put ($result); ##"mystring I want in vars"
```

### loadEnvFile:

takes a file of AVPs and loads into the MTM environment
file can have blank lines and comments leading with #
attribute value pairs must be in the format: string = string
e.g. myapp.secret.password=verySecret
All leading and trailing spaces will be trimmed.

```
:local filePath "flash/my/path/file.txt";
:local override false;
:local mObjs [($factObj->"loadEnvFile") $filePath $override];
```
