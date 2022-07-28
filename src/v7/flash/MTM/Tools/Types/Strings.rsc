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
:set ($s->"replace") do={
	
	:global MtmFacts;
	:local cPath "MTM/Tools/DataTypes/Strings.rsc/replace";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input string has invalid type '".[:typeof $0]."'");
	}
	:if ([:typeof $1] != "str") do={
		:error ($cPath.": Input pattern has invalid type '".[:typeof $1]."'");
	}
	:if ([:typeof $2] != "str") do={
		:error ($cPath.": Input replacement has invalid type '".[:typeof $2]."'");
	}
	
	:local str $0;
	:local rData "";
	:local pos;
	:local rLen [:len $0];
	
	:local findLen [:len $1];
	:local isDone 0;
	:while ($isDone = 0) do={
		:set pos [:find $str $1];
		:if ([:typeof $pos] = "num") do={
			:set rData ($rData.[:pick $str 0 $pos].$2);
			:set str [:pick $str ($pos + $findLen) $rLen];
			:set rLen [:len $str];
		} else={
			:set rData ($rData.$str);
			:set isDone 1;
		}
	}
	:return $rData;
}
:set ($s->"toLower") do={
	
	:global MtmFacts;
	:local cPath "MTM/Tools/DataTypes/Strings.rsc/toLower";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input string has invalid type '".[:typeof $0]."'");
	}
	
	:local rData "";
	:local rLen [:len $0];
	:local upper "ABCDEFGHIKJLMNOPQRSTUVWXYZ";
	:local lower "abcdefghikjlmnopqrstuvwxyz";
	:local ch;
	:local pos;
	:for x from=0 to=($rLen - 1) do={
		:set ch [:pick $0 $x];
		:set pos [:find $upper $ch];
		:if ([:typeof $pos] = "num") do={
			:set rData ($rData.[:pick $lower $pos]);
		} else={
			:set rData ($rData.$ch);
		}
	}
	:return $rData;
}
:set ($s->"toUpper") do={
	
	:global MtmFacts;
	:local cPath "MTM/Tools/DataTypes/Strings.rsc/toUpper";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input string has invalid type '".[:typeof $0]."'");
	}
	
	:local rData "";
	:local rLen [:len $0];
	:local upper "ABCDEFGHIKJLMNOPQRSTUVWXYZ";
	:local lower "abcdefghikjlmnopqrstuvwxyz";
	:local ch;
	:local pos;
	:for x from=0 to=($rLen - 1) do={
		:set ch [:pick $0 $x];
		:set pos [:find $lower $ch];
		:if ([:typeof $pos] = "num") do={
			:set rData ($rData.[:pick $upper $pos]);
		} else={
			:set rData ($rData.$ch);
		}
	}
	:return $rData;
}
:global MtmToolTypes1;
:set ($MtmToolTypes1->"strs") $s;