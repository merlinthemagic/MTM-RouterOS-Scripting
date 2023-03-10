:local cPath "MTM/Tools/Encoding/Base64.rsc";
:local s [:toarray ""];
:set ($s->"encode") do={

	# Creates a Base64 encoded string from a message string
	# Originally created by: rextended
	# https://forum.mikrotik.com/viewtopic.php?p=988931#p988931

	:global MtmFacts;
	:local cPath "MTM/Tools/Encoding/Base64.rsc/encode";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
	}
	:local input $0;
	
	##our allowed output values RFC 4648 base64 Standard
	:local b64Vals {"A";"B";"C";"D";"E";"F";"G";"H";"I";"J";"K";"L";"M";"N";"O";"P";"Q";"R";"S";"T";"U";"V";"W";"X";"Y";"Z";"a";"b";"c";"d";"e";"f";"g";"h";"i";"j";"k";"l";"m";"n";"o";"p";"q";"r";"s";"t";"u";"v";"w";"x";"y";"z";"0";"1";"2";"3";"4";"5";"6";"7";"8";"9";"+";"/";"="};
	
	##generate all 2byte hex values, then convert to ascii. This allows us to also encode non-printable chars (that we cant store directly)
	:local chars "";
	:local hexVals {"00";"01";"02";"03";"04";"05";"06";"07";"08";"09";"0A";"0B";"0C";"0D";"0E";"0F";"10";"11";"12";"13";"14";"15";"16";"17";"18";"19";"1A";"1B";"1C";"1D";"1E";"1F";"20";"21";"22";"23";"24";"25";"26";"27";"28";"29";"2A";"2B";"2C";"2D";"2E";"2F";"30";"31";"32";"33";"34";"35";"36";"37";"38";"39";"3A";"3B";"3C";"3D";"3E";"3F";"40";"41";"42";"43";"44";"45";"46";"47";"48";"49";"4A";"4B";"4C";"4D";"4E";"4F";"50";"51";"52";"53";"54";"55";"56";"57";"58";"59";"5A";"5B";"5C";"5D";"5E";"5F";"60";"61";"62";"63";"64";"65";"66";"67";"68";"69";"6A";"6B";"6C";"6D";"6E";"6F";"70";"71";"72";"73";"74";"75";"76";"77";"78";"79";"7A";"7B";"7C";"7D";"7E";"7F";"80";"81";"82";"83";"84";"85";"86";"87";"88";"89";"8A";"8B";"8C";"8D";"8E";"8F";"90";"91";"92";"93";"94";"95";"96";"97";"98";"99";"9A";"9B";"9C";"9D";"9E";"9F";"A0";"A1";"A2";"A3";"A4";"A5";"A6";"A7";"A8";"A9";"AA";"AB";"AC";"AD";"AE";"AF";"B0";"B1";"B2";"B3";"B4";"B5";"B6";"B7";"B8";"B9";"BA";"BB";"BC";"BD";"BE";"BF";"C0";"C1";"C2";"C3";"C4";"C5";"C6";"C7";"C8";"C9";"CA";"CB";"CC";"CD";"CE";"CF";"D0";"D1";"D2";"D3";"D4";"D5";"D6";"D7";"D8";"D9";"DA";"DB";"DC";"DD";"DE";"DF";"E0";"E1";"E2";"E3";"E4";"E5";"E6";"E7";"E8";"E9";"EA";"EB";"EC";"ED";"EE";"EF";"F0";"F1";"F2";"F3";"F4";"F5";"F6";"F7";"F8";"F9";"FA";"FB";"FC";"FD";"FE";"FF"};
	:local tmpHex "";
	:for x from=0 to=255 step=1 do={
		:set tmpHex ($hexVals->$x);
		:set chars ($chars.[[:parse "(\"\\$tmpHex\")"]]);
	}
	
	:local pos 0;
	:local output "";
	:local v0 "";
	:local v1 "";
	:local v2 "";
	:local v3 "";
	:local f6bit 0;
	:local s6bit 0;
	:local t6bit 0;
	:local q6bit 0;
	:local mVal "";
	:local mLen [:len $input];
	
	:local chr2int do={
		:if (($1="") || ([:len $1] > 1) || ([:typeof $1] = "nothing")) do={
			:return -1
		} else={
			:return [:find $2 $1 -1];
		}
	}
	
	:while ($pos < $mLen) do={
		:set v0 [:pick $input $pos ($pos + 3)];
		:set v1 [$chr2int [:pick $v0 0 1] $chars];
		:set v2 [$chr2int [:pick $v0 1 2] $chars];
		:set v3 [$chr2int [:pick $v0 2 3] $chars];
		:set f6bit ($v1 >> 2);
		:set s6bit ((($v1 & 3) * 16) + ($v2 >> 4));
		:set t6bit ((($v2 & 15) * 4) + ($v3 >> 6));
		:set q6bit	 ($v3 & 63);
		:if ([:len $v0] < 2) do={
			:set t6bit 64;
		}
		:if ([:len $v0] < 3) do={
			:set q6bit 64;
		}
		:set output ($output.($b64Vals->$f6bit).($b64Vals->$s6bit).($b64Vals->$t6bit).($b64Vals->$q6bit));
		:set pos ($pos + 3)
	}
	:return $output
}
:set ($s->"decode") do={

	# Creates a message string from a Base64 encoded string
	# Originally created by: rextended
	# https://forum.mikrotik.com/viewtopic.php?p=988931#p988931

	:global MtmFacts;
	:local cPath "MTM/Tools/Encoding/Base64.rsc/decode";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
	}
	:local input $0;
	
	##our allowed input values RFC 4648 base64 Standard
	:local b64Vals {"A";"B";"C";"D";"E";"F";"G";"H";"I";"J";"K";"L";"M";"N";"O";"P";"Q";"R";"S";"T";"U";"V";"W";"X";"Y";"Z";"a";"b";"c";"d";"e";"f";"g";"h";"i";"j";"k";"l";"m";"n";"o";"p";"q";"r";"s";"t";"u";"v";"w";"x";"y";"z";"0";"1";"2";"3";"4";"5";"6";"7";"8";"9";"+";"/";"="};
	
	##generate all 2byte hex values, then convert to ascii. This allows us to also encode non-printable chars (that we cant store directly)
	:local chars "";
	:local hexVals {"00";"01";"02";"03";"04";"05";"06";"07";"08";"09";"0A";"0B";"0C";"0D";"0E";"0F";"10";"11";"12";"13";"14";"15";"16";"17";"18";"19";"1A";"1B";"1C";"1D";"1E";"1F";"20";"21";"22";"23";"24";"25";"26";"27";"28";"29";"2A";"2B";"2C";"2D";"2E";"2F";"30";"31";"32";"33";"34";"35";"36";"37";"38";"39";"3A";"3B";"3C";"3D";"3E";"3F";"40";"41";"42";"43";"44";"45";"46";"47";"48";"49";"4A";"4B";"4C";"4D";"4E";"4F";"50";"51";"52";"53";"54";"55";"56";"57";"58";"59";"5A";"5B";"5C";"5D";"5E";"5F";"60";"61";"62";"63";"64";"65";"66";"67";"68";"69";"6A";"6B";"6C";"6D";"6E";"6F";"70";"71";"72";"73";"74";"75";"76";"77";"78";"79";"7A";"7B";"7C";"7D";"7E";"7F";"80";"81";"82";"83";"84";"85";"86";"87";"88";"89";"8A";"8B";"8C";"8D";"8E";"8F";"90";"91";"92";"93";"94";"95";"96";"97";"98";"99";"9A";"9B";"9C";"9D";"9E";"9F";"A0";"A1";"A2";"A3";"A4";"A5";"A6";"A7";"A8";"A9";"AA";"AB";"AC";"AD";"AE";"AF";"B0";"B1";"B2";"B3";"B4";"B5";"B6";"B7";"B8";"B9";"BA";"BB";"BC";"BD";"BE";"BF";"C0";"C1";"C2";"C3";"C4";"C5";"C6";"C7";"C8";"C9";"CA";"CB";"CC";"CD";"CE";"CF";"D0";"D1";"D2";"D3";"D4";"D5";"D6";"D7";"D8";"D9";"DA";"DB";"DC";"DD";"DE";"DF";"E0";"E1";"E2";"E3";"E4";"E5";"E6";"E7";"E8";"E9";"EA";"EB";"EC";"ED";"EE";"EF";"F0";"F1";"F2";"F3";"F4";"F5";"F6";"F7";"F8";"F9";"FA";"FB";"FC";"FD";"FE";"FF"};
	:local tmpHex "";
	:for x from=0 to=255 step=1 do={
		:set tmpHex ($hexVals->$x);
		:set chars ($chars.[[:parse "(\"\\$tmpHex\")"]]);
	}
	
	:local pos 0;
	:local output "";
	:local v0 0;
	:local v1 0;
	:local v2 0;
	:local v3 0;
	:local v4 0;
	:local fchr "";
	:local schr "";
	:local tchr "";
	:local mVal "";
	:local mLen [:len $input];
	
	:while ($pos < $mLen) do={
		:set v0 [:pick $input $pos ($pos + 4)];
		:set v1 [:find $b64Vals [:pick $v0 0 1]];
		:set v2 [:find $b64Vals [:pick $v0 1 2]];
		:set v3 [:find $b64Vals [:pick $v0 2 3]];
		:set v4 [:find $b64Vals [:pick $v0 3 4]];
		:if (([:typeof $v1] = "nil") || ([:typeof $v2] = "nil") || ([:typeof $v3] = "nil") || ([:typeof $v4] = "nil")) do={
				:error ("Unexpected character, invalid Base64 sequence");
		}
		:if ([:typeof [:pick $v0 1 2]] = "nil") do={
			:error ("Required 2nd character is missing");
		}
		:if (([:typeof [:pick $v0 2 3]] = "nil") and (($v2 & 15) != 0)) do={
			:error ("Required 3rd character is missing");
		}
		:if (([:typeof [:pick $v0 3 4]] = "nil") and (($v3 &	3) != 0)) do={
			:error ("Required 4th character is missing");
		}
		:set fchr [:pick $chars	(($v1 << 2) + ($v2 >> 4))];
		:set schr [:pick $chars ((($v2 & 15) << 4) + ($v3 >> 2))];
		:set tchr [:pick $chars ((($v3 & 3) << 6) + $v4)];
		:if ($v4 = 64) do={
			:set tchr "";
			:set pos $mLen;
		}
		:if ($v3 = 64) do={
			:set schr "";
			:set pos $mLen;
		}
		:if ($v2 = 64) do={
			:set fchr "";
			:error ("Unexpected padding character =");
		}
		:set output ($output.$fchr.$schr.$tchr);
		:set pos ($pos + 4)
	}
	:return $output
}

:global MtmToolEncode1;
:set ($MtmToolEncode1->"base64") $s;
