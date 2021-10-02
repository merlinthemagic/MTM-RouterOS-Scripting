:local classId "fact-tools";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmT;
:if (($MtmT->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"getStrings") do={
		:global MtmT2;
		:local classId "tool-strings";
		:if ($MtmT2->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Strings.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT2->$classId);
	}
	:set ($s->"getArrays") do={
		:global MtmT2;
		:local classId "tool-arrays";
		:if ($MtmT2->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Arrays.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT2->$classId);
	}
	:set ($s->"getFiles") do={
		:global MtmT2;
		:local classId "tool-files";
		:if ($MtmT2->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Files.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT2->$classId);
	}
	:set ($s->"getTime") do={
		:global MtmT;
		:local classId "fact-tool-time";
		:if ($MtmT->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Factories/Tools/Time.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT->$classId);
	}
	:set ($s->"getTraceroute") do={
		:global MtmT;
		:local classId "tool-traceroute";
		:if ($MtmT->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Tools/Traceroute.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT->$classId);
	}
	:set ($s->"getInterfaces") do={
		:global MtmT;
		:local classId "fact-tool-ifs";
		:if ($MtmT->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Factories/Tools/Interfaces.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT->$classId);
	}
	:set ($s->"getFetch") do={
		:global MtmTF;
		:local classId "fact-tool-fetch";
		:if ($MtmTF->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Factories/Tools/Fetch.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmTF->$classId);
	}
	:set ($s->"getParsing") do={
		:global MtmT;
		:local classId "fact-tool-parsing";
		:if ($MtmT->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Factories/Tools/Parsing.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT->$classId);
	}
	:set ($s->"getRadius") do={
		:global MtmT;
		:local classId "fact-tool-radius";
		:if ($MtmT->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Factories/Tools/Radius.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT->$classId);
	}
	:set ($s->"getRouting") do={
		:global MtmT;
		:local classId "fact-tool-routing";
		:if ($MtmT->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Factories/Tools/Routing.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT->$classId);
	}
	:set ($s->"getGuids") do={
		:global MtmT2;
		:local classId "fact-tool-guids";
		:if ($MtmT2->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Factories/Tools/Guids.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT2->$classId);
	}
	:set ($s->"getHashing") do={
		:global MtmT2;
		:local classId "fact-tool-hash";
		:if ($MtmT2->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Factories/Tools/Hashing.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT2->$classId);
	}
	:set ($s->"getObjects") do={
		:global MtmT;
		:local classId "fact-tool-objs";
		:if ($MtmT->$classId = nil) do={
			:global MtmFacts;
			:local path ([($MtmFacts->"getMtmPath")]."Factories/Tools/Objects.rsc");
			[($MtmFacts->"importFile") $path];
		}
		:return ($MtmT->$classId);
	}
	:set ($MtmT->$classId) $s;
}
