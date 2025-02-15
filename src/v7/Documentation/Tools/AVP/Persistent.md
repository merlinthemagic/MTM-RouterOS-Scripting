#initialize

```
/import flash/MTM/Facts.rsc;
:global MtmFacts;
:local toolObj [($MtmFacts->"get") "getTools()->getAvps()->getPersistent()"];
```

## Methods:

### get:

```
:local key "my.ns.some.key"; #required
:local throwErr false; #optional, throw if key does not exist, default false

:put ([($toolObj->"get") $key $throwErr]); #value of the attribute if set, if not set nil or throw

```

### set:

```
:local key "my.ns.some.key"; #required
:local value "my string value"; #required

:put ([($toolObj->"set") $key $value]); #true

```

### delete:

```
:local key "my.ns.some.key"; #required
:local throwErr false; #optional, throw if key does not exist, default false

:put ([($toolObj->"delete") $key $throwErr]); #true

```