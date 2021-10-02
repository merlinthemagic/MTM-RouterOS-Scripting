:local classId "tool-parsing-date-time";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmT;
:if (($MtmT->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"toSeconds") do={
	
		:global MtmFacts;
		:local method "Tools->Parsing->DateTime->toSeconds";
		:local input;
		:if ($0 != nil) do={
			:set input $0;
		} else={
			[($MtmFacts->"throwException") method=$method msg="Input is mandatory"];
		}
		
		:local param1 $input;
		:local pos;
		:local val;
		:local secs 0;
		:set pos [:find $param1 "w"];
		:if ([:typeof $pos] = "num") do={
			:set val [:pick $param1 0 $pos];
			:set secs ($secs + ($val * 604800));
			:set param1 [:pick $param1 ($pos + 1) [:len $param1]];
		}
		:set pos [:find $param1 "d"];
		:if ([:typeof $pos] = "num") do={
			:set val [:pick $param1 0 $pos];
			:set secs ($secs + ($val * 86400));
			:set param1 [:pick $param1 ($pos + 1) [:len $param1]];
		}
		:set pos [:find $param1 ":"];
		:if ([:typeof $pos] = "num") do={
			:set val [:pick $param1 0 $pos];
			:set secs ($secs + ($val * 3600));
			:set param1 [:pick $param1 ($pos + 1) [:len $param1]];
		}
		:set pos [:find $param1 ":"];
		:if ([:typeof $pos] = "num") do={
			:set val [:pick $param1 0 $pos];
			:set secs ($secs + ($val * 60));
			:set param1 [:pick $param1 ($pos + 1) [:len $param1]];
		}
		:if ([:len $param1] = 2) do={
			:set secs ($secs + $param1);
			:return $secs;
		} else={
			[($MtmFacts->"throwException") method=$method msg=("Input not handled: ".$input)];
		}
	}
	:set ($MtmT->$classId) $s;
}
