:local classId "tool-parsing-json-dec";
:global MtmSM0; ##too large cant split
:if (($MtmSM0->$classId) = nil) do={

	:local s [:toarray ""];
	:set ($s->"getFromString") do={
	
		:global MtmFacts;
		:local method "Tools->Parsing->JsonDecode->getFromString";
		:local param1;
		:if ($0 != nil) do={
			:set param1 $0;
		} else={
			:if ($data != nil) do={
				:set param1 $data;
			} else={
				[($MtmFacts->"throwException") method=$method msg="Data is mandatory"];
			}
		}
	
		:local isDone false;
		:local cPos 0; ##current position
		:local lPos ([:len $param1] - 1); # last position
		:local cData [:toarray ""]; ##string as array
	
		##make into char array
		:set isDone false;
		:while ($isDone = false) do={
			:set ($cData->$cPos) [:pick $param1 $cPos];
			:if ($cPos = $lPos) do={
				:set isDone true;
			} else={
				:set cPos ($cPos + 1);
			}
		}
		
		:local pDP [:toarray ""]; #parent data
		:local dPs [:toarray ""]; #data stack
		:local dPt [:toarray ""]; #data stack temp
		:local dP [:toarray ""]; #current data
		:set ($dP->"type") "";
		:set ($dP->"mode") "";
		:set ($dP->"prop") "";
		:set ($dP->"propType") "";
		:set ($dP->"val") "";
		:set ($dP->"valType") "";
		:set ($dP->"vals") [:toarray ""];
	
		:local nCh ""; #next char
		:local cCh ""; #current char
		:local lCh ""; #last char
		
		:foreach in,ch in=$cData do={
			:set isDone false;
			:set cCh $ch;
			
			:if ($cCh = "{" || $cCh = "}" || $cCh = "[" || $cCh = "]" || $cCh = "\\" || $cCh = "\"" || $cCh = ":" || $cCh = ",") do={
			
				:if ($isDone = false) do={
					:if ($lCh = "\\") do={
						##escaped special char
						:if (($dP->"mode") = "prop") do={
							:set ($dP->"prop") (($dP->"prop").$cCh);
						}
						:if (($dP->"mode") = "val") do={
							:set ($dP->"val") (($dP->"val").$cCh);
						}
						:set cCh ""; ##if this current char is also a backslash we need to clear the last memory as it was purely escaping
						:set isDone true;
					}
				}
				:if ($isDone = false) do={
					:if ($cCh = "{" || $cCh = "[") do={
						##starting a new nested data structure
	
						:if (($dP->"prop") != "") do={
							
							##child creation
							:set ($dPs->([:len $dPs])) $dP;
							:set dP [:toarray ""];
							:set ($dP->"type") "";
							:set ($dP->"mode") "";
							:set ($dP->"prop") "";
							:set ($dP->"propType") "";
							:set ($dP->"val") "";
							:set ($dP->"valType") "";
							:set ($dP->"vals") [:toarray ""];
						}
	
						:if ($cCh = "{") do={
							:set ($dP->"type") "obj";
							:set ($dP->"propType") "str";
							:set ($dP->"prop") "";
						}
						:if ($cCh = "[") do={
							:set ($dP->"type") "arr";
							:set ($dP->"propType") "num";
							:set ($dP->"prop") 0;
							
						}
						:set isDone true;
					}
				}	
				:if ($isDone = false) do={
					:if ($cCh = "}" || $cCh = "]") do={
						##ending a nested data structure
						
						:if (($dP->"mode") = "val") do={
							##capture last value, could be its not delimited by a \" e.g. a number
							:if ([:tostr [:tonum ($dP->"val")]] = ($dP->"val")) do={
								:set ($dP->"val") [:tonum ($dP->"val")];
							}
							:set ($dP->"vals"->($dP->"prop")) ($dP->"val");
							:set ($dP->"mode") "";
						}
						
						:if ([:len $dPs] > 0) do={
							##there is a parent obj
							:set pDP ($dPs->([:len $dPs] - 1));
							:set ($pDP->"vals"->($pDP->"prop")) ($dP->"vals");
							:set dP $pDP;
							
							##remove element from array, a pain currently
							:set ($dPs->([:len $dPs] - 1));
							:set dPt [:toarray ""];
							:foreach tdP in=$dPs do={
								:if ([:type $tdP] != "nothing") do={
									:set ($dPt->([:len $dPt])) $tdP;
								}
							}
							:set dPs $dPt;
							:set pDP [:toarray ""];
							:set ($dP->"prop") "";
							:set ($dP->"propType") "";
						}
						:set isDone true;
					}
				}
				:if ($isDone = false) do={
					:if ($cCh = "\"") do={
						:if (($dP->"type") = "arr") do={
							:if (($dP->"mode") = "val") do={
								:set ($dP->"vals"->($dP->"prop")) ($dP->"val");
								:set ($dP->"prop") (($dP->"prop") + 1);
								:set ($dP->"val") "";
								:set ($dP->"valType") "";
								:set ($dP->"mode") "";
							} else={
								:set ($dP->"mode") "val";
							}
						}
						:if (($dP->"type") = "obj") do={
							:if (($dP->"mode") = "") do={
								:if (($dP->"prop") = "") do={
									:set ($dP->"mode") "prop";
								} else={
									:set ($dP->"mode") "val";
								}
							} else={
								:if (($dP->"mode") = "val") do={
									:set ($dP->"vals"->($dP->"prop")) ($dP->"val");
									:set ($dP->"prop") "";
									:set ($dP->"val") "";
									:set ($dP->"valType") "";
								}
								:set ($dP->"mode") "";
							}
						}
						:set isDone true;
					}
				}
				:if ($isDone = false) do={
					:if ($cCh = ":") do={
						:if (($dP->"mode") = "" && $in < $lPos) do={
							:set nCh ($cData->($in + 1));
							:if ([:tostr [:tonum $nCh]] = $nCh) do={
								##value is number so there will be no open/close quotes
								:set ($dP->"mode") "val";
								:set ($dP->"valType") "num";
								:set isDone true;
							}	
						}
					}
				}
				:if ($isDone = false) do={
					:if ($cCh = ",") do={
						##is the current value we are gathering a number? that will not be bounded by a \"
						:if (($dP->"mode") = "val" && ($dP->"valType") = "num") do={
							:set ($dP->"vals"->($dP->"prop")) [:tonum ($dP->"val")];
							:set ($dP->"prop") "";
							:set ($dP->"val") "";
							:set ($dP->"valType") "";
							:set isDone true;
						}
						
						:if ($isDone = false) do={
							##is the next value a number? that will not be bounded by a \"
							:if (($dP->"mode") = "" && $in < $lPos) do={
								:set nCh ($cData->($in + 1));
								:if ([:tostr [:tonum $nCh]] = $nCh) do={
									##value is number so there will be no open/close quotes
									:set ($dP->"mode") "val";
									:set ($dP->"valType") "num";
									:set isDone true;
								}	
							}
						}
					}
				}
			}
			:if ($isDone = false) do={
				:if (($dP->"mode") = "prop") do={
					:set ($dP->"prop") (($dP->"prop").$cCh);
				}
				:if (($dP->"mode") = "val") do={
					:set ($dP->"val") (($dP->"val").$cCh);
				}
			}
			:set lCh $cCh;
		}
		:return ($dP->"vals");
	}
	:set ($MtmSM0->$classId) $s;
}