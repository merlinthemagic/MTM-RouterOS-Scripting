:set ($s->"getById") do={
	:global MtmFacts;
	:return [($MtmFacts->"getNull")];
}
:set ($s->"getAll") do={
	:return [:toarray ""];
}
:set ($s->"getAllHardware") do={
	:return [:toarray ""];
}
:set ($s->"getByName") do={
	:global MtmFacts;
	:return [($MtmFacts->"getNull")];
}