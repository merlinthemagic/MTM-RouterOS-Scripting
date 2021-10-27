:set ($s->"getCurrent") do={

	:global MtmFacts;
	:local method "Tools->Time->Epoch->getCurrent";
	:local time [:tostr ([/system clock get date]." ".[/system clock get time])];
	:local format "m/d/Y h:i:s";
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	:return [($self->"getFromFormat") $format $time];
}
:set ($s->"getFromFormat") do={

	:global MtmFacts;
	:local method "Tools->Time->Epoch->getFromFormat";
	
	:if ($0 = nil || $1 = nil) do={
		[($MtmFacts->"throwException") method=$method msg="Format and time are mandatory"];
	}
	:if ($0 = "m/d/Y h:i:s") do={
		#Logic stolen from: https://forum.mikrotik.com/viewtopic.php?t=75555
		
		:if ([:pick $1 7 11] < 2000) do={
			[($MtmFacts->"throwException") method=$method msg="We cannot handle dates before the year 2000"];
		}
		#days elapsed since beginning of year at start of month
		:local d {"jan"=0;"feb"=31;"mar"=60;"apr"=91;"may"=121;"jun"=152;"jul"=182;"aug"=213;"sep"=244;"oct"=274;"nov"=305;"dec"=335}
		:set d ($d->[:pick $1 0 3]);
		:if (($d != "jan" && $d != "feb") && (([:pick $1 9 11] - 1) / 4) = ([:pick $1 9 11] / 4)) do={
			##its past feb in a non leap year, so feb only had 28 days
			:set d ($d - 1);
		}
		#add up all the days
		:set d ($d + ([:pick $1 9 11] * 365) + (([:pick $1 9 11] - 1) / 4) +[:pick $1 4 6]);
		#convert to seconds
		:set d ($d * 24 * 60 * 60);
		#add the hours, min and secs
		:set d ($d + ([:pick $1 12 14] * 60 * 60) + ([:pick $1 15 17] * 60) + [:pick $1 18 20]);
		#add jan 1s 2000 in unix, and subtract the offset to gmt for our timezone
		:set d ($d + 946684800 - [/system clock get gmt-offset]);
		:if ($d < 1) do={
			##happens when the GMT offset is not UTC?
			[($MtmFacts->"throwException") method=$method msg=("Failed to produce epoch: ".$d)];
		}
		:return $d;
	}
	[($MtmFacts->"throwException") method=$method msg=("Invalid format: '".$0."'")];
}