:set ($s->"addJob") do={

	#this method will store the data for the trigger to process but not kick off the trigger
	
	:global MtmFacts;
	:global MtmCache;
	:local method "Utility->Fetch->Upload->addJob";
	:if ($0 = nil || $1 = nil || $2 = nil || $3 = nil || $4 = nil || $5 = nil) do={
		[($MtmFacts->"throwException") method=$method msg=("Url, data, timeout, min-pause, method and data type are mandatory inputs")];
	}
	
	:local jObj [:toarray ""];
	:set ($jObj->"url") $0;  #url
	:set ($jObj->"data") $1;  #data
	:set ($jObj->"timeout") ([($MtmCache->"currentEpoch")] + $2);  #timeout in secs, now epoch
	:set ($jObj->"pause") $3;  #minimum wait between sending attempts
	:set ($jObj->"method") $4;  #upload method
	:set ($jObj->"dataType") $5;  #dataType
	:set ($jObj->"lastTrigger") 0; #last attempt at sending the data

	:global MtmStore;
	:local jStore [($MtmStore->"getStore") "fetchJobs"];
	:local counter ([:len ($jStore->"data")]);
	:set ($jStore->"data"->$counter) $jObj;
	:return 1;
}
:set ($s->"newJob") do={

	#this method will store the data for the trigger to process and kick off the process
	:global |MTMS|;
	:local self ($|MTMS|->"|MTMC|");
	[($self->"addJob") $0 $1 $2 $3 $4 $5];
	#now run the trigger
	[($self->"trigger")];
	:return 1;
}
:set ($s->"trigger") do={

	#this method will store the data and try to send it, if success the item will be cleared out
	#on fail it will stay in cache until success or timeout
	:global MtmFacts;
	:global MtmCache;
	:local method "Utility->Fetch->Upload->trigger";
	
	:global MtmStore;
	:local jStore [($MtmStore->"getStore") "fetchJobs"];
	:local cJobs ($jStore->"data");
	:if ([:len $cJobs] > 0) do={
		:set ($jStore->"data") [:toarray ""];
		:local rId 0;
		:local throw true;
		:local cTime;
		:local fetchTool [($MtmFacts->"execute") nsStr="getTools()->getFetch()->getUpload()"];
		:foreach index,jObj in=$cJobs do={
		
			:set cTime [($MtmCache->"currentEpoch")];
			:if ($jObj->"timeout" > $cTime) do={
				:if ($cTime > ($jObj->"lastTrigger" + $jObj->"pause")) do={
					:set ($jObj->"lastTrigger") $cTime;
					:if ($jObj->"method" = "post" && $jObj->"dataType" = "json") do={
						:do {
							:local result [($fetchTool->"postJson") url=($jObj->"url") data=($jObj->"data") throw=$throw];
							#success
						} on-error={
							#failed
							:set rId [:len ($jStore->"data")];
							:set ($jStore->"data"->$rId) $jObj;
						}

					} else={
						[($MtmFacts->"throwException") method=$method msg=("Method: '".$jObj->"method"."' and dataType: '".$jObj->"dataType"."' not handled")];
					}
				} else= {
					:if (($jObj->"lastTrigger" + $jObj->"pause") < $jObj->"timeout") do={
						#job should not be attempted again so soon
						:set rId [:len ($jStore->"data")];
						:set ($jStore->"data"->$rId) $jObj;
					} else={
						#job will expire before the next retry, no point in storing it
					}
				}
			} else={
				#job expired, drop
			}
		}
	}
	:return true;
}
:set ($s->"getJobCount") do={
	:global MtmStore;
	:local jStore [($MtmStore->"getStore") "fetchJobs"];
	:return [:len ($jStore->"data")];
}