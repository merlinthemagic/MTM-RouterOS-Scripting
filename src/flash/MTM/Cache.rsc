:global MtmCache;
:if ($MtmCache = nil) do={

	#cache functions that are heavily used
	:global MtmFacts;
	
	:local s [:toarray ""];
	:local class;
	
	:set class [($MtmFacts->"execute") nsStr="getTools()->getTime()->getEpoch()"];
	:set ($s->"currentEpoch") ($class->"getCurrent");
	
	:set class [($MtmFacts->"execute") nsStr="getTools()->getStrings()"];
	:set ($s->"strReplace") ($class->"replace");
	
	:set class [($MtmFacts->"execute") nsStr="getTools()->getParsing()->getPrimitives()"];
	:set ($s->"isEmpty") ($class->"isEmpty");
	
	:set MtmCache $s;
}