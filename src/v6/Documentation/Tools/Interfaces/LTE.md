#initialize

```
/import flash/MTM/Enable.rsc;
:global MtmFacts;
:local nsStr "getTools()->getInterfaces()->getLTE()";
:local toolObj [($MtmFacts->"execute") nsStr=$nsStr];

```

## Methods:

Note: does not work with USB modems, only mikrotik mPCIE

### infoOnce:

```
:local name "lte1";

:local result [($toolObj->"infoOnce") $name];
:put ($result); #array of lte attributes;

Example:

:foreach attr,val in=$result do={
	:put ("Attribute: '".$attr."', Value: '".$val."'");
}
##result successful support for info:
#Attribute: 'access-technology', Value: 'Evolved 3G (LTE)'
#Attribute: 'cqi', Value: '9'
#Attribute: 'current-cellid', Value: '5456546'
#Attribute: 'current-operator', Value: 'Verizon'
#Attribute: 'earfcn', Value: '6400 (band 20, bandwidth 10Mhz)'
#Attribute: 'enb-id', Value: '30770'
#Attribute: 'functionality', Value: 'full'
#Attribute: 'imei', Value: '546546546565466'
#Attribute: 'imsi', Value: '756756756756767'
#Attribute: 'infoSupported', Value: 'true'
#Attribute: 'lac', Value: '5566'
#Attribute: 'manufacturer', Value: 'MikroTik'
#Attribute: 'model', Value: 'R11e-4G'
#Attribute: 'phy-cellid', Value: '556'
#Attribute: 'pin-status', Value: 'ok'
#Attribute: 'registration-status', Value: 'roaming'
#Attribute: 'revision', Value: 'R11e-4G_V007'
#Attribute: 'roaming', Value: 'yes'
#Attribute: 'rsrp', Value: '-86dBm'
#Attribute: 'rsrq', Value: '-14dB'
#Attribute: 'rssi', Value: '-65dBm'
#Attribute: 'sector-id', Value: '44'
#Attribute: 'session-uptime', Value: '9h32m25s'
#Attribute: 'sinr', Value: '3dB'
#Attribute: 'subscriber-number', Value: ',"+2134567890",115'

##result fails support for info:
#Attribute: 'infoSupported', Value: 'false'
```
