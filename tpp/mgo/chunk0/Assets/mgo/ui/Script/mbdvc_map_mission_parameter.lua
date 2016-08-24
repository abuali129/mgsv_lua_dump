local e={AFC0=101,AFN0=102,AFDA=103,AFC1=104,CUBA=105,RMA0=113,SVA0=112}local t={DOM=1,TDM=2,TSNE=3,DOMB=101,TDMB=102,TSNEB=103}local r=function(e)return(e==t.DOMB or e==t.TDMB)or e==t.TSNEB
end
mbdvc_map_mission_parameter={GetMissionParameter=function(o,t)if(t==e.AFN0)then
if(r(o))then
return{missionArea2={{name="innerZone",vertices={Vector3(72.790382385254,0,-129.25531005859),Vector3(112.93570709229,0,-145.98811340332),Vector3(131.20300292969,0,-143.28408813477),Vector3(160.09149169922,0,-148.08233642578),Vector3(160.54011535645,0,17.918731689453),Vector3(20.247528076172,0,18.069107055664),Vector3(14.505950927734,0,7.7460250854492),Vector3(47.317375183105,0,-55.677024841309),Vector3(35.731815338135,0,-85.711441040039),Vector3(46.765632629395,0,-126.45108795166)}}},safetyArea2={},missionStartPoint={},heliLandPoint={}}end
elseif(t==e.AFC0)then
if(r(o))then
return{missionArea2={{name="innerZone",vertices={Vector3(79.57006072998,27.891048431396,-155.8875579834),Vector3(93.013198852539,27.891038894653,-143.66361999512),Vector3(80.820976257324,27.891042709351,-66.583984375),Vector3(67.28247833252,27.891044616699,-58.418823242188),Vector3(50.800861358643,27.891044616699,-62.498550415039),Vector3(29.759170532227,27.891046524048,-49.802276611328),Vector3(26.095596313477,27.891050338745,-51.248580932617),Vector3(16.275505065918,27.891046524048,-46.986389160156),Vector3(-14.81379699707,27.89105796814,-44.337158203125),Vector3(-43.452209472656,27.89105796814,-48.2177734375),Vector3(-47.387619018555,27.891048431396,-59.558349609375),Vector3(-59.2216796875,27.891050338745,-68.413757324219),Vector3(-77.149337768555,27.891046524048,-78.951889038086),Vector3(-76.400970458984,27.891046524048,-80.292388916016),Vector3(-86.304458618164,27.891050338745,-85.835968017578),Vector3(-83.840057373047,27.891046524048,-90.30549621582),Vector3(-122.263671875,27.891031265259,-111.49429321289),Vector3(-127.71429443359,27.89102935791,-176.58778381348),Vector3(-86.852233886719,27.891017913818,-206.43173217773),Vector3(-24.968475341797,27.891017913818,-212.72106933594),Vector3(19.899444580078,27.89101600647,-198.47399902344)}}},safetyArea2={},missionStartPoint={},heliLandPoint={}}end
elseif(t==e.AFDA)then
if(r(o))then
return{missionArea2={{name="innerZone",vertices={Vector3(-110.158,32,-34.505786895752),Vector3(-102.046,27,-40.719142913818),Vector3(-87.541351318359,27,-39.957702636719),Vector3(-74.000015258789,25,-43.860008239746),Vector3(-71.164169311523,24,-48.574977874756),Vector3(-37.461730957031,14,-50.389434814453),Vector3(-29.539794921875,14,-41.958030700684),Vector3(-8.4429397583008,22,-39.549850463867),Vector3(24.695755004883,24,-38.959606170654),Vector3(26.552,33.016,-42.965),Vector3(42.335357666016,26,-51.221824645996),Vector3(42.568832397461,24,-56.400676727295),Vector3(47.685745239258,24,-56.385841369629),Vector3(47.635025024414,24,-60.142414093018),Vector3(68.805,33.009,-59.756),Vector3(68.869,32.971,-65.663),Vector3(79.630004882813,25,-75.108253479004),Vector3(108.73824310303,38,-60.24870300293),Vector3(113.07128143311,43,7.9898567199707),Vector3(68.730842590332,32,119.35121917725),Vector3(-15.240715026855,18,129.77258300781),Vector3(-47.300575256348,29,131.53692626953),Vector3(-106.23805999756,37,79.094245910645),Vector3(-119.80769348145,41,55.102958679199)}}},safetyArea2={},missionStartPoint={},heliLandPoint={}}end
elseif(t==e.AFC1)then
elseif(t==e.RMA0)then
if(r(o))then
return{missionArea2={{name="innerZone",vertices={Vector3(-882.22552490234,0,1911.9719238281),Vector3(-909.01788330078,0,1955.6931152344),Vector3(-844.54180908203,0,1995.2041015625),Vector3(-817.74945068359,0,1951.4829101563)}}},safetyArea2={},missionStartPoint={},heliLandPoint={}}else
return{missionArea2={{name="innerZone",vertices={Vector3(-694.36669921875,323.0993347168,1944.8240966797),Vector3(-864.10333251953,323.09936523438,1807.2496337891),Vector3(-922.18597412109,323.09936523438,1818.2315673828),Vector3(-929.65734863281,323.09942626953,1867.0939941406),Vector3(-950.21270751953,323.09951782227,1897.1560058594),Vector3(-958.95031738281,323.09951782227,1945.9458007813),Vector3(-938.84967041016,323.09951782227,1980.9141845703),Vector3(-906.28393554688,323.09954833984,1988.3245849609),Vector3(-870.20751953125,323.09954833984,2051.0349121094),Vector3(-827.97546386719,323.09948730469,2065.8664550781),Vector3(-788.42181396484,323.09948730469,2058.5305175781),Vector3(-723.11492919922,323.09942626953,2008.5479736328),Vector3(-724.86175537109,323.0993347168,1990.388671875)}}},safetyArea2={},missionStartPoint={},heliLandPoint={}}end
elseif(t==e.CUBA)then
if(r(o))then
return{missionArea2={{name="innerZone",vertices={Vector3(-131.79692077637,44.759140014648,27.352298736572),Vector3(-182.23425292969,31.070711135864,27.220024108887),Vector3(-185.55436706543,31.070711135864,27.221696853638),Vector3(-185.55093383789,31.070711135864,24.377834320068),Vector3(-202.51397705078,31.070711135864,24.379730224609),Vector3(-202.69755554199,31.057905197144,-57.707733154297),Vector3(-75.984085083008,31.057905197144,-57.796569824219),Vector3(-75.829467773438,44.759140014648,-12.44123840332),Vector3(-73.158103942871,44.759140014648,-9.7698745727539),Vector3(-73.158103942871,44.759140014648,-5.9919929504395),Vector3(-66.979454040527,31.057905197144,-6.0512084960938),Vector3(-66.945449829102,31.057905197144,22.770696640015),Vector3(-69.256820678711,31.057905197144,22.777006149292),Vector3(-69.264373779297,31.080007553101,31.842800140381),Vector3(-102.6586227417,31.080007553101,31.809764862061),Vector3(-102.66142272949,31.080007553101,23.951457977295),Vector3(-122.67630767822,44.759140014648,23.948183059692),Vector3(-122.67630767822,44.759140014648,27.352294921875),Vector3(-125.34767150879,44.759140014648,30.02366065979),Vector3(-129.1255645752,44.759140014648,30.02366065979),Vector3(-131.79692077637,44.759140014648,27.352298736572)}}},safetyArea2={},missionStartPoint={},heliLandPoint={}}end
elseif(t==e.SVA0)then
if(r(o))then
return{missionArea2={{name="innerZone",vertices={Vector3(838.05755615234,-23.371030807495,-278.33193969727),Vector3(968.57543945313,-23.371030807495,-278.33193969727),Vector3(968.57543945313,-23.371030807495,-86.816650390625),Vector3(838.0576171875,-23.371030807495,-86.816650390625),Vector3(838.05755615234,-23.371030807495,-278.33193969727)}}},safetyArea2={},missionStartPoint={},heliLandPoint={}}else
return{missionArea2={{name="innerZone",vertices={Vector3(794.46801757813,-23.371030807495,-278.33193969727),Vector3(1090.5544433594,-23.371030807495,-278.33193969727),Vector3(1090.5544433594,-23.371030807495,-23.278472900391),Vector3(794.46801757813,-23.371030807495,-23.278472900391),Vector3(794.46801757813,-23.371030807495,-278.33193969727)}}},safetyArea2={},missionStartPoint={},heliLandPoint={}}end
end
return{}end,GetMissionParameter2=function(t,e)local r={}local r={}local e=mbdvc_map_mission_parameter.GetMissionParameter(t,e)return e
end}