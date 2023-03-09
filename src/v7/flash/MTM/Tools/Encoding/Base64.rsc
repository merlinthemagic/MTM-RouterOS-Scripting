:local cPath "MTM/Tools/Encoding/Base64.rsc";
:local s [:toarray ""];
:set ($s->"encode") do={
	
	
	##https://forum.mikrotik.com/viewtopic.php?t=194152
	##needs work, so as not to depend on globals
	
	:global MtmFacts;
	:local cPath "MTM/Tools/Encoding/Base64.rsc/encode";
	:if ([:typeof $0] != "str") do={
		:error ($cPath.": Input has invalid type '".[:typeof $0]."'");
	}
	:local input $0;
	:local mVal "";
	:local tmpHex "";
	:global tmpChar "\00"
	:global chars "";
	
	:for x from=0 to=15 step=1 do={ 
		:for y from=0 to=15 step=1 do={
	   		:set tmpHex ([:pick "0123456789ABCDEF" $x ($x+1)].[:pick "0123456789ABCDEF" $y ($y+1)]);
		  	:set mVal [:parse (":global tmpChar \"\\$tmpHex\"")];
		    :set $chars ($chars.$tmpChar);
		} 
	}
	:set tmpChar
	
	:global chr2int do={:global chars; :if (($1="") or ([:len $1] > 1) or ([:typeof $1] = "nothing")) do={:return -1}; :return [:find $chars $1 -1]}
	
	# RFC 4648 base64 Standard
	:global arrb64 [:toarray "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9,+,/"]
	
	# RFC 4648 base64url URL- and filename-safe standard
	:global arrb64url [:toarray "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9,-,_"]
	
	{
	:local input "Man"
	
	:local v1 [$chr2int [:pick $input 0 1]]
	:local v2 [$chr2int [:pick $input 1 2]]
	:local v3 [$chr2int [:pick $input 2 3]]
	:local f6bit   ($v1 >> 2)
	:local s6bit ((($v1 &  3) * 16) + ($v2 >> 4))
	:local t6bit ((($v2 & 15) *  4) + ($v3 >> 6))
	:local q6bit   ($v3 & 63)
	
		:put "$input = $($arrb64->$f6bit)$($arrb64->$s6bit)$($arrb64->$t6bit)$($arrb64->$q6bit) on Base64 Standard"
	}
	:return [:tostr $sMd5Output];
}
:global MtmToolHashing1;
:set ($MtmToolHashing1->"md5") $s;
