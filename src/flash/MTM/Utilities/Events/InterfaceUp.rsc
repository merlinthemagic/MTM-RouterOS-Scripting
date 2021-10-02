:local classId "utility-events-ifup";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmU;
:if (($MtmU->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"cbs") [:toarray ""];
	:set ($s->"uptimes") [:toarray ""];

	:set ($s->"registerCb") do={

		:global MtmFacts;
		:local method "Utility->Events->InterfaceUp->registerCb";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Callback id is mandatory"];
		}
		:if ($1 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Callback function is mandatory"];
		}
		
		#get Self
		:local self [($MtmFacts->"execute") nsStr="getUtilities()->getEvents()->getInterfaceUp()"];
		
		:local cbId [:tostr $0];
		:local cbFunc $1;
		:set ($self->"cbs"->$cbId) $cbFunc;
		
		:return 1;
	}
	:set ($s->"unregisterCb") do={
		
		:global MtmFacts;
		:local method "Utility->Events->InterfaceUp->unregisterCb";
		:if ($0 = nil) do={
			[($MtmFacts->"throwException") method=$method msg="Callback id is mandatory"];
		}
		#get Self
		:local self [($MtmFacts->"execute") nsStr="getUtilities()->getEvents()->getInterfaceUp()"];
		:set ($self->"cbs"->$0);
		
		:return 1;
	}
	:set ($s->"runOnce") do={
	
		:global MtmFacts;
		
		:local self [($MtmFacts->"execute") nsStr="getUtilities()->getEvents()->getInterfaceUp()"];
		
		:local uptimes ($self->"uptimes");
		:local ifId "";
		:local uptime "";
		:local ifName "";
		:local lastUptime "";

		:foreach id in=[/interface find running=yes] do={
			:set uptime [/interface get $id last-link-up-time];
			
			:set ifId [:tostr $id];
			:set lastUptime ($uptimes->$ifId);
			:if ($lastUptime = nil) do={
				:set ($uptimes->$ifId) $uptime;
				:set $lastUptime $uptime;
			}
			:if ($lastUptime != $uptime) do={
				:set ($uptimes->$ifId) $uptime;
				:foreach i,cb in=($self->"cbs") do={
					:local ifName [/interface get $id name];
					[($cb) $ifName];
				}
			}
			:delay ("0.05s"); #space out the operations a little so the CPU does not spike
		}
		:set ($self->"uptimes") $uptimes;
		
		:return 1;
	}
	:set ($s->"run") do={
	
		:global MtmFacts;
		
		:local interval 10;
		:if ($0 != nil) do={
			:set interval $0;
		}
		
		:local nsStr "getUtilities()->getEvents()->getInterfaceUp()";
		:local self [($MtmFacts->"execute") nsStr=$nsStr];
		
		:local isDone false;
		:while ($isDone = false) do={
			[($self->"runOnce")];
			:delay ($interval."s");
		}
		:return 1;
	}
	:set ($MtmU->$classId) $s;
}
