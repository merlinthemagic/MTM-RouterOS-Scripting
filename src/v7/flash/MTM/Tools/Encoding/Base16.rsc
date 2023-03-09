:local cPath "MTM/Tools/Encoding/Base16.rsc";
:local s [:toarray ""];
:set ($s->"encode") do={

	:global MtmFacts;
	:local cPath "MTM/Tools/Encoding/Base16.rsc/encode";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
	}
	:local input $0;
	:local hexs {"20";"21";"22";"23";"24";"25";"26";"27";"28";"29";"2A";"2B";"2C";"2D";"2E";"2F";"30";"31";"32";"33";"34";"35";"36";"37";"38";"39";"3A";"3B";"3C";"3D";"3E";"3F";"40";"41";"42";"43";"44";"45";"46";"47";"48";"49";"4A";"4B";"4C";"4D";"4E";"4F";"50";"51";"52";"53";"54";"55";"56";"57";"58";"59";"5A";"5B";"5C";"5D";"5E";"5F";"60";"61";"62";"63";"64";"65";"66";"67";"68";"69";"6A";"6B";"6C";"6D";"6E";"6F";"70";"71";"72";"73";"74";"75";"76";"77";"78";"79";"7A";"7B";"7D";"7E"};
	:local chrs {" ";"!";"\"";"#";"\$";"%";"&";"'";"(";")";"*";"+";",";"-";".";"/";"0";"1";"2";"3";"4";"5";"6";"7";"8";"9";":";";";"<";"=";">";"?";"@";"A";"B";"C";"D";"E";"F";"G";"H";"I";"J";"K";"L";"M";"N";"O";"P";"Q";"R";"S";"T";"U";"V";"W";"X";"Y";"Z";"[";"|";"]";"^";"_";"`";"a";"b";"c";"d";"e";"f";"g";"h";"i";"j";"k";"l";"m";"n";"o";"p";"q";"r";"s";"t";"u";"v";"w";"x";"y";"z";"{";"}";"~"}
	:local output "";
	:local mLen [:len $input];
	:local cLen [:len $chrs];
	:local in "";
	:local chr "";
	:for x from=0 to=$mLen step=1 do={
		:set in [:pick $input $x];
		:for y from=0 to=$cLen step=1 do={
			:set chr [:pick $chrs $y];
			:if ($chr = $in) do={
				:set output ($output.($hexs->$y));
			}
		}
	}
	:return $output;
}
:global MtmToolEncode1;
:set ($MtmToolEncode1->"base16") $s;
