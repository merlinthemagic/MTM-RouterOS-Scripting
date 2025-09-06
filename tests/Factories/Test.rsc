## /import file-name=flash/tests/Factories/Test.rsc;


:if ([:len [/system script environment find]] > 0) do={
	:local eName;
	:local eVal;
	:foreach id in=[/system script environment find] do={
		:set eName [/system script environment get $id name];
		:set eVal [/system script environment get $id value];
		:put ($eName." :".[:len $eVal]);
	}
	/system script environment remove [ find ];
}

/import flash/MTM/Enable.rsc;
:global MtmFacts;

[($MtmFacts->"setDebug") true];

:local sTime [($MtmFacts->"execute") nsStr="getTools()->getTime()->getEpoch()->getCurrent()"];

:local factObj [($MtmFacts->"execute") nsStr="getIP()->getDhcpClients()"];
:local rObjs [($factObj->"getAll")];
:put ("DHCP Client Count: ".[:len $rObjs]);

:local factObj [($MtmFacts->"execute") nsStr="getIP()->getDhcpServers()"];
:local rObjs [($factObj->"getAll")];
:put ("DHCP Server Count: ".[:len $rObjs]);

:local factObj [($MtmFacts->"execute") nsStr="getRadius()->getClients()"];
:local rObjs [($factObj->"getAll")];
:put ("Radius Client Count: ".[:len $rObjs]);

:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getEthernet()"];
:local rObjs [($factObj->"getAll")];
:put ("Ethernet Count: ".[:len $rObjs]);

:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getWireless()"];
:local rObjs [($factObj->"getAll")];
:put ("WLAN Count: ".[:len $rObjs]);

:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getBridges()"];
:local rObjs [($factObj->"getAll")];
:put ("Bridge Count: ".[:len $rObjs]);

:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getVLAN()"];
:local rObjs [($factObj->"getAll")];
:put ("Vlan Count: ".[:len $rObjs]);

:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getLTE()"];
:local rObjs [($factObj->"getAll")];
:put ("LTE Count: ".[:len $rObjs]);

:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getDot1x()->getServers()"];
:local rObjs [($factObj->"getAll")];
:put ("Dot1X Server Count: ".[:len $rObjs]);

:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getLists()"];
:local rObjs [($factObj->"getAll")];
:put ("List Count: ".[:len $rObjs]);

:local factObj [($MtmFacts->"execute") nsStr="getInterfaces()->getListMembers()"];
:local rObjs [($factObj->"getAll")];
:put ("List Member Count: ".[:len $rObjs]);

:local eTime [($MtmFacts->"execute") nsStr="getTools()->getTime()->getEpoch()->getCurrent()"];
:put ("Duration: ".$eTime-$sTime);
