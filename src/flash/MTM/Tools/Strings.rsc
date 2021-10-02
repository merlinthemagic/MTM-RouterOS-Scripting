:local classId "tool-strings";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmT2;
:if (($MtmT2->$classId) = nil) do={
	
	:local s [:toarray ""];
	
	:set ($s->"trim") do={
	
		:global MtmFacts;
		:local method "Tools->Strings->trim";
		:local param1;
		:if ($0 != nil) do={
			:set param1 $0;
		} else={
			:if ($str != nil) do={
				:set param1 $str;
			} else={
				[($MtmFacts->"throwException") method=$method msg="String is mandatory"];
			}
		}
		:set param1 [:tostr $param1]; #ROS casts lots of things as arrays. e.g. rx/tx data from interfaces
		:local rLen [:len $param1];
		:local rData "";
		:local ch "";
		:local isDone 0;
		# remove leading spaces
		:for x from=0 to=($rLen - 1) do={
			:set ch [:pick $param1 $x];
			:if ($isDone = 0 && $ch != " " && $ch != "\n" && $ch != "\r") do={
				:set rData [:pick $param1 $x $rLen];
				:set isDone 1;
			}
		}
		:set rLen [:len $rData];
		:local cPos $rLen;
		:set isDone 0;
		# remove trailing spaces
		:for x from=1 to=($rLen - 1) do={
			:set cPos ($rLen - $x);
			:set ch [:pick $rData $cPos];
			:if ($isDone = 0 && $ch != " " && $ch != "\n" && $ch != "\r") do={
				:set rData [:pick $rData 0 ($cPos + 1)];
				:set isDone 1;
			}
		}
		:if ($rData = [:nothing]) do={
			#always return string, the nil value is a pain
			:set rData "";
		}
		:return $rData;
	}
	:set ($s->"replace") do={
		
		:global MtmFacts;
		:local method "Tools->Strings->replace";
		:local param1; #str
		:local param2; ##find
		:local param3; ##replace
		:if ($0 != nil) do={
			:set param1 $0;
			:set param2 $1;
			:set param3 $2;
		} else={
			:if ($str != nil) do={
				:set param1 $str;
				:set param2 $find;
				:set param3 $replace;
			} else={
				[($MtmFacts->"throwException") method=$method msg="String is mandatory"];
			}
		}
		
		:set param1 [:tostr $param1]; #ROS casts lots of things as arrays. e.g. rx/tx data from interfaces
		:local rData "";
		:local pos;
		:local rLen [:len $param1];
		
		:local findLen [:len $param2];
		:local isDone 0;
		:while ($isDone = 0) do={
			:set pos [:find $param1 $param2];
			:if ([:typeof $pos] = "num") do={
				:set rData ($rData.[:pick $param1 0 $pos].$param3);
				:set param1 [:pick $param1 ($pos + $findLen) $rLen];
				:set rLen [:len $param1];
			} else={
				:set rData ($rData.$param1);
				:set isDone 1;
			}
		}
		:return $rData;
	}
	:set ($s->"split") do={
		
		:global MtmFacts;
		:local method "Tools->Strings->split";
		:local param1; #input
		:local param2; #deliminator
		:if ($0 != nil) do={
			:set param1 $0;
			:set param2 $1;
		} else={
			:if ($str != nil) do={
				:set param1 $str;
				:set param2 $delimitor;
			} else={
				[($MtmFacts->"throwException") method=$method msg="String is mandatory"];
			}
		}
		
		:local rData [:toarray ""];
		:local lData "";
		:local splitLen [:len $param2];
		:local rLen [:len $param1];
		:local rCount 0;
		:local pos;
		:local isDone 0;
		:while ($isDone = 0) do={
			:set pos [:find $param1 $param2];
			:if ([:typeof $pos] = "num") do={
				:set lData [:pick $param1 0 $pos];
				:set param1 [:pick $param1 ($pos + $splitLen) $rLen];
				:set rLen [:len $param1];
			} else={
				:set lData $param1;
				:set isDone 1;
			}
			:set ($rData->$rCount) $lData;
			:set rCount ($rCount + 1);
		}
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
	:set ($MtmT2->$classId) $s;
}
