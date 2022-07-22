:local classId "tool-hash-md5";
:global MtmSM0; ##too large even for splitting up
:if (($MtmSM0->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"hash") do={
		
		:global MtmFacts;
		:local method "Tools->Hashing->MD5->hash";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Input is mandatory"];
		}
		:local input $0;
		# String message to MD5 Hash
		# Creates a MD5 hash from a message string
		# Version 1.00, 6/17/2012, Created by TealFrog
		# Script tested and developed under MikroTik ROS 5.14 thru 5.17
		#
		# This software is identified as using and is based on the, "RSA Data Security, 
		# Inc. MD5 Message-Digest Algorithm".	This program is a derived work from the RSA Data
		# Security, Inc. MD5 Message-Digest Algorithm.
		# See http://www.ietf.org/rfc/rfc1321.txt for further information.
		#
		# The author of this program makes no representations concerning either
		# the merchantability of this software or the suitability of this
		# software for any particular purpose or non-infringement.
		# This program is provided "as is" without express or implied warranty of any kind.
		# The author makes no representations or warranties of any kind as to the 
		# completeness, accuracy, timeliness, availability, functionality and compliance
		# with applicable laws. By using this software you accept the risk that the 
		# information may be incomplete or inaccurate or may not meet your needs 
		# and requirements. The author shall not be liable for any damages or 
		# injury arising out of the use of this program. Use this program at your own risk. 
		#
		# MD5 has been shown to not be collision resistant, as such MD5 is not suitable 
		# for certain applications involving security and/or cryptography, 
		# see http://en.wikipedia.org/wiki/Md5 for additional information.
		#

		:local strHexValues "0123456789abcdef"
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
							 "\78", "\79", "\7A", "\7B", "\7C", "\7D", "\7E", "\7F" ) 
	
		:local k ( 0xD76AA478, 0xE8C7B756, 0x242070DB, 0xC1BDCEEE, \
							0xF57C0FAF, 0x4787C62A, 0xA8304613, 0xFD469501, \
							0x698098D8, 0x8B44F7AF, 0xFFFF5BB1, 0x895CD7BE, \
							0x6B901122, 0xFD987193, 0xA679438E, 0x49B40821, \
							0xF61E2562, 0xC040B340, 0x265E5A51, 0xE9B6C7AA, \
							0xD62F105D, 0x02441453, 0xD8A1E681, 0xE7D3FBC8, \
							0x21E1CDE6, 0xC33707D6, 0xF4D50D87, 0x455A14ED, \
							0xA9E3E905, 0xFCEFA3F8, 0x676F02D9, 0x8D2A4C8A, \
							0xFFFA3942, 0x8771F681, 0x6D9D6122, 0xFDE5380C, \
							0xA4BEEA44, 0x4BDECFA9, 0xF6BB4B60, 0xBEBFBC70, \
							0x289B7EC6, 0xEAA127FA, 0xD4EF3085, 0x04881D05, \
							0xD9D4D039, 0xE6DB99E5, 0x1FA27CF8, 0xC4AC5665, \
							0xF4292244, 0x432AFF97, 0xAB9423A7, 0xFC93A039, \
							0x655B59C3, 0x8F0CCC92, 0xFFEFF47D, 0x85845DD1, \
							0x6FA87E4F, 0xFE2CE6E0, 0xA3014314, 0x4E0811A1, \
							0xF7537E82, 0xBD3AF235, 0x2AD7D2BB, 0xEB86D391 )
	
		:local a 0x67452301 
		:local b 0xEFCDAB89
		:local c 0x98BADCFE
		:local d 0x10325476
	
		:local AA 0x67452301
		:local BB 0xEFCDAB89
		:local CC 0x98BADCFE
		:local DD 0x10325476
	
		:local s1 (	7, 12, 17, 22 )
		:local s2 (	5,	9, 14, 20 )
		:local s3 (	4, 11, 16, 23 )
		:local s4 (	6, 10, 15, 21 )
	
		:local i 0
		:local j 0
		:local x 0
		:local S 0
		:local T 0
		:local lcv 0
		:local tmp1 0
	
		:local arrMd5State []
		:local arrWordArray []
		:local ch ""
		:local iByteCount 0
		:local iCharVal 3
		:local iDec 0
		:local iHexDigit 8
		:local iMd5State 0
		:local lBytePosition 0
		:local lMessageLength 0
		:local lNumberOfWords 0				
		:local lShiftedVal 0
		:local lWordArray []
		:local lWordArrLen 0
		:local lWordCount 0
		:local sHex ""
		:local sMd5Hash ""
		:local sMd5Output ""
		:local strWordArray ""

		:set ch ""
		:set lShiftedVal 0
		:set lWordCount 0
		:set iByteCount 0
		:set iCharVal 3
		:set lBytePosition 0
		:set lMessageLength [ :len $input ]
		:set lNumberOfWords ( ( ( ( $lMessageLength + 8 ) / 64 ) + 1 ) * 16 )				
		:set strWordArray ""
		:set arrWordArray []
	
		:for i from=1 to=($lNumberOfWords) do={
			:set strWordArray ("0," . $strWordArray)
		}
		:set strWordArray	[ :pick $strWordArray 0 ( [ :len $strWordArray ] - 1 ) ]
		:set arrWordArray [ :toarray $strWordArray ]
		:while ($iByteCount < $lMessageLength) do={
			:set lWordCount ($iByteCount / 4)
			:set lBytePosition (($iByteCount % 4) * 8)
			:if (($lBytePosition < 0) or ($lBytePosition > 31)) do={
				:error ( "$progName: Error --	Calculating byte position " . \
						"# $lBytePosition, must be 0 thru 31." )
			}
			:set ch [ :pick $input $iByteCount ]
			:if ( [ :len [ :find $arrCharSet $ch ] ] > 0 ) do={
				:set iCharVal ([ :tonum [ :find $arrCharSet $ch ] ])
			} else={
				:error "$progName: Error -- Input contains undefined ASCII value."
			}
			:set lShiftedVal ((($iCharVal) << ($lBytePosition)) | \
										 (($iCharVal) >> (32-($lBytePosition))))
			:if ($iByteCount = 0) do={
				:set lShiftedVal (([ :tonum $lShiftedVal ] + 0) & 0xFFFFFFFF)
				:set arrWordArray (([ :tonum $lShiftedVal ]), \
												 [ :pick $arrWordArray 1 [ :len $arrWordArray] ])
			} else={
				:set lShiftedVal (([ :tonum [ :pick $arrWordArray $lWordCount] ] + 0) | \
											 ([ :tonum $lShiftedVal ] + 0))
				:set lShiftedVal (([ :tonum $lShiftedVal ] + 0) & 0xFFFFFFFF)
				:set arrWordArray	([ :pick $arrWordArray 0 $lWordCount ], $lShiftedVal, \
					 [ :pick $arrWordArray ([ :tonum $lWordCount ] + 1) [ :len $arrWordArray] ])	 
			}
			:set iByteCount ( $iByteCount + 1 )
		}
		:set lWordCount ( $iByteCount / 4 )
		:set lBytePosition ( ( $iByteCount % 4 ) * 8 )
		:set lShiftedVal [ :pick $arrWordArray $lWordCount ]
	
		:set lShiftedVal ( ( [ :tonum [ :pick $arrWordArray $lWordCount ] ] + 0 ) | \
										 ( ( 0x80 << $lBytePosition ) | \
									 ( 0x80 >> ( 32 - $lBytePosition ) ) ) ) 
	
		:set arrWordArray	( ( [ :pick $arrWordArray 0 $lWordCount ]	),	\
												 [ :tonum $lShiftedVal ], \
											 ( [ :pick $arrWordArray ( [ :tonum $lWordCount ] + 1 ) \
									[ :len $arrWordArray ] ] ) ) 
									
		:set arrWordArray	[ :toarray ( ( [ :pick $arrWordArray 0 ($lNumberOfWords - 2) ] ), \
																( ( ( [ :tonum $lMessageLength ] + 0 ) << 3 ) | \
												 ( ( [ :tonum $lMessageLength ] + 0 ) >> 29 ) ), \
												 ( ( [ :tonum $lMessageLength ] + 0 )	>> 29 ) ) ] 
		:set lWordArray [ :toarray $arrWordArray ]
		:set lWordArrLen ( ( [ :len $lWordArray ] ) - 1 )
		:set tmp1 0
		:set x 0
		:set T 0
		:set S 0
		:set i 0
		:set j 0
		:local iteration 0
		:for lcv from=0 to=( $lWordArrLen ) step=16 do={
			:set AA [ :tonum $a ]
			:set BB [ :tonum $b ]
			:set CC [ :tonum $c ]
			:set DD [ :tonum $d ]
			:local chuckoffset ($iteration * 16)
			:for i from=0 to=15 do={
				:set x ( [ :tonum [ :pick $lWordArray (( $i & 15 ) + $chuckoffset) ] ] + 0 )
				:set T ( [ :tonum [ :pick $k $i ] ] + 0 )
				:set S ( [ :tonum [ :pick $s1 ( $i & 3 ) ] ] + 0 )
				:set tmp1 ( ( ( $d ^ ( $b & ( $c ^ $d ) ) ) + $a + $T + $x ) & 0xFFFFFFFF )
				:set tmp1 (((tmp1 << $S ) | (($tmp1 >> (32 - $S)))) & 0xFFFFFFFF)
				:set tmp1 ( ( $tmp1 + $b ) & 0xFFFFFFFF )
				
				:set a ( ( [ :tonum $d ] + 0 ) & 0xFFFFFFFF )
				:set d ( ( [ :tonum $c ] + 0 ) & 0xFFFFFFFF )
				:set c ( ( [ :tonum $b ] + 0 ) & 0xFFFFFFFF )
				:set b ( ( [ :tonum $tmp1 ] + 0 ) & 0xFFFFFFFF )
			}
			:set j 1
			:for i from=0 to=15 do={
				:set x ( [ :tonum [ :pick $lWordArray (( ( [ :tonum $j ] + 0 ) & 15 ) + $chuckoffset ) ] ] + 0 )
				:set T ( [ :tonum [ :pick $k ( $i + 16 ) ] ] + 0 )
				:set S ( [ :tonum [ :pick $s2 ( $i & 3 ) ] ] + 0 )
				:set tmp1 ( ( ( $c ^ ( $d & ( $b ^ $c ) ) ) + $a + $T + $x ) & 0xFFFFFFFF )
				:set tmp1 (((tmp1 << $S ) | (($tmp1 >> (32 - $S)))) & 0xFFFFFFFF)
				:set tmp1 ( ( $tmp1 + $b ) & 0xFFFFFFFF )
				:set a ( ( [ :tonum $d ] + 0 ) & 0xFFFFFFFF )
				:set d ( ( [ :tonum $c ] + 0 ) & 0xFFFFFFFF )
				:set c ( ( [ :tonum $b ] + 0 ) & 0xFFFFFFFF )
				:set b ( ( [ :tonum $tmp1 ] + 0 ) & 0xFFFFFFFF )
				:set j ( $j + 5 )
			}
			:set j 5
			:for i from=0 to=15 do={
				:set x ( [ :tonum [ :pick $lWordArray ( ( ( [ :tonum $j ] + 0 ) & 15 ) + $chuckoffset) ] ] + 0 )
				:set T ( [ :tonum [ :pick $k ( $i + 32 ) ] ] + 0 )
				:set S ( [ :tonum [ :pick $s3 ( $i & 3 ) ] ] + 0 )
				:set tmp1 ( ( ( $b ^ $c ^ $d ) + $a + $T + $x ) & 0xFFFFFFFF )
				:set tmp1 (((tmp1 << $S ) | (($tmp1 >> (32 - $S)))) & 0xFFFFFFFF)
				:set tmp1 ( ( $tmp1 + $b ) & 0xFFFFFFFF )
				:set a ( ( [ :tonum $d ] + 0) & 0xFFFFFFFF )
				:set d ( ( [ :tonum $c ] + 0) & 0xFFFFFFFF )
				:set c ( ( [ :tonum $b ] + 0) & 0xFFFFFFFF )
				:set b ( ( [ :tonum $tmp1 ] + 0) & 0xFFFFFFFF )
				:set j ( $j + 3 )
			}
			:set j 0
			:for i from=0 to=15 do={
				:set x ( [ :tonum [ :pick $lWordArray	( ( ( [ :tonum $j ] + 0 ) & 15 ) + $chuckoffset ) ] ] + 0 )
				:set T ( [ :tonum [ :pick $k ( $i + 48 ) ] ] + 0 )
				:set S ( [ :tonum [ :pick $s4 ( $i & 3 ) ] ] + 0 )
				:set tmp1 ( ( $c ^ ( $b | ( -1 * ( $d + 1 ) ) ) ) & 0xFFFFFFFF )
				:set tmp1 ( ( $tmp1 + $a + $T + $x ) & 0xFFFFFFFF )
				:set tmp1 ( ((tmp1 << $S ) | (($tmp1 >> (32 - $S)))) & 0xFFFFFFFF )
				:set tmp1 ( ( $tmp1 + $b ) & 0xFFFFFFFF )			
				:set a ( ( [ :tonum $d ] + 0) & 0xFFFFFFFF )
				:set d ( ( [ :tonum $c ] + 0) & 0xFFFFFFFF )
				:set c ( ( [ :tonum $b ] + 0) & 0xFFFFFFFF )
				:set b ( ( [ :tonum $tmp1 ] + 0) & 0xFFFFFFFF )
				:set j ( $j + 7 )
			}
			:set a ( ( $a + $AA ) & 0xFFFFFFFF )		
			:set b ( ( $b + $BB ) & 0xFFFFFFFF )		
			:set c ( ( $c + $CC ) & 0xFFFFFFFF )		
			:set d ( ( $d + $DD ) & 0xFFFFFFFF ) 
			:set iteration ( $iteration +1 ) 
		}
	
		:set arrMd5State [ :toarray "$a, $b, $c, $d" ]
		:set sMd5Hash ""
		:set sMd5Output ""
		:set iDec 0
		:set iMd5State 0
		:set sHex ""
		:for i from=0 to=3 do={
			:set iMd5State [ :pick $arrMd5State $i ]			
			:for j from=0 to=3 do={
				:set iMd5State ( [ :tonum $iMd5State ] & 0xFFFFFFFF )
				:if ( $j < 1 ) do={
					 :set iDec ( [ :tonum $iMd5State ] & 255 )
				} else={
					:set iDec ( ( $iMd5State & 0x7FFFFFFE ) / ( 2 << ( ( $j * 8 ) - 1 ) ) )
					:if ( ( $iMd5State & 0x80000000 ) > 0 ) do={
						:set iDec ( $iDec | ( 0x40000000 /	( 2 << ( ( $j * 8 ) - 2 ) ) ) )
					}
					:set iDec ( $iDec & 0xFF ) 
				} 
				:set sHex ""
				:for k from=0 to=( 4 * ( $iHexDigit - 1 ) ) step=4 do={
					:set sHex ( [ :pick [ :tostr $strHexValues ] \
					( ( $iDec >> $k ) & 0xF ) \ 
					( ( ( $iDec >> $k ) & 0xF ) + 1 ) ] . $sHex ) 
				}
				:set sHex [ :tostr $sHex ]
				:set sHex [ :pick $sHex ( [ :len $sHex ] - 2 ) [ :len $sHex ] ]
				:set sMd5Output ( $sMd5Output . $sHex )		 
			}
		}
		:return [:tostr $sMd5Output];
	}
	:set ($MtmSM0->$classId) $s;
}
