:set ($s->"getHosts") do={
	:global MtmFacts;
	:local inclLocal true;
	:local attrs [:toarray "age,comment,dynamic,interface,local,bridge,disabled,external,invalid,mac-address,vid"];
	:if ($0 = false) do={
		:set inclLocal false;
	}
	:if ($1 != nil) do={
		:set attrs $1;
	}

	:local rObjs [:toarray ""];
	:local rObj [:toarray ""];
	:local count 0;
	:global MtmO1;
	:local self ($MtmO1->"|MTMC|");
	:local ids;
	:if ($inclLocal = true) do={
		:set ids [/interface bridge host find bridge=[($self->"getName")]];
	} else={
		:set ids [/interface bridge host find local=no && bridge=[($self->"getName")]];
	}
	:foreach id in=$ids do={
		:set rObj [:toarray ""];
		:foreach attr in=$attrs do={
			:set ($rObj->$attr) [/interface bridge host get $id $attr];
		}
		:set ($rObjs->$count) $rObj;
		:set count ($count + 1);
	}
	:return $rObjs;
}