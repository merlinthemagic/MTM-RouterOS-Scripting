:set ($s->"chunk") do={
	
	:global MtmFacts;
	:local method "Tools->Strings->chunk";
	:local param1; #input
	:local param2 76; #chunk length
	:if ($0 != nil) do={
		:set param1 $0;
	} else={
		[($MtmFacts->"throwException") method=$method msg="String is mandatory"];
	}
	:if ($1 != nil) do={
		:set param2 $1;
	}
	:local rData [:toarray ""];
	:local rCount 0;
	:if ($param2 = 0) do={
		:set ($rData->$rCount) $param1;
		:return $rData;
	}
	:local chunk "";
	:local clen;
	:local rLen [:len $param1];
	:for x from=0 to=($rLen - 1) do={
		:set clen [:len $chunk];
		:if ($clen = $param2) do={
			:set ($rData->$rCount) $chunk;
			:set rCount ($rCount + 1);
			:set chunk "";
		}
		:set chunk ($chunk.[:pick $param1 $x]);
	}
	##add the last
	:set ($rData->$rCount) $chunk;
	:return $rData;
}
:set ($s->"toLower") do={
	
	:global MtmFacts;
	:local method "Tools->Strings->toLower";
	:local param1; #input
	:if ($0 != nil) do={
		:set param1 $0;
	} else={
		:if ($str != nil) do={
			:set param1 $str;
		} else={
			[($MtmFacts->"throwException") method=$method msg="String is mandatory"];
		}
	}
	
	:local rData "";
	:local rLen [:len $param1];
	:local upper "ABCDEFGHIKJLMNOPQRSTUVWXYZ";
	:local lower "abcdefghikjlmnopqrstuvwxyz";
	:local ch;
	:local pos;
	:for x from=0 to=($rLen - 1) do={
		:set ch [:pick $param1 $x];
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
	:local method "Tools->Strings->toUpper";
	:local param1; #input
	:if ($0 != nil) do={
		:set param1 $0;
	} else={
		:if ($str != nil) do={
			:set param1 $str;
		} else={
			[($MtmFacts->"throwException") method=$method msg="String is mandatory"];
		}
	}
	
	:local rData "";
	:local rLen [:len $param1];
	:local upper "ABCDEFGHIKJLMNOPQRSTUVWXYZ";
	:local lower "abcdefghikjlmnopqrstuvwxyz";
	:local ch;
	:local pos;
	:for x from=0 to=($rLen - 1) do={
		:set ch [:pick $param1 $x];
		:set pos [:find $lower $ch];
		:if ([:typeof $pos] = "num") do={
			:set rData ($rData.[:pick $upper $pos]);
		} else={
			:set rData ($rData.$ch);
		}
	}
	:return $rData;
}