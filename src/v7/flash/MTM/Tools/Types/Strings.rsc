:local cPath "MTM/Tools/Types/Strings.rsc";
:local s [:toarray ""];

:set ($s->"trim") do={
	
	:global MtmFacts;
	:local cPath "MTM/Tools/DataTypes/Strings.rsc/trim";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
	}
	:local p0 $0;
	:local l0 [:len $p0];
	:local r0 "";
	:local ch "";
	:local isDone 0;
	# remove leading spaces
	:for x from=0 to=($l0 - 1) do={
		:set ch [:pick $p0 $x];
		:if ($isDone = 0 && $ch != " " && $ch != "\n" && $ch != "\r") do={
			:set r0 [:pick $p0 $x $l0];
			:set isDone 1;
		}
	}
	:set l0 [:len $r0];
	:local pos $l0;
	:set isDone 0;
	# remove trailing spaces
	:for x from=1 to=($l0 - 1) do={
		:set pos ($l0 - $x);
		:set ch [:pick $r0 $pos];
		:if ($isDone = 0 && $ch != " " && $ch != "\n" && $ch != "\r") do={
			:set r0 [:pick $r0 0 ($pos + 1)];
			:set isDone 1;
		}
	}
	:if ($r0 = [:nothing]) do={
		#always return string, the nil value is a pain
		:set r0 "";
	}
	:return $r0;
}
:global MtmToolTypes1;
:set ($MtmToolTypes1->"strs") $s;