#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local toolObj $MtmFacts;
```

## Methods:

### lock:

```
:local lockName "myJob"; #required
:local duration 5; #required Maximum number of seconds to reserve the lock, expires after this time
:local wait 7; #optional, how long to wait for the lock to free up. Defaults to 2 seconds
:local key [($toolObj->"lock") $lockName $duration $wait];
:put ($key); #error if not able to obtain or string used to unlock when done e.g. e30ac94f445ce65fc5de
```

### unlock:

```
:local lockName "myJob"; #required
:local key "e30ac94f445ce65fc5de"; #required. Key string from when the job was locked
:local result [($toolObj->"unlock") $lockName $key];
:put ($result); #bool true, error if key is not valid
```