:local cPath "MTM/Tools/Hashing/SHA1.rsc";
:local s [:toarray ""];
:set ($s->"get") do={
	
	:global MtmFacts;
	:local cPath "MTM/Tools/Hashing/SHA1.rsc/getFromString";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
	}
	:local input $0;
	
	##not ready, just found need validation, cleanup and debugging removed
	#Original work by alexbayker: https://forum.mikrotik.com/t/script-md5-hash-generator/57409/18
	
	:local Debug 0

	:local strMessage [:tostr $input]
	
	:local arrCharSet ( "\00", "\01", "\02", "\03", "\04", "\05", "\06", "\07", \
						"\08", "\09", "\0A", "\0B", "\0C", "\0D", "\0E", "\0F", \
						"\10", "\11", "\12", "\13", "\14", "\15", "\16", "\17", \
						"\18", "\19", "\1A", "\1B", "\1C", "\1D", "\1E", "\1F", \
						"\20", "\21", "\22", "\23", "\24", "\25", "\26", "\27", \
						"\28", "\29", "\2A", "\2B", "\2C", "\2D", "\2E", "\2F", \
						"\30", "\31", "\32", "\33", "\34", "\35", "\36", "\37", \
						"\38", "\39", "\3A", "\3B", "\3C", "\3D", "\3E", "\3F", \
						"\40", "\41", "\42", "\43", "\44", "\45", "\46", "\47", \
						"\48", "\49", "\4A", "\4B", "\4C", "\4D", "\4E", "\4F", \
						"\50", "\51", "\52", "\53", "\54", "\55", "\56", "\57", \
						"\58", "\59", "\5A", "\5B", "\5C", "\5D", "\5E", "\5F", \
						"\60", "\61", "\62", "\63", "\64", "\65", "\66", "\67", \
						"\68", "\69", "\6A", "\6B", "\6C", "\6D", "\6E", "\6F", \
						"\70", "\71", "\72", "\73", "\74", "\75", "\76", "\77", \
						"\78", "\79", "\7A", "\7B", "\7C", "\7D", "\7E", "\7F"  )
						
	:local hexSymbSet "0123456789abcdef"

	:local h1   0x67452301
	:local h2   0xEFCDAB89
	:local h3   0x98BADCFE
	:local h4   0x10325476
	:local h5   0xC3D2E1F0
	:local k1   0x5A827999
	:local k2   0x6ED9EBA1
	:local k3   0x8F1BBCDC
	:local k4   0xCA62C1D6

	:local x40  0x40000000
	:local xF   0xF
	:local x100 0x100000000
	:local x7F  0x7FFFFFFF
	
	:local amp  0xFFFFFFFF
	
	:if ($Debug > 0) do={
		:put "Message: $strMessage"
	}
	
	:local messageLength [:len $strMessage]  
	
	:local binaryString ""
	:local binaryWOSpaces ""
	
	:local leftrotate 0
	:local left 0
	:local right 0
	
	:local start 0
	:local number 0
	
	:local b16 0
	:local b15 0
	:local b14 0
	:local b13 0
	:local b12 0
	:local b11 0
	:local b10 0
	:local b9  0
	:local b8  0
	:local b7  0
	:local b6  0
	:local b5  0
	:local b4  0
	:local b3  0
	:local b2  0
	:local b1  0
   
	:for i from 1 to=($messageLength) do={
		:set start (i - 1)
		:local char [:pick $strMessage $start $i]
		
		:set number [:find $arrCharSet $char]
		:set b8 0 ; :if ($number & 128) do={:set b8 1}
		:set b7 0 ; :if ($number &  64) do={:set b7 1}
		:set b6 0 ; :if ($number &  32) do={:set b6 1}
		:set b5 0 ; :if ($number &  16) do={:set b5 1}
		:set b4 0 ; :if ($number &   8) do={:set b4 1}
		:set b3 0 ; :if ($number &   4) do={:set b3 1}
		:set b2 0 ; :if ($number &   2) do={:set b2 1}
		:set b1 0 ; :if ($number &   1) do={:set b1 1}
		
		:local binaryChar "$b8$b7$b6$b5$b4$b3$b2$b1"
		
		:set binaryString "$binaryString $binaryChar"
		:set binaryWOSpaces "$binaryWOSpaces$binaryChar"
	}
	
	:local binaryLength [:len $binaryString]  
	
	:local binaryMessageLength ($messageLength * 8 - 8)
	:local bitLength ($binaryMessageLength + 8)
	
	:set number $bitLength
	:set b16 0 ; :if ($number & 32768) do={:set b16 1}
	:set b15 0 ; :if ($number & 16384) do={:set b15 1}
	:set b14 0 ; :if ($number &  8192) do={:set b14 1}
	:set b13 0 ; :if ($number &  4096) do={:set b13 1}
	:set b12 0 ; :if ($number &  2048) do={:set b12 1}
	:set b11 0 ; :if ($number &  1024) do={:set b11 1}
	:set b10 0 ; :if ($number &   512) do={:set b10 1}
	:set b9  0 ; :if ($number &   256) do={:set b9  1}
	:set b8  0 ; :if ($number &   128) do={:set b8  1}
	:set b7  0 ; :if ($number &    64) do={:set b7  1}
	:set b6  0 ; :if ($number &    32) do={:set b6  1}
	:set b5  0 ; :if ($number &    16) do={:set b5  1}
	:set b4  0 ; :if ($number &     8) do={:set b4  1}
	:set b3  0 ; :if ($number &     4) do={:set b3  1}
	:set b2  0 ; :if ($number &     2) do={:set b2  1}
	:set b1  0 ; :if ($number &     1) do={:set b1  1}
		
	:local endBitLength "$b16$b15$b14$b13$b12$b11$b10$b9$b8$b7$b6$b5$b4$b3$b2$b1"
	
	:for i from 1 to=(48) do={
		:set endBitLength "0$endBitLength"
	}
	
	:local subMod [:len $endBitLength]  
	
	:local binaryZeros ($binaryMessageLength % 512)
	
	:if ((432 - $binaryZeros) < 0) do={
		:local x (512 - $binaryZeros)
		:set binaryZeros ($x + 440 + $binaryZeros + 64)
	} else={
		:set binaryZeros (432 - $binaryZeros)
	}
	
	:local messageBinary ($binaryWOSpaces . "10000000")
	
	:while ($binaryZeros > 0) do={
		:set messageBinary ($messageBinary . "0")
		:set binaryZeros ($binaryZeros - 1)
	}
	
	:set messageBinary ($messageBinary . $endBitLength)
	
	:local mLength [:len $messageBinary]
	
	:local mArray []
	
	:local dec 0
	
	:for i from=0 to=($mLength - 1) step=32 do={
		:local subStr [:pick $messageBinary ($i + 1) ($i + 32)]
		
		:set dec 0
		
		:local subStrLen [:len $subStr]
		
		:for j from 1 to=($subStrLen) do={
			:set start (j - 1)
			:local char [:pick $subStr $start $j]
			:local num [:tonum $char]
			
			:set dec ($dec + ($num * (1 << ($subStrLen - $j))))
		}
	
		:set number $dec
		:local hexadec "0"
		:local remainder 0
		:if ($number > 0) do={:set hexadec ""}
		:while ( $number > 0 ) do={
			:set remainder ($number % 16)
			:set number (($number - $remainder) / 16)
			:set hexadec ([:pick $hexSymbSet $remainder] . $hexadec)
		} 
		:if ([:len $hexadec] = 1) do={:set hexadec "0$hexadec"}
		
		:local end (i + 1)
		:local startChar [:pick $messageBinary $i $end]
		:local charNum [:tonum $startChar]
		
		:local numInMArray [:tonum $hexadec]
		
		:if ($charNum = 1) do={
			:set numInMArray ($numInMArray | 0x80000000)
			:set dec (-1 * $numInMArray)
		}
		
		if ([:len $dec] > 0) do={
			:set ($mArray->($i / 32)) $dec
		}
		
		:if ($Debug > 0) do={
			:put ("Iteration: $i $subStr $dec")
		}
	}

	:local integerCount [:len $mArray]
	
	:local intArray []
	
	:local j 0
	
	:for i from 0 to=($integerCount - 1) step=16 do={
		:for j from 0 to=15 do={
			:set ($intArray->$j) ($mArray->($j + $i))
		}
		:for j from 16 to=79 do={
			:local x (($intArray->($j - 3)) ^ ($intArray->($j - 8)) ^ ($intArray->($j - 14)) ^ ($intArray->($j - 16)))
			:if ($x >= 0) do={
				:set leftrotate (((($x << 1) | (($x >> 31) )) & $amp ))
			} else={
				:set left ($x << 1)
				:set right ((((($x >> 1) & $x7F) | $x40) >> 30))
				:set leftrotate ((($left) | ($right)) & $amp )
			}
			:if ($leftrotate > $x7F) do={
				:set leftrotate ($leftrotate - $x100)
			}
			:set ($intArray->$j) $leftrotate
		}
		
		:local A $h1
		:local B $h2
		:local C $h3
		:local D $h4
		:local E $h5
		:local t 0
		
		:for x from 0  to=19 do={
			:if ($A >= 0) do={
				:set leftrotate ((($A << 5) | (($A >> 27) )) & $amp)
			} else={
				:set left ($A << 5)
				:set right ((((($A >> 1) & $x7F) | $x40) >> 26))
				:set leftrotate ((($left) | ($right)) & $amp )
			}
			:if ($leftrotate > $x7F) do={
				:set leftrotate ($leftrotate - $x100)
			}
			:local nB ((-1 - $B) & $amp)
			:local brackets (($B & $C) | ($nB & $D))
			:local fromArray ($intArray->($x))
			:set t (($leftrotate + $brackets + $E + $fromArray + $k1) & $amp)
			:if ($t > $x7F) do={
				:set t ($t - $x100)
			}
			:set E $D
			:set D $C
			:if ($B >= 0) do={
				:set C ((($B << 30) | (($B >> 2) )) & $amp )
			} else={
				:set left ($B << 30)
				:set right ((((($B >> 1) & $x7F) | $x40) >> 1))
				:set C ((($left) | ($right)) & $amp )
			}
			:if ($C > $x7F) do={
				:set C ($C - $x100)
			}
			:set B $A
			:set A $t
		}
		:for b from 20 to=39 do={
			:if ($A >= 0) do={
				:set leftrotate ((($A << 5) | (($A >> 27) )) & $amp)
			} else={
				:set left ($A << 5)
				:set right ((((($A >> 1) & $x7F) | $x40) >> 26))
				:set leftrotate ((($left) | ($right)) & $amp )
			}
			:if ($leftrotate > $x7F) do={
				:set leftrotate ($leftrotate - $x100)
			}
			:local brackets ($B ^ $C ^ $D)
			:local fromArray ($intArray->($b))
			:set t (($leftrotate + $brackets + $E + $fromArray + $k2) & $amp)
			:if ($t > $x7F) do={
				:set t ($t - $x100)
			}
			:set E $D
			:set D $C
			:if ($B >= 0) do={
				:set C ((($B << 30) | (($B >> 2) )) & $amp )
			} else={
				:set left ($B << 30)
				:set right ((((($B >> 1) & $x7F) | $x40) >> 1))
				:set C ((($left) | ($right)) & $amp )
			}
			:if ($C > $x7F) do={
				:set C ($C - $x100)
			}
			:set B $A
			:set A $t
		}
		:for c from 40 to=59 do={
			:if ($A >= 0) do={
				:set leftrotate ((($A << 5) | (($A >> 27) )) & $amp)
			} else={
				:set left ($A << 5)
				:set right ((((($A >> 1) & $x7F) | $x40) >> 26))
				:set leftrotate ((($left) | ($right)) & $amp )
			}
			:if ($leftrotate > $x7F) do={
				:set leftrotate ($leftrotate - $x100)
			}
			:local brackets (($B & $C) | ($B & $D) | ($C & $D))
			:local fromArray ($intArray->($c))
			:set t (($leftrotate + $brackets + $E + $fromArray + $k3)  & $amp)
			:if ($t > $x7F) do={
				:set t ($t - $x100)
			}
			:set E $D
			:set D $C
			:if ($B >= 0) do={
				:set C ((($B << 30) | (($B >> 2) )) & $amp )
			} else={
				:set left ($B << 30)
				:set right ((((($B >> 1) & $x7F) | $x40) >> 1))
				:set C ((($left) | ($right)) & $amp )
			}
			:if ($C > $x7F) do={
				:set C ($C - $x100)
			}
			:set B $A
			:set A $t
		}
		:for d from 60 to=79 do={
			:if ($A >= 0) do={
				:set leftrotate ((($A << 5) | (($A >> 27) )) & $amp)
			} else={
				:set left ($A << 5)
				:set right ((((($A >> 1) & $x7F) | $x40) >> 26))
				:set leftrotate ((($left) | ($right)) & $amp )
			}
			:if ($leftrotate > $x7F) do={
				:set leftrotate ($leftrotate - $x100)
			}
			:local brackets ($B ^ $C ^ $D)
			:local fromArray ($intArray->($d))
			:set t (($leftrotate + $brackets + $E + $fromArray + $k4) & $amp)
			:if ($t > $x7F) do={
				:set t ($t - $x100)
			}
			:set E $D
			:set D $C
			:if ($B >= 0) do={
				:set C ((($B << 30) | (($B >> 2) )) & $amp )
			} else={
				:set left ($B << 30)
				:set right ((((($B >> 1) & $x7F) | $x40) >> 1))
				:set C ((($left) | ($right)) & $amp )
			}
			:if ($C > $x7F) do={
				:set C ($C - $x100)
			}
			:set B $A
			:set A $t
		}
		
		:set h1 (($h1 + $A) & $amp )
		:if ($h1 > $x7F) do={
			:set h1 ($h1 - $x100)
		}
		:set h2 (($h2 + $B) & $amp )
		:if ($h2 > $x7F) do={
			:set h2 ($h2 - $x100)
		}
		:set h3 (($h3 + $C) & $amp )
		:if ($h3 > $x7F) do={
			:set h3 ($h3 - $x100)
		}
		:set h4 (($h4 + $D) & $amp )
		:if ($h4 > $x7F) do={
			:set h4 ($h4 - $x100)
		}
		:set h5 (($h5 + $E) & $amp ) 
		:if ($h5 > $x7F) do={
			:set h5 ($h5 - $x100)
		}
	}
	:if ($Debug > 0) do={
		:put ("This is h: $h1 $h2 $h3 $h4 $h5")
	}

	:local hexdigit 8
	:local hex1 ""
	:local hex2 ""
	:local hex3 ""
	:local hex4 ""
	:local hex5 ""
	
	:for i from=0 to=(4 * ($hexdigit - 1)) step=4 do={ 
		:set hex1 ([:pick $hexSymbSet (($h1 >> $i) & $xF) ((($h1 >> $i) & $xF) + 1)] . $hex1)
	}
	
	:set hexdigit 8
	:for i from=0 to=(4 * ($hexdigit - 1)) step=4 do={ 
		:set hex2 ([:pick $hexSymbSet (($h2 >> $i) & $xF) ((($h2 >> $i) & $xF) + 1)] . $hex2)
	}
	
	:set hexdigit 8
	:for i from=0 to=(4 * ($hexdigit - 1)) step=4 do={ 
		:set hex3 ([:pick $hexSymbSet (($h3 >> $i) & $xF) ((($h3 >> $i) & $xF) + 1)] . $hex3)
	}
	
	:set hexdigit 8
	:for i from=0 to=(4 * ($hexdigit - 1)) step=4 do={ 
		:set hex4 ([:pick $hexSymbSet (($h4 >> $i) & $xF) ((($h4 >> $i) & $xF) + 1)] . $hex4)
	}
	
	:set hexdigit 8
	:for i from=0 to=(4 * ($hexdigit - 1)) step=4 do={ 
		:set hex5 ([:pick $hexSymbSet (($h5 >> $i) & $xF) ((($h5 >> $i) & $xF) + 1)] . $hex5)
	}
	
	:local result "$hex1$hex2$hex3$hex4$hex5"
	
	:if ($Debug > 0) do={
		:put ("THIS IS HEX: $hex1 $hex2 $hex3 $hex4 $hex5")
		:put ("MArray  Length: $integerCount")
		:put ("Message Length: $binaryString $binaryLength")
		:put ("End bit Length: $endBitLength $binaryZeros")
		:put ("Message Binary: $messageBinary $mLength")
		:put ("THIS IS RESULT: $result")
	}
	
	:return $result;

	
	
	
	
	:return [:tostr $sMd5Output];
}
:global MtmToolHashing1;
:set ($MtmToolHashing1->"md5") $s;
