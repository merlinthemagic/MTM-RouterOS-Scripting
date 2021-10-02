:local classId "utility-fetch-upload";
:global MtmFacts;
:if ($MtmFacts = nil) do={
	:error ($classId.": MTM Factories not loaded");
}
:global MtmU;
:if (($MtmU->$classId) = nil) do={
	
	:local s [:toarray ""];
	:set ($s->"jobs") [:toarray ""];
	
	:set ($s->"addJob") do={
	
		#this method will store the data for the trigger to process but not kick off the trigger
		
		:global MtmFacts;
		:global MtmCache;
		:global MtmU;
		:local method "Utility->Fetch->Upload->addJob";
		:if ($0 = nil || $1 = nil || $2 = nil || $3 = nil || $4 = nil || $5 = nil) do={
			[($MtmFacts->"throwException") method=$method msg=("Url, data, timeout, min-pause, method and data type are mandatory inputs")];
		}
		:local self ($MtmU->"utility-fetch-upload");
		
		:local jObj [:toarray ""];
		:set ($jObj->"url") $0;  #url
		:set ($jObj->"data") $1;  #data
		:set ($jObj->"timeout") ([($MtmCache->"currentEpoch")] + $2);  #timeout in secs, now epoch
		:set ($jObj->"pause") $3;  #minimum wait between sending attempts
		:set ($jObj->"method") $4;  #upload method
		:set ($jObj->"dataType") $5;  #dataType
		:set ($jObj->"lastTrigger") 0; #last attempt at sending the data

		:local counter ([:len ($self->"jobs")]);
		:set ($self->"jobs"->$counter) $jObj;
		
		:return 1;
	}
	:set ($s->"newJob") do={
	
		#this method will store the data for the trigger to process and kick off the process
		:global MtmU;
		:local self ($MtmU->"utility-fetch-upload");
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
		:global MtmU;
		:local method "Utility->Fetch->Upload->trigger";
		
		:local self ($MtmU->"utility-fetch-upload");
		:local cJobs ($self->"jobs");
		:if ([:len $cJobs] > 0) do={
			:local rJobs [:toarray ""];
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
								:set ($rJobs->$rId) $jObj;
								:set rId ($rId + 1);
							}
						} else={
							[($MtmFacts->"throwException") method=$method msg=("Method: '".$jObj->"method"."' and dataType: '".$jObj->"dataType"."' not handled")];
						}
					} else= {
						
						:if (($jObj->"lastTrigger" + $jObj->"pause") < $jObj->"timeout") do={
							#job should not be attempted again so soon
							:set ($rJobs->$rId) $jObj;
							:set rId ($rId + 1);
						} else={
							#job will expire before the next retry, no point in storing it
						}
					}
				} else={
					#job expired, drop
				}
			}
			#set the remaining jobs for next run
			:set ($self->"jobs") $rJobs;
		}
		
		:return 1;
	}
	:set ($s->"getJobCount") do={
		:global MtmU;
		:local self ($MtmU->"utility-fetch-upload");
		:return [:len ($self->"jobs")];
	}
	:set ($MtmU->$classId) $s;
}
