##attributes
:local stpPrios [:toarray ""]
:set ($stpPrios->0) "0x0";
:set ($stpPrios->4096) "0x1000";
:set ($stpPrios->8192) "0x2000";
:set ($stpPrios->12288) "0x3000";
:set ($stpPrios->16384) "0x4000";
:set ($stpPrios->20480) "0x5000";
:set ($stpPrios->24576) "0x6000";
:set ($stpPrios->28672) "0x7000";
:set ($stpPrios->32768) "0x8000";
:set ($stpPrios->36864) "0x9000";
:set ($stpPrios->40960) "0xA000";
:set ($stpPrios->45056) "0xB000";
:set ($stpPrios->49152) "0xC000";
:set ($stpPrios->53248) "0xD000";
:set ($stpPrios->57344) "0xE000";
:set ($stpPrios->61440) "0xF000";

:set ($s->"stpPriorities") $stpPrios;

:local stpPortPrios [:toarray ""]
:set ($stpPortPrios->0) "0x0";
:set ($stpPortPrios->8) "0x10";
:set ($stpPortPrios->32) "0x20";
:set ($stpPortPrios->48) "0x30";
:set ($stpPortPrios->64) "0x40";
:set ($stpPortPrios->80) "0x50";
:set ($stpPortPrios->96) "0x60";
:set ($stpPortPrios->112) "0x70";
:set ($stpPortPrios->128) "0x80";
:set ($stpPortPrios->144) "0x90";
:set ($stpPortPrios->160) "0xA0";
:set ($stpPortPrios->176) "0xB0";
:set ($stpPortPrios->192) "0xC0";
:set ($stpPortPrios->208) "0xD0";
:set ($stpPortPrios->224) "0xE0";
:set ($stpPortPrios->240) "0xF0";

:set ($s->"stpPortPriorities") $stpPortPrios;