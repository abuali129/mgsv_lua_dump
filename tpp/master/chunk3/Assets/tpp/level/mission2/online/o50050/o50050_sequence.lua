local this = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local SVarsIsSynchronized = TppScriptVars.SVarsIsSynchronized
local IsTypeTable = Tpp.IsTypeTable
local IsTypeString = Tpp.IsTypeString
local TppServerManager = TppServerManager

local sequences = {}

this.MAX_PLACED_LOCATOR_COUNT 	= 128	
this.NO_MISSION_TELOP_ON_START_HELICOPTER = true 
this.NO_MISSION_CLEAR_RANK = true		
this.HELICOPTER_DOOR_OPEN_TIME_SEC = 10

local PATCH_VERSION_DAY1 = 10



local LIMIT_TIME_PER_PLNT = 60 * 6
local OF_PLAYER_ID = 0
local DF_PLAYER_ID = 1
local ALARM_TIME = 10
local RANGE_ALRM_LV01 = 2			
local RANGE_ALRM_LV03 = 3			
local TIME_ALRM_LV01 = 10			
local TIME_ALRM_LV03 = 10			
local RESPAWN_CAMERA_DISTANCE = 5	
local TIME_DF_START_SEARCH_SEC = 30

local GMP_FOR_RANSOM_FULTON		= 20000							
local GMP_FOR_RANSOM_DEAD		= GMP_FOR_RANSOM_FULTON / 4		
local GMP_FOR_RANSOM_FULTON_DD	= GMP_FOR_RANSOM_FULTON / 2		
local GMP_FOR_RANSOM_DEAD_DD	= GMP_FOR_RANSOM_DEAD / 2		

local HERO_FOR_FULTON		= 50								
local HERO_FOR_KILL			= 0									
local HERO_FOR_FULTON_DD	= 20								
local HERO_FOR_KILL_DD		= 0									

local HERO_FOR_FULTON_PRACTICE		= HERO_FOR_FULTON / 10		
local HERO_FOR_KILL_PRACTICE		= HERO_FOR_KILL / 10		
local HERO_FOR_FULTON_DD_PRACTICE	= HERO_FOR_FULTON_DD / 10	
local HERO_FOR_KILL_DD_PRACTICE		= HERO_FOR_KILL_DD / 10		


local GMP_FOR_RANSOM_DEFAULT = 20000							
local GMP_FOR_RANSOM_FULTON_BONUS = 1.5							

local GMP_FOR_RANSOM_MAX = 100000								


local PlayerDisableActionFlagMtbsDefault = PlayerDisableAction.CQC_KNIFE_KILL + PlayerDisableAction.CQC_INTERROGATE + PlayerDisableAction.KILLING_WEAPON
local PlayerDisableActionModeSham = PlayerDisableAction.BLOOD_EFFECT


local CLEAR_TYPE_RESULT_GOAL = 1
local CLEAR_TYPE_RESULT_ABORT = 2



local ESPT_OF_SNEAK_DAY = 50
local ESPT_OF_ABORT = -500

local ESPT_OF_NPC_COUNT = 2

local ESPT_OF_ALERT_COUNT = 30
local ESPT_OF_PLANT_COUNT = 15

local ESPT_OF_NO_ALERT = 2
local ESPT_OF_NO_KILL = 5
local ESPT_OF_NO_REFLEX = 3


local ESPT_OF_FLUTON_CNTN = 5
local ESPT_OF_FLUTON_PTWP = 5
local ESPT_OF_PICK_SCGJ = 1
local ESPT_OF_FLUTON_DDS = 5

local ESPT_OF_DESTROY_PTWP = 2
local ESPT_OF_DESTROY_SCGJ = 1
local ESPT_OF_KILL_DDS = 2

local ESPT_OF_KILL_DFP = 60
local ESPT_OF_FLUTON_DFP = 100



local ESPT_OF_DOWNED = 10
local ESPT_DF_DOWN_OFP = 10

local ESPT_DOWN_COUNT_LIMIT = 10

local ESPT_DF_MARK_OFP_COUNT = 50
local ESPT_DF_PLANT_COUNT = -20

local ESPT_DF_SAVE_CNTN = 2
local ESPT_DF_SAVE_PTWP = 2
local ESPT_DF_SAVE_SEC = 1
local ESPT_DF_SAVE_DDS = 2


local ESPT_DF_KILL_OFP = 120
local ESPT_DF_FULTON_OFP = 200
local ESPT_DF_FULTONED = 10
local ESPT_DF_DEAD = 10



 
local OF_TOTAL_RESULT_MIN= 0
local OF_TOTAL_SNEAK_MIN= 0
local OF_TOTAL_COLLECT_MIN= 0
local OF_TOTAL_DESTROY_MIN= -100
local OF_TOTAL_VERSUS_MIN= 0
local DF_TOTAL_RESULT_MIN= 0
local DF_TOTAL_COLLECT_MIN= 0
local DF_TOTAL_VERSUS_MIN= 0

 
local ESPT_SOLDIER_COUNT_MAX = 36	
local ESPT_PRACTICE_PARAM = 0		




this.REVENGE_POINT = {

	SNEAKING_FOB = 20,
	DESTROY_SEC_GADJET = 2,
	FULTON_PUT_WEAPON = 2,
	DESTROY_PUT_WEAPON = 2,
	FULTON_CONTAINER = 5,
	FULTON_STAFF = 30,
	KILL_STAFF = 30,
	FULTON_PLAYER = 150,
	KILL_PLAYER = 150,
	MAX = 252,
}





this.TIME_LIMIT = {
	NON_ABORT = 5 * 60, 
	CAUTION_TIME_SEC = 3 * 60, 
	EACH_PLNT_FOR_FREE = 5*60,	 
	VISITING = 5*60,	 
}

this.TIME_LIMIT_RANK = {
	NONE = 1920,
	F	 = 1800,	
	E	 = 1680,	
	D	 = 1560,	
	C	 = 1440,	
	B	 = 1320,	
	A	 = 1080,	
	S	 = 600,		
}


this.TIME_LIMIT_LIST = {
	timeLimitforSneaking 	= { 
		TimeSec = this.TIME_LIMIT.CAUTION_TIME_SEC,
		HostTimeCountLang = "timeCount_50050_00",
		ClientTimeCountLang = "timeCount_50050_01"
	},
	timeLimitforNonAbort 	= { 
		TimeSec = this.TIME_LIMIT.NON_ABORT,
		HostTimeCountLang = "timeCount_50050_10",
		ClientTimeCountLang = "timeCount_50050_11"
	},
	timeLimitforVisiting 	= { 
		TimeSec = this.TIME_LIMIT.CAUTION_TIME_SEC,
		HostTimeCountLang = "timeCount_50050_20",
	},
}


this.CP_NAME = {
	"mtbs_command_cp",
	"mtbs_combat_cp",
	"mtbs_develop_cp",
	"mtbs_support_cp",
	"mtbs_medic_cp",
	"mtbs_intel_cp",
	"mtbs_basedev_cp",
}


this.CLST_PARAM = {}



this.OCEAN_LIST = {

	ocean_area_0  = { 1 },				
	ocean_area_10 = { 10,11 },			
	ocean_area_20 = { 20,21 },			
	ocean_area_30 = { 30,31,32 },		
	ocean_area_40 = { 40,41,42 },		
	ocean_area_50 = { 50,51,52,53 },	
	ocean_area_60 = { 60,61,62,63 },	
	ocean_area_70 = { 70,71 },			
}





local numLayout = 0


this.missionVarsList = {
	isHost = false,			
	numStartPoint = 0,			
	numClusterId = 100,			
	isDisableAbortTime = false,
	DEBUG_isNoRestart = false,	
	respawnPlayerPos = {},
	respawnPlayerRotY = 0,
	numDisableRespawnTime = 10,
	isAbortFromWhole = false,
	abortPointTrapList = {},
	numBurglarAlarmRange = 0,
	numBurglarAlarmTime = 0,
	respawnPosList = {},
	DEBUG_noGoal = false,
	respawnTimeCount = 0,
	respawnTimeCountList = {},
	numSearchingDefenceTime = 0,
	mbContainer_placedCountTotal = 0,
	mbIrSensor_placedCountTotal = 0,
	mbMortar_placedCountTotal = 0,
	mbEastTurret_placedCountTotal = 0,
	mbWestTurret_placedCountTotal = 0,
	mbEastAAG_placedCountTotal = 0,
	mbWestAAG_placedCountTotal = 0,
	mbNuclearContainer_placedCountTotal = 0,
	mbStolenAlarm_placedCountTotal = 0,
	isClientSessionStart = false,
	fultonInfo = {},
	isDoneWarpToHeli = false,
	isOccuredPlayerDamage = false,
	isDoCrime = false,
	isBootedVersusMode = false,
	warpPlayerPos = {},
	warpPlayerRotY = 0,
	isFinishRetryDelay = false,
	isDefiniteRetryPractice = false,
	isCallStaffDeadRadio = false,
}









this.saveVarsList = {
	isCanOpenRevengeWarmhole = false,
	isHostSingle						= true,	
	fob_isHostGameStart					= { name = "fob_isHostGameStart",	type = TppScriptVars.TYPE_BOOL,		value = false,	save = true, sync = true,	wait = true, category = TppScriptVars.CATEGORY_MISSION },
	isGameStartWithDefence				= { name = "isGameStartWithDefence",type = TppScriptVars.TYPE_BOOL,		value = false,	save = true, sync = true,	wait = true, category = TppScriptVars.CATEGORY_MISSION },
	numRevengePoint						= 0,		
	timeLimitforSneaking				= { name = "timeLimitforSneaking", type = TppScriptVars.TYPE_UINT32,  value = this.TIME_LIMIT_RANK.F, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },		
	timeLimitforNonAbort				= { name = "timeLimitforNonAbort", type = TppScriptVars.TYPE_UINT32,  value = this.TIME_LIMIT.NON_ABORT, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },		
	fobIsAllResultSVarsSynced			= { name = "fobIsAllResultSVarsSynced", type = TppScriptVars.TYPE_BOOL,  value = false, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobIsHostWin						= { name = "fobIsHostWin", type = TppScriptVars.TYPE_BOOL,	value = false, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobCaptureHostageCount				= { name = "fobCaptureHostageCount", type = TppScriptVars.TYPE_UINT16,	value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobCaptureSoldierOwnerCount			= { name = "fobCaptureSoldierOwnerCount", type = TppScriptVars.TYPE_UINT16,	value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobCaptureSoldierSupporterCount		= { name = "fobCaptureSoldierSupporterCount", type = TppScriptVars.TYPE_UINT16,	value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobCaptureFuelCount					= { name = "fobCaptureFuelCount", type = TppScriptVars.TYPE_UINT16,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobCaptureBiologicalResourceCount	= { name = "fobCaptureBiologicalResourceCount", type = TppScriptVars.TYPE_UINT16,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobCaptureCommonMetalCount			= { name = "fobCaptureCommonMetalCount", type = TppScriptVars.TYPE_UINT16,	value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobCaptureMinorMetalCount			= { name = "fobCaptureMinorMetalCount", type = TppScriptVars.TYPE_UINT16,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobCapturePreciousMetalCount		= { name = "fobCapturePreciousMetalCount", type = TppScriptVars.TYPE_UINT16,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobRescueStaffCount					= { name = "fobRescueStaffCount", type = TppScriptVars.TYPE_UINT16,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobRewardRank						= { name = "fobRewardRank", type = TppScriptVars.TYPE_UINT16,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobCluster							= { name = "fobCluster", type = TppScriptVars.TYPE_UINT16,	value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobRandomSeed						= { name = "fobRandomSeed", type = TppScriptVars.TYPE_UINT32,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobRewardStaffBaseRank				= { name = "fobRewardStaffBaseRank", type = TppScriptVars.TYPE_UINT32,	value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobStaffDeadOwnerCount				= { name = "fobStaffDeadOwnerCount", type = TppScriptVars.TYPE_UINT32,	value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobStaffDeadSupporterCount			= { name = "fobStaffDeadSupporterCount", type = TppScriptVars.TYPE_UINT32,	value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobStaffInjuryOwnerCount			= { name = "fobStaffInjuryOwnerCount", type = TppScriptVars.TYPE_UINT32,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobStaffInjurySupporterCount		= { name = "fobStaffInjurySupporterCount", type = TppScriptVars.TYPE_UINT32,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	numRespawnCount						= { name = "numRespawnCount", type = TppScriptVars.TYPE_UINT8,	value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },	
	numFultonedSnakeCount_OF			= { name = "numFultonedSnakeCount_OF", type = TppScriptVars.TYPE_UINT16,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },	
	numFultonedDDCount_OF				= { name = "numFultonedDDCount_OF", type = TppScriptVars.TYPE_UINT16,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },		
	numFultonedSnakeCount_DF			= { name = "numFultonedSnakeCount_DF", type = TppScriptVars.TYPE_UINT16,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },	
	numFultonedDDCount_DF				= { name = "numFultonedDDCount_DF", type = TppScriptVars.TYPE_UINT16,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },		
	numDeadSnakeCount_OF				= { name = "numDeadSnakeCount_OF", type = TppScriptVars.TYPE_UINT16,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },	
	numDeadDDCount_OF					= { name = "numDeadDDCount_OF", type = TppScriptVars.TYPE_UINT16,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },		
	numDeadSnakeCount_DF				= { name = "numDeadSnakeCount_DF", type = TppScriptVars.TYPE_UINT16,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },	
	numDeadDDCount_DF					= { name = "numDeadDDCount_DF", type = TppScriptVars.TYPE_UINT16,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },		
	fobGmpAdding_OF						= { name = "fobGmpAdding_OF", type = TppScriptVars.TYPE_UINT32,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },		
	fobGmpSubtract_OF					= { name = "fobGmpSubtract_OF", type = TppScriptVars.TYPE_UINT32,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },	
	fobHeroAdding_OF					= { name = "fobHeroAdding_OF", type = TppScriptVars.TYPE_UINT32,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },	
	fobHeroSubtract_OF					= { name = "fobHeroSubtract_OF", type = TppScriptVars.TYPE_UINT32,	value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },	
	fobGmpAdding_DF						= { name = "fobGmpAdding_DF", type = TppScriptVars.TYPE_UINT32,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },		
	fobGmpSubtract_DF					= { name = "fobGmpSubtract_DF", type = TppScriptVars.TYPE_UINT32,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },	
	fobHeroAdding_DF					= { name = "fobHeroAdding_DF", type = TppScriptVars.TYPE_UINT32,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },	
	fobHeroSubtract_DF					= { name = "fobHeroSubtract_DF", type = TppScriptVars.TYPE_UINT32,	value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },	
	fobIsOpenWormhole					= { name = "fobIsOpenWormhole", type = TppScriptVars.TYPE_BOOL,	value = false, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },		
	fobRevengePointTotal				= { name = "fobRevengePointTotal", type = TppScriptVars.TYPE_UINT16,	value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },		
	posAbortWarmhole_x					= { name = "posAbortWarmhole_x", type = TppScriptVars.TYPE_FLOAT,	value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },		
	posAbortWarmhole_y					= { name = "posAbortWarmhole_y", type = TppScriptVars.TYPE_FLOAT,	value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },		
	posAbortWarmhole_z					= { name = "posAbortWarmhole_z", type = TppScriptVars.TYPE_FLOAT,	value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },		
	fobCaptureHostageRankCount			= { name = "fobCaptureHostageRankCount", arraySize = TppMotherBaseManagementConst.STAFF_SECTION_RANK_COUNT_MAX, type = TppScriptVars.TYPE_UINT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobCaptureSoldierOwnerRankCount		= { name = "fobCaptureSoldierOwnerRankCount", arraySize = TppMotherBaseManagementConst.STAFF_SECTION_RANK_COUNT_MAX, type = TppScriptVars.TYPE_UINT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobCaptureSoldierSupporterRankCount	= { name = "fobCaptureSoldierSupporterRankCount", arraySize = TppMotherBaseManagementConst.STAFF_SECTION_RANK_COUNT_MAX, type = TppScriptVars.TYPE_UINT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobRescueStaffRankCount				= { name = "fobRescueStaffRankCount", arraySize = TppMotherBaseManagementConst.STAFF_SECTION_RANK_COUNT_MAX, type = TppScriptVars.TYPE_UINT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobStaffDeadOwnerRankCount			= { name = "fobStaffDeadOwnerRankCount", arraySize = TppMotherBaseManagementConst.STAFF_SECTION_RANK_COUNT_MAX, type = TppScriptVars.TYPE_UINT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobStaffDeadSupporterRankCount		= { name = "fobStaffDeadSupporterRankCount", arraySize = TppMotherBaseManagementConst.STAFF_SECTION_RANK_COUNT_MAX, type = TppScriptVars.TYPE_UINT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobStaffInjuryOwnerRankCount		= { name = "fobStaffInjuryOwnerRankCount", arraySize = TppMotherBaseManagementConst.STAFF_SECTION_RANK_COUNT_MAX, type = TppScriptVars.TYPE_UINT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobStaffInjurySupporterRankCount	= { name = "fobStaffInjurySupporterRankCount", arraySize = TppMotherBaseManagementConst.STAFF_SECTION_RANK_COUNT_MAX, type = TppScriptVars.TYPE_UINT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	
	espt_of_goal = { name = "espt_of_goal", type = TppScriptVars.TYPE_INT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_goal_on_versus = { name = "espt_of_goal_on_versus", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_alert_count = { name = "espt_of_alert_count", type = TppScriptVars.TYPE_UINT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_plant_count = { name = "espt_of_plant_count", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_no_kill = { name = "espt_of_no_kill", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_no_reflex = { name = "espt_of_no_reflex", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_sneak_day = { name = "espt_of_sneak_day", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_fluton_dfp = { name = "espt_of_fluton_dfp", type = TppScriptVars.TYPE_UINT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_fluton_cntn = { name = "espt_of_fluton_cntn", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_fluton_ptwp = { name = "espt_of_fluton_ptwp", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_pick_scgj = { name = "espt_of_pick_scgj", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_fluton_dds = { name = "espt_of_fluton_dds", type = TppScriptVars.TYPE_UINT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_kill_dfp = { name = "espt_of_kill_dfp", type = TppScriptVars.TYPE_UINT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_destroy_ptwp = { name = "espt_of_destroy_ptwp", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_destroy_scgj = { name = "espt_of_destroy_scgj", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_kill_dds = { name = "espt_of_kill_dds", type = TppScriptVars.TYPE_UINT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_df_block_goal = { name = "espt_df_block_goal", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_df_mark_ofp_count = { name = "espt_df_mark_ofp_count", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_df_plant_count = { name = "espt_df_plant_count", type = TppScriptVars.TYPE_INT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_df_save_cntn = { name = "espt_df_save_cntn", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_df_save_ptwp = { name = "espt_df_save_ptwp", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_df_save_sec = { name = "espt_df_save_sec", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_df_save_dds = { name = "espt_df_save_dds", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_df_kill_ofp = { name = "espt_df_kill_ofp", type = TppScriptVars.TYPE_UINT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_df_fulton_ofp = { name = "espt_df_fulton_ofp", type = TppScriptVars.TYPE_UINT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_df_fultoned = { name = "espt_df_fultoned", type = TppScriptVars.TYPE_INT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_df_dead = { name = "espt_df_dead", type = TppScriptVars.TYPE_INT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	
	cnt_alert = { name = "cnt_alert", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	cnt_fltn_cntn = { name = "cnt_fltn_cntn", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	cnt_fltn_ptwp = { name = "cnt_fltn_ptwp", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	cnt_pick_scgj = { name = "cnt_pick_scgj", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	cnt_fltn_dds = { name = "cnt_fltn_dds", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	cnt_dstr_ptwp = { name = "cnt_dstr_ptwp", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	cnt_dstr_scgj = { name = "cnt_dstr_scgj", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	cnt_kill_dds = { name = "cnt_kill_dds", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	cnt_mark_of = { name = "cnt_mark_of", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	cnt_kill_dfp = { name = "cnt_kill_dfp", type = TppScriptVars.TYPE_UINT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	cnt_fulton_dfp = { name = "cnt_fulton_dfp", type = TppScriptVars.TYPE_UINT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	cnt_down_of = { name = "cnt_down_of", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	
	espt_of_total_result	= { name = "espt_of_total_result", type = TppScriptVars.TYPE_INT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_total_sneak		= { name = "espt_of_total_sneak", type = TppScriptVars.TYPE_INT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_total_collect	= { name = "espt_of_total_collect", type = TppScriptVars.TYPE_INT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_total_destroy	= { name = "espt_of_total_destroy", type = TppScriptVars.TYPE_INT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_total_versus	= { name = "espt_of_total_versus", type = TppScriptVars.TYPE_INT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_total			= { name = "espt_of_total", type = TppScriptVars.TYPE_INT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_df_total_result	= { name = "espt_df_total_result", type = TppScriptVars.TYPE_INT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_df_total_sneak		= { name = "espt_df_total_sneak", type = TppScriptVars.TYPE_INT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_df_total_defense	= { name = "espt_df_total_defense", type = TppScriptVars.TYPE_INT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_df_total_battle	= { name = "espt_df_total_battle", type = TppScriptVars.TYPE_INT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_df_total_versus	= { name = "espt_df_total_versus", type = TppScriptVars.TYPE_INT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_df_total			= { name = "espt_df_total", type = TppScriptVars.TYPE_INT16, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_total_result_max = { name = "espt_of_total_result_max", type = TppScriptVars.TYPE_UINT8, value = 200, save = false, sync = false, wait = false, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_total_sneak_max = { name = "espt_of_total_sneak_max", type = TppScriptVars.TYPE_UINT16, value = 700, save = false, sync = false, wait = false, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_total_collect_max = { name = "espt_of_total_collect_max", type = TppScriptVars.TYPE_UINT8, value = 200, save = false, sync = false, wait = false, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_total_destroy_max = { name = "espt_of_total_destroy_max", type = TppScriptVars.TYPE_UINT8, value = 200, save = false, sync = false, wait = false, category = TppScriptVars.CATEGORY_MISSION },
	espt_of_total_versus_max = { name = "espt_of_total_versus_max", type = TppScriptVars.TYPE_UINT8, value = 200, save = false, sync = false, wait = false, category = TppScriptVars.CATEGORY_MISSION },
	espt_df_total_result_max = { name = "espt_df_total_result_max", type = TppScriptVars.TYPE_UINT8, value = 100, save = false, sync = false, wait = false, category = TppScriptVars.CATEGORY_MISSION },
	espt_df_total_defense_max = { name = "espt_df_total_defense_max", type = TppScriptVars.TYPE_UINT8, value = 200, save = false, sync = false, wait = false, category = TppScriptVars.CATEGORY_MISSION },
	espt_df_total_versus_max = { name = "espt_df_total_versus_max", type = TppScriptVars.TYPE_UINT8, value = 200, save = false, sync = false, wait = false, category = TppScriptVars.CATEGORY_MISSION },
	
	fobIsThereRecoverStaff	= { name = "fobIsThereRecoverStaff", type = TppScriptVars.TYPE_BOOL, value = false,	save = true, sync = true,	wait = true, category = TppScriptVars.CATEGORY_MISSION },
	timeLimitforVisiting	= { name = "timeLimitforVisiting", type = TppScriptVars.TYPE_UINT32,  value = this.TIME_LIMIT.VISITING, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobResultType 			= { name = "fobResultType", type = TppScriptVars.TYPE_UINT8,  value = FobResult.RESULT_NONE, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	
	fobRecoverFuelCount					= { name = "fobRecoverFuelCount", type = TppScriptVars.TYPE_UINT16,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobRecoverBiologicalResourceCount	= { name = "fobRecoverBiologicalResourceCount", type = TppScriptVars.TYPE_UINT16,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobRecoverCommonMetalCount			= { name = "fobRecoverCommonMetalCount", type = TppScriptVars.TYPE_UINT16,	value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobRecoverMinorMetalCount			= { name = "fobRecoverMinorMetalCount", type = TppScriptVars.TYPE_UINT16,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobRecoverPreciousMetalCo			= { name = "fobRecoverPreciousMetalCo", type = TppScriptVars.TYPE_UINT16,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	
	fobSecStaffGrade		= { name = "fobSecStaffGrade", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobWepShortGrade		= { name = "fobWepShortGrade", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobWepMidGrade			= { name = "fobWepMidGrade", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobWepLongGrade			= { name = "fobWepLongGrade", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobIrSensorGrade		= { name = "fobIrSensorGrade", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobSecAlarmGrade		= { name = "fobSecAlarmGrade", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobSecCameraGrade		= { name = "fobSecCameraGrade", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobSecUavGrade			= { name = "fobSecUavGrade", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobWepShortIsNokillMode	= { name = "fobWepShortIsNokillMode", type = TppScriptVars.TYPE_BOOL, value = false, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobWepMidIsNokillMode	= { name = "fobWepMidIsNokillMode", type = TppScriptVars.TYPE_BOOL, value = false, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobWepLonIsNokillMode	= { name = "fobWepLonIsNokillMode", type = TppScriptVars.TYPE_BOOL, value = false, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobSecCameraIsNokillMode = { name = "fobSecCameraIsNokillMode", type = TppScriptVars.TYPE_BOOL, value = false, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobSecUavIsNokillMode	= { name = "fobSecUavIsNokillMode", type = TppScriptVars.TYPE_BOOL, value = false, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobIsSneakForSupporter	= { name = "fobIsSneakForSupporter", type = TppScriptVars.TYPE_BOOL, value = false, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobIsThereStolenStaff	= { name = "fobIsThereStolenStaff", type = TppScriptVars.TYPE_BOOL, value = false, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	fobAmountOfDamage		= { name = "fobAmountOfDamage", type = TppScriptVars.TYPE_UINT32,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	cntDmgIrSensor			= { name = "cntDmgIrSensor", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	cntDmgSAlarm			= { name = "cntDmgSAlarm", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	cntDmgSecCamera			= { name = "cntDmgSecCamera", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	cntDmgUav				= { name = "cntDmgUav", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	cntDmgDecoy				= { name = "cntDmgDecoy", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	cntDmgMine				= { name = "cntDmgMine", type = TppScriptVars.TYPE_UINT8, value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
	
	fobCaptureNuclearCount	= { name = "fobCaptureNuclearCount", type = TppScriptVars.TYPE_UINT8,  value = 0, save = true, sync = true, wait = true, category = TppScriptVars.CATEGORY_MISSION },
}




this.currentClusterSetting = {
	numClstId = 100,
	strMissionObjective = "",
	dbg_strEscapeWormhole = "",
	currentCpName = "",
	strMissionObjective = "",
	strGoalMarker = "",
	strGoalTrap = "",
	strEscapeWormhole = "",
	currentCpName = "",
	GuardTargetName = "",
	CbtSetName = "",
	InnerZoneName = "",
	OuterZoneName = "",
	CheckPoints = {},
}

this.securityStaffIds = {}
this.rewardStaffIds = {}


this.checkPointList = {
	"CHK_StartSneakingFob",		
}




this.VARIABLE_TRAP_SETTING = {
	{ name = "trig_innerZone", type = TppDefine.TRAP_TYPE.TRIGGER, initialState = TppDefine.TRAP_STATE.DISABLE, },
	{ name = "trig_outerZone", type = TppDefine.TRAP_TYPE.TRIGGER, initialState = TppDefine.TRAP_STATE.DISABLE, },
}







function this.SwitchExecByIsHost( hostFunc, clientFunc, arg1, arg2, arg3, arg4 )
	if TppServerManager.FobIsSneak() then
		return hostFunc( arg1, arg2, arg3, arg4 )
	else
		return clientFunc( arg1, arg2, arg3, arg4 )
	end
end








function this.SwitchExecByIsGameMode( actualFunc, shamFunc, visitFunc, arg1, arg2, arg3, arg4 )
	if vars.fobSneakMode == FobMode.MODE_ACTUAL then
		Fox.Log("### Fob GameMode : ACTUAL ###")
		return actualFunc( arg1, arg2, arg3, arg4 )
	elseif vars.fobSneakMode == FobMode.MODE_SHAM then
		Fox.Log("### Fob GameMode : SHAM ###")
		return shamFunc( arg1, arg2, arg3, arg4 )
	elseif vars.fobSneakMode == FobMode.MODE_VISIT then
		Fox.Log("### Fob GameMode : VISIT ###")
		return visitFunc( arg1, arg2, arg3, arg4 )
	else
		Fox.Log("### Fob GameMode : none ###")
	end
end





this.RemovedPlayerStaffForFob = function ()
	Fox.Log("RemovedPlayerStaffForFob : playerType = " .. tostring(vars.playerType))
	Fox.Log("RemovedPlayerStaffForFob : playerStaffHeader = " .. tostring(vars.playerStaffHeader))
	Fox.Log("RemovedPlayerStaffForFob : playerStaffSeed = " .. tostring(vars.playerStaffSeed))
	return TppMotherBaseManagement.RemovedPlayerStaffForFob()
end




this.SetClusterDefine = function ( clusterId )
	
	if (vars.mbLayoutCode >= 10) and (vars.mbLayoutCode <= 13) then
		numLayout = 13
	elseif (vars.mbLayoutCode >= 20) and (vars.mbLayoutCode <= 23) then
		numLayout = 23
	elseif (vars.mbLayoutCode >= 30) and (vars.mbLayoutCode <= 33) then
		numLayout = 33
	elseif (vars.mbLayoutCode >= 40) and (vars.mbLayoutCode <= 43) then
		numLayout = 43
	elseif (vars.mbLayoutCode >= 70) and (vars.mbLayoutCode <= 73) then
		numLayout = 73
	elseif (vars.mbLayoutCode >= 80) and (vars.mbLayoutCode <= 83) then
		numLayout = 83
	elseif (vars.mbLayoutCode >= 90) and (vars.mbLayoutCode <= 93) then
		numLayout = 93
	else
		numLayout = vars.mbLayoutCode
	end

	
	local clstId = clusterId - 1

	
	local uqLasId = string.format("%04d", clstId * 10 )

	

	Fox.Log("numLayout = "..tostring(numLayout).."clusterId = "..tostring(clusterId))

	local ToStringLayoutCode = tostring(numLayout)

	
	
	this.CLST_PARAM = {
		{ 
			MISSION_OBJECTIVE = string.format("clst%01d_goalOfCurrentCluster", clstId ),
			GOAL_MARKER = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_uq_%04d_startpoint|Marker_Goal", numLayout, clstId, clstId, 0, clstId * 10 ),
			GOAL = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_uq_%04d_startpoint|trap_Goal", numLayout, clstId, clstId, 0, clstId * 10 ),
			CP_NAME = string.format("ly%03d_cl%02d_npc0000|cl%02dpl%01d_uq_%04d_npc|%s", numLayout, clstId, clstId, 0, clstId * 10, this.CP_NAME[clstId+1]),
			GT_NAME = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_uq_%04d_cbtlct|gt_0000", numLayout, clstId, clstId, 0, clstId * 10 ),
			CBTSET_NAME = string.format("cs_cl%02d_0000", clstId ),
			GT_NAME_00 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_uq_%04d_cbtlct|gt_0000", numLayout, clstId, clstId, 0, clstId * 10 ),
			CBTSET_NAME_00 = string.format("cs_cl%02dpl%01d", clstId, 0 ),
			GT_NAME_01 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_mb_fndt_plnt_cbtlct|gt_plnt", numLayout, clstId, clstId, 1),
			CBTSET_NAME_01 = string.format("cs_cl%02dpl%01d", clstId, 1 ),
			GT_NAME_02 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_mb_fndt_plnt_cbtlct|gt_plnt", numLayout, clstId, clstId, 2),
			CBTSET_NAME_02 = string.format("cs_cl%02dpl%01d", clstId, 2 ),
			GT_NAME_03 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_mb_fndt_plnt_cbtlct|gt_plnt", numLayout, clstId, clstId, 3),
			CBTSET_NAME_03 = string.format("cs_cl%02dpl%01d", clstId, 3 ),
			CHECK_POINTS = {
				plnt1 = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_mb_brdg_plnt_chkpnt|trap_CHK_brdg_plnt", numLayout, clstId, clstId, 1 ),
				plnt2 = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_mb_brdg_plnt_chkpnt|trap_CHK_brdg_plnt", numLayout, clstId, clstId, 2 ),
				plnt3 = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_mb_brdg_plnt_chkpnt|trap_CHK_brdg_plnt", numLayout, clstId, clstId, 3 ),
			},
			OUTER_ZONE_NAME = "trig_outerZone",
			INNER_ZONE_NAME = "trig_innerZone",
			RESPAWN_POS = {
				{
					string.format("player_locator_clst%01d_plnt%01d_df0", clstId, 0 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 0 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 0 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 0 ),
				},
				{
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 1 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 1 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 1 ),
				},
				{
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 2 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 2 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 2 ),
				},
				{
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 3 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 3 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 3 ),
				},
			},






		},
		{
			MISSION_OBJECTIVE = string.format("clst%01d_goalOfCurrentCluster", clstId ),
			GOAL_MARKER = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_uq_%04d_startpoint|Marker_Goal", numLayout, clstId, clstId, 0, clstId * 10 ),
			GOAL = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_uq_%04d_startpoint|trap_Goal", numLayout, clstId, clstId, 0, clstId * 10 ),
			CP_NAME = string.format("ly%03d_cl%02d_npc0000|cl%02dpl%01d_uq_%04d_npc|%s", numLayout, clstId, clstId, 0, clstId * 10, this.CP_NAME[clstId+1]),
			GT_NAME = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_uq_%04d_cbtlct|gt_0000", numLayout, clstId, clstId, 0, clstId * 10 ),
			CBTSET_NAME = string.format("cs_cl%02d_0000", clstId ),
			GT_NAME_00 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_uq_%04d_cbtlct|gt_0000", numLayout, clstId, clstId, 0, clstId * 10 ),
			CBTSET_NAME_00 = string.format("cs_cl%02dpl%01d", clstId, 0 ),
			GT_NAME_01 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_mb_fndt_plnt_cbtlct|gt_plnt", numLayout, clstId, clstId, 1),
			CBTSET_NAME_01 = string.format("cs_cl%02dpl%01d", clstId, 1 ),
			GT_NAME_02 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_mb_fndt_plnt_cbtlct|gt_plnt", numLayout, clstId, clstId, 2),
			CBTSET_NAME_02 = string.format("cs_cl%02dpl%01d", clstId, 2 ),
			GT_NAME_03 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_mb_fndt_plnt_cbtlct|gt_plnt", numLayout, clstId, clstId, 3),
			CBTSET_NAME_03 = string.format("cs_cl%02dpl%01d", clstId, 3 ),
			CHECK_POINTS = {
				plnt1 = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_mb_brdg_plnt_chkpnt|trap_CHK_brdg_plnt", numLayout, clstId, clstId, 1 ),
				plnt2 = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_mb_brdg_plnt_chkpnt|trap_CHK_brdg_plnt", numLayout, clstId, clstId, 2 ),
				plnt3 = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_mb_brdg_plnt_chkpnt|trap_CHK_brdg_plnt", numLayout, clstId, clstId, 3 ),
			},
			OUTER_ZONE_NAME = "trig_outerZone",
			INNER_ZONE_NAME = "trig_innerZone",
			RESPAWN_POS = {
				{
					string.format("player_locator_clst%01d_plnt%01d_df0", clstId, 0 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 0 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 0 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 0 ),
				},
				{
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 1 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 1 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 1 ),
				},
				{
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 2 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 2 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 2 ),
				},
				{
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 3 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 3 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 3 ),
				},
			},
		},
		{
			MISSION_OBJECTIVE = string.format("clst%01d_goalOfCurrentCluster", clstId ),
			GOAL_MARKER = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_uq_%04d_startpoint|Marker_Goal", numLayout, clstId, clstId, 0, clstId * 10 ),
			GOAL = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_uq_%04d_startpoint|trap_Goal", numLayout, clstId, clstId, 0, clstId * 10 ),
			CP_NAME = string.format("ly%03d_cl%02d_npc0000|cl%02dpl%01d_uq_%04d_npc|%s", numLayout, clstId, clstId, 0, clstId * 10, this.CP_NAME[clstId+1]),
			GT_NAME = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_uq_%04d_cbtlct|gt_0000", numLayout, clstId, clstId, 0, clstId * 10 ),
			CBTSET_NAME = string.format("cs_cl%02d_0000", clstId ),
			GT_NAME_00 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_uq_%04d_cbtlct|gt_0000", numLayout, clstId, clstId, 0, clstId * 10 ),
			CBTSET_NAME_00 = string.format("cs_cl%02dpl%01d", clstId, 0 ),
			GT_NAME_01 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_mb_fndt_plnt_cbtlct|gt_plnt", numLayout, clstId, clstId, 1),
			CBTSET_NAME_01 = string.format("cs_cl%02dpl%01d", clstId, 1 ),
			GT_NAME_02 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_mb_fndt_plnt_cbtlct|gt_plnt", numLayout, clstId, clstId, 2),
			CBTSET_NAME_02 = string.format("cs_cl%02dpl%01d", clstId, 2 ),
			GT_NAME_03 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_mb_fndt_plnt_cbtlct|gt_plnt", numLayout, clstId, clstId, 3),
			CBTSET_NAME_03 = string.format("cs_cl%02dpl%01d", clstId, 3 ),
			CHECK_POINTS = {
				plnt1 = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_mb_brdg_plnt_chkpnt|trap_CHK_brdg_plnt", numLayout, clstId, clstId, 1 ),
				plnt2 = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_mb_brdg_plnt_chkpnt|trap_CHK_brdg_plnt", numLayout, clstId, clstId, 2 ),
				plnt3 = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_mb_brdg_plnt_chkpnt|trap_CHK_brdg_plnt", numLayout, clstId, clstId, 3 ),
			},
			OUTER_ZONE_NAME = "trig_outerZone",
			INNER_ZONE_NAME = "trig_innerZone",
			RESPAWN_POS = {
				{
					string.format("player_locator_clst%01d_plnt%01d_df0", clstId, 0 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 0 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 0 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 0 ),
				},
				{
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 1 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 1 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 1 ),
				},
				{
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 2 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 2 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 2 ),
				},
				{
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 3 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 3 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 3 ),
				},
			},
		},
		{
			MISSION_OBJECTIVE = string.format("clst%01d_goalOfCurrentCluster", clstId ),
			GOAL_MARKER = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_uq_%04d_startpoint|Marker_Goal", numLayout, clstId, clstId, 0, clstId * 10 ),
			GOAL = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_uq_%04d_startpoint|trap_Goal", numLayout, clstId, clstId, 0, clstId * 10 ),
			CP_NAME = string.format("ly%03d_cl%02d_npc0000|cl%02dpl%01d_uq_%04d_npc|%s", numLayout, clstId, clstId, 0, clstId * 10, this.CP_NAME[clstId+1]),
			GT_NAME = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_uq_%04d_cbtlct|gt_0000", numLayout, clstId, clstId, 0, clstId * 10 ),
			CBTSET_NAME = string.format("cs_cl%02d_0000", clstId ),
			GT_NAME_00 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_uq_%04d_cbtlct|gt_0000", numLayout, clstId, clstId, 0, clstId * 10 ),
			CBTSET_NAME_00 = string.format("cs_cl%02dpl%01d", clstId, 0 ),
			GT_NAME_01 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_mb_fndt_plnt_cbtlct|gt_plnt", numLayout, clstId, clstId, 1),
			CBTSET_NAME_01 = string.format("cs_cl%02dpl%01d", clstId, 1 ),
			GT_NAME_02 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_mb_fndt_plnt_cbtlct|gt_plnt", numLayout, clstId, clstId, 2),
			CBTSET_NAME_02 = string.format("cs_cl%02dpl%01d", clstId, 2 ),
			GT_NAME_03 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_mb_fndt_plnt_cbtlct|gt_plnt", numLayout, clstId, clstId, 3),
			CBTSET_NAME_03 = string.format("cs_cl%02dpl%01d", clstId, 3 ),
			CHECK_POINTS = {
				plnt1 = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_mb_brdg_plnt_chkpnt|trap_CHK_brdg_plnt", numLayout, clstId, clstId, 1 ),
				plnt2 = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_mb_brdg_plnt_chkpnt|trap_CHK_brdg_plnt", numLayout, clstId, clstId, 2 ),
				plnt3 = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_mb_brdg_plnt_chkpnt|trap_CHK_brdg_plnt", numLayout, clstId, clstId, 3 ),
			},
			OUTER_ZONE_NAME = "trig_outerZone",
			INNER_ZONE_NAME = "trig_innerZone",
			RESPAWN_POS = {
				{
					string.format("player_locator_clst%01d_plnt%01d_df0", clstId, 0 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 0 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 0 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 0 ),
				},
				{
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 1 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 1 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 1 ),
				},
				{
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 2 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 2 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 2 ),
				},
				{
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 3 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 3 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 3 ),
				},
			},
		},
		{
			MISSION_OBJECTIVE = string.format("clst%01d_goalOfCurrentCluster", clstId ),
			GOAL_MARKER = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_uq_%04d_startpoint|Marker_Goal", numLayout, clstId, clstId, 0, clstId * 10 ),
			GOAL = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_uq_%04d_startpoint|trap_Goal", numLayout, clstId, clstId, 0, clstId * 10 ),
			CP_NAME = string.format("ly%03d_cl%02d_npc0000|cl%02dpl%01d_uq_%04d_npc|%s", numLayout, clstId, clstId, 0, clstId * 10, this.CP_NAME[clstId+1]),
			GT_NAME = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_uq_%04d_cbtlct|gt_0000", numLayout, clstId, clstId, 0, clstId * 10 ),
			CBTSET_NAME = string.format("cs_cl%02d_0000", clstId ),
			GT_NAME_00 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_uq_%04d_cbtlct|gt_0000", numLayout, clstId, clstId, 0, clstId * 10 ),
			CBTSET_NAME_00 = string.format("cs_cl%02dpl%01d", clstId, 0 ),
			GT_NAME_01 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_mb_fndt_plnt_cbtlct|gt_plnt", numLayout, clstId, clstId, 1),
			CBTSET_NAME_01 = string.format("cs_cl%02dpl%01d", clstId, 1 ),
			GT_NAME_02 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_mb_fndt_plnt_cbtlct|gt_plnt", numLayout, clstId, clstId, 2),
			CBTSET_NAME_02 = string.format("cs_cl%02dpl%01d", clstId, 2 ),
			GT_NAME_03 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_mb_fndt_plnt_cbtlct|gt_plnt", numLayout, clstId, clstId, 3),
			CBTSET_NAME_03 = string.format("cs_cl%02dpl%01d", clstId, 3 ),
			CHECK_POINTS = {
				plnt1 = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_mb_brdg_plnt_chkpnt|trap_CHK_brdg_plnt", numLayout, clstId, clstId, 1 ),
				plnt2 = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_mb_brdg_plnt_chkpnt|trap_CHK_brdg_plnt", numLayout, clstId, clstId, 2 ),
				plnt3 = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_mb_brdg_plnt_chkpnt|trap_CHK_brdg_plnt", numLayout, clstId, clstId, 3 ),
			},
			OUTER_ZONE_NAME = "trig_outerZone",
			INNER_ZONE_NAME = "trig_innerZone",
			RESPAWN_POS = {
				{
					string.format("player_locator_clst%01d_plnt%01d_df0", clstId, 0 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 0 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 0 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 0 ),
				},
				{
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 1 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 1 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 1 ),
				},
				{
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 2 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 2 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 2 ),
				},
				{
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 3 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 3 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 3 ),
				},
			},
		},
		{
			MISSION_OBJECTIVE = string.format("clst%01d_goalOfCurrentCluster", clstId ),
			GOAL_MARKER = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_uq_%04d_startpoint|Marker_Goal", numLayout, clstId, clstId, 0, clstId * 10 ),
			GOAL = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_uq_%04d_startpoint|trap_Goal", numLayout, clstId, clstId, 0, clstId * 10 ),
			CP_NAME = string.format("ly%03d_cl%02d_npc0000|cl%02dpl%01d_uq_%04d_npc|%s", numLayout, clstId, clstId, 0, clstId * 10, this.CP_NAME[clstId+1]),
			GT_NAME = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_uq_%04d_cbtlct|gt_0000", numLayout, clstId, clstId, 0, clstId * 10 ),
			CBTSET_NAME = string.format("cs_cl%02d_0000", clstId ),
			GT_NAME_00 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_uq_%04d_cbtlct|gt_0000", numLayout, clstId, clstId, 0, clstId * 10 ),
			CBTSET_NAME_00 = string.format("cs_cl%02dpl%01d", clstId, 0 ),
			GT_NAME_01 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_mb_fndt_plnt_cbtlct|gt_plnt", numLayout, clstId, clstId, 1),
			CBTSET_NAME_01 = string.format("cs_cl%02dpl%01d", clstId, 1 ),
			GT_NAME_02 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_mb_fndt_plnt_cbtlct|gt_plnt", numLayout, clstId, clstId, 2),
			CBTSET_NAME_02 = string.format("cs_cl%02dpl%01d", clstId, 2 ),
			GT_NAME_03 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_mb_fndt_plnt_cbtlct|gt_plnt", numLayout, clstId, clstId, 3),
			CBTSET_NAME_03 = string.format("cs_cl%02dpl%01d", clstId, 3 ),
			CHECK_POINTS = {
				plnt1 = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_mb_brdg_plnt_chkpnt|trap_CHK_brdg_plnt", numLayout, clstId, clstId, 1 ),
				plnt2 = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_mb_brdg_plnt_chkpnt|trap_CHK_brdg_plnt", numLayout, clstId, clstId, 2 ),
				plnt3 = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_mb_brdg_plnt_chkpnt|trap_CHK_brdg_plnt", numLayout, clstId, clstId, 3 ),
			},
			OUTER_ZONE_NAME = "trig_outerZone",
			INNER_ZONE_NAME = "trig_innerZone",
			RESPAWN_POS = {
				{
					string.format("player_locator_clst%01d_plnt%01d_df0", clstId, 0 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 0 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 0 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 0 ),
				},
				{
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 1 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 1 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 1 ),
				},
				{
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 2 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 2 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 2 ),
				},
				{
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 3 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 3 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 3 ),
				},
			},
		},
		{
			MISSION_OBJECTIVE = string.format("clst%01d_goalOfCurrentCluster", clstId ),
			GOAL_MARKER = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_uq_%04d_startpoint|Marker_Goal", numLayout, clstId, clstId, 0, clstId * 10 ),
			GOAL = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_uq_%04d_startpoint|trap_Goal", numLayout, clstId, clstId, 0, clstId * 10 ),
			CP_NAME = string.format("ly%03d_cl%02d_npc0000|cl%02dpl%01d_uq_%04d_npc|%s", numLayout, clstId, clstId, 0, clstId * 10, this.CP_NAME[clstId+1]),
			GT_NAME = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_uq_%04d_cbtlct|gt_0000", numLayout, clstId, clstId, 0, clstId * 10 ),
			CBTSET_NAME = string.format("cs_cl%02d_0000", clstId ),
			GT_NAME_00 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_uq_%04d_cbtlct|gt_0000", numLayout, clstId, clstId, 0, clstId * 10 ),
			CBTSET_NAME_00 = string.format("cs_cl%02dpl%01d", clstId, 0 ),
			GT_NAME_01 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_mb_fndt_plnt_cbtlct|gt_plnt", numLayout, clstId, clstId, 1),
			CBTSET_NAME_01 = string.format("cs_cl%02dpl%01d", clstId, 1 ),
			GT_NAME_02 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_mb_fndt_plnt_cbtlct|gt_plnt", numLayout, clstId, clstId, 2),
			CBTSET_NAME_02 = string.format("cs_cl%02dpl%01d", clstId, 2 ),
			GT_NAME_03 = string.format("ly%03d_cl%02d_combat0000|cl%02dpl%01d_mb_fndt_plnt_cbtlct|gt_plnt", numLayout, clstId, clstId, 3),
			CBTSET_NAME_03 = string.format("cs_cl%02dpl%01d", clstId, 3 ),
			CHECK_POINTS = {
				plnt1 = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_mb_brdg_plnt_chkpnt|trap_CHK_brdg_plnt", numLayout, clstId, clstId, 1 ),
				plnt2 = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_mb_brdg_plnt_chkpnt|trap_CHK_brdg_plnt", numLayout, clstId, clstId, 2 ),
				plnt3 = string.format("ly%03d_cl%02d_sequence0000|cl%02dpl%01d_mb_brdg_plnt_chkpnt|trap_CHK_brdg_plnt", numLayout, clstId, clstId, 3 ),
			},
			OUTER_ZONE_NAME = "trig_outerZone",
			INNER_ZONE_NAME = "trig_innerZone",
			RESPAWN_POS = {
				{
					string.format("player_locator_clst%01d_plnt%01d_df0", clstId, 0 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 0 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 0 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 0 ),
				},
				{
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 1 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 1 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 1 ),
				},
				{
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 2 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 2 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 2 ),
				},
				{
					string.format("player_locator_clst%01d_plnt%01d_dfrsp0", clstId, 3 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp1", clstId, 3 ),
					string.format("player_locator_clst%01d_plnt%01d_dfrsp2", clstId, 3 ),
				},
			},
		},
	}
end











 





 



this.missionStartPosition = {
	helicopterRouteList = {},
}



 
function this.OnLoad()
	Fox.Log("#### OnLoad ####")
	
	
	Mission.StartFobGameDaemon()

	GkEventTimerManager.StopAll()

	TppSequence.RegisterSequences{
		

		
		"Seq_Demo_SyncGameStart",

		"Seq_Game_StartFromHeli",	
		"Seq_Game_FOB",

		
		"Seq_ShowMissionClearDemo",
		"Seq_WaitSyncSVarsOnMissionClear",
		"Seq_ShowMissionClearResult",
		"Seq_WaitSyncSVarsOnGameOver",
		"Seq_ShowGameOverResult",

		"Seq_DefenceGameOver",
		
		"Seq_ConfirmRetryPractice",
		"Seq_ErrorDialogOnRetryPractice",
		nil
	}
	TppSequence.RegisterSequenceTable(sequences)

	if DEBUG then
		
		DEBUG.SetDebugMenuValue("Player2 Develop", "OtherPlayerInfo", "None")
	end


end

 
function this.ClearGameStatusOnStartVersus()
	Fox.Log("### ClearGameStatusOnStartVersus ####")
	
	local target = {}
	for key, value in pairs(TppDefine.GAME_STATUS_TYPE_ALL) do
		target[key] = value
	end

	Tpp.SetGameStatus{
		target = target,
		enable = true,
		scriptName = "o50050_sequence.lua",
	}
end

 

function this.OnTerminate()
	Fox.Log("o50050_common_sequence.OnTerminate")
	
	o50050_sound.PlayAlertSiren( false )

	
	Player.ResetPadMask{
		settingName = "fobWarpToStart",
	}

	
	vars.playerDisableActionFlag = PlayerDisableAction.NONE

	
	TppGameStatus.Reset("o50050_sequence.lua","S_ENABLE_FOB_PLAYER_HIDE")
	
	TppGameStatus.Reset("o50050_sequence.lua","S_DISABLE_TARGET")
	TppGameStatus.Reset("o50050_sequence.lua","S_DISABLE_NPC_NOTICE")
	
	
	this.ClearGameStatusOnStartVersus()

	
	TppUiCommand.DeactivateSpySearchForFobDefense()

	
	TppUiCommand.StopRespawnMenu()

	
	if TppGameSequence.GetPatchVersion() >= PATCH_VERSION_DAY1 then
		
		TppUiCommand.EraseWormHoleTimer()
		TppUiCommand.DeactivateSpySearchForFobSneak()
	end

	
	SubtitlesCommand.SetIsEnabledUiPrioStrong(false)

end

 
function this.OnUpdate()
	if TppServerManager.FobIsSneak() then
		this.OnUpdateHost()
	else
		this.OnUpdateClient()
	end

	if DEBUG then
		local DebugTextPrint = DebugText.Print
		local context = DebugText.NewContext()
		
		if mvars.fob_addMemverLog then
			DebugTextPrint(context, {1.0, 0.5, 0.5}, mvars.fob_addMemverLog )
		end
	end

	if DebugMenu then
		if mvars.fobDebug.forceClearGoal then
			mvars.fobDebug.forceClearGoal = false
			TppMission.ReserveMissionClear {
				missionClearType = TppDefine.MISSION_CLEAR_TYPE.FOB_GOAL,
				nextMissionId = TppDefine.SYS_MISSION_ID.MTBS_HELI
			}
		end

		if mvars.fobDebug.forceClearEscape then
			mvars.fobDebug.forceClearEscape = false
			TppMission.ReserveMissionClear {
				missionClearType = TppDefine.MISSION_CLEAR_TYPE.FOB_ESCAPE,
				nextMissionId = TppDefine.SYS_MISSION_ID.MTBS_HELI
			}
		end

		if mvars.fobDebug.forceGameOverOutOfMissionArea then
			mvars.fobDebug.forceGameOverOutOfMissionArea = false
			TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA, TppDefine.GAME_OVER_RADIO.OUT_OF_MISSION_AREA )
		end

		if mvars.fobDebug.forceGameOverTimeOut then
			mvars.fobDebug.forceGameOverTimeOut = false
			TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.FOB_TIME_OVER, TppDefine.GAME_OVER_RADIO.OUT_OF_MISSION_AREA )
		end

		if mvars.fobDebug.forceGameOverFultoned then
			mvars.fobDebug.forceGameOverFultoned = false
			TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.FOB_FULTONED, TppDefine.GAME_OVER_RADIO.OUT_OF_MISSION_AREA )
		end

		if mvars.fobDebug.forceWarpFromHeli then
			mvars.fobDebug.forceWarpFromHeli = false
			mvars.numStartPoint = 1
			this.EndStartSneaknigFromHeli()
		end

		if mvars.fobDebug.setTimeLimitEmergency then
			mvars.fobDebug.setTimeLimitEmergency = false
			svars.timeLimitforSneaking = this.TIME_LIMIT.CAUTION_TIME_SEC + 3
			this.TimerStartTimeLimit("timeLimitforSneaking")
		end

		if mvars.fobDebug.addTimeLimit60minute then
			mvars.fobDebug.addTimeLimit60minute = false
			svars.timeLimitforSneaking = svars.timeLimitforSneaking + (60 * 60)
			
			if svars.timeLimitforSneaking > (99 * 60) then
				svars.timeLimitforSneaking = (99 * 60)
			end
			this.TimerStartTimeLimit("timeLimitforSneaking")
		end

		if mvars.fobDebug.forceCautionFocusArea then
			mvars.fobDebug.forceCautionFocusArea = false
			local clusterId = mtbs_cluster.GetCurrentClusterId()
			mtbs_enemy.StartCheckFocusArea( clusterId )
		end

		if mvars.fobDebug.CalculateResult then
			mvars.fobDebug.CalculateResult = false
			this.CalculateResult()
		end

		if mvars.fobDebug.dumpSvarsForResult then
			mvars.fobDebug.dumpSvarsForResult = false
			Fox.Log("=== OFFENCE === ")
			Fox.Log("svars.fobGmpAdding_OF  :: " .. tostring(svars.fobGmpAdding_OF))
			Fox.Log("svars.fobGmpSubtract_OF  :: " .. tostring(svars.fobGmpSubtract_OF))
			Fox.Log("svars.fobHeroAdding_OF  :: " .. tostring(svars.fobHeroAdding_OF))
			Fox.Log("svars.fobHeroSubtract_OF  :: " .. tostring(svars.fobHeroSubtract_OF))
			Fox.Log("svars.espt_of_goal :: " .. tostring(svars.espt_of_goal))
			Fox.Log("svars.espt_of_alert_count :: " .. tostring(svars.espt_of_alert_count))
			Fox.Log("svars.espt_of_plant_count :: " .. tostring(svars.espt_of_plant_count))
			Fox.Log("svars.espt_of_sneak_day :: " .. tostring(svars.espt_of_sneak_day))
			Fox.Log("svars.espt_of_no_kill :: " .. tostring(svars.espt_of_no_kill))
			Fox.Log("svars.espt_of_no_reflex :: " .. tostring(svars.espt_of_no_reflex))
			Fox.Log("svars.espt_of_fluton_dfp :: " .. tostring(svars.espt_of_fluton_dfp))
			Fox.Log("svars.espt_of_fluton_cntn :: " .. tostring(svars.espt_of_fluton_cntn))
			Fox.Log("svars.espt_of_fluton_ptwp :: " .. tostring(svars.espt_of_fluton_ptwp))
			Fox.Log("svars.espt_of_pick_scgj :: " .. tostring(svars.espt_of_pick_scgj))
			Fox.Log("svars.espt_of_fluton_dds :: " .. tostring(svars.espt_of_fluton_dds))
			Fox.Log("svars.espt_of_kill_dfp :: " .. tostring(svars.espt_of_kill_dfp))
			Fox.Log("svars.espt_of_destroy_ptwp :: " .. tostring(svars.espt_of_destroy_ptwp))
			Fox.Log("svars.espt_of_destroy_scgj :: " .. tostring(svars.espt_of_destroy_scgj))
			Fox.Log("svars.espt_of_kill_dds :: " .. tostring(svars.espt_of_kill_dds))
			Fox.Log("svars.espt_of_goal_on_versus :: " .. tostring(svars.espt_of_goal_on_versus))
			Fox.Log("svars.espt_of_total_result :: " .. tostring(svars.espt_of_total_result))
			Fox.Log("svars.espt_of_total_sneak :: " .. tostring(svars.espt_of_total_sneak))
			Fox.Log("svars.espt_of_total_collect :: " .. tostring(svars.espt_of_total_collect))
			Fox.Log("svars.espt_of_total_destroy :: " .. tostring(svars.espt_of_total_destroy))
			Fox.Log("svars.espt_of_total :: " .. tostring(svars.espt_of_total))
			Fox.Log("lostStaffs = " .. (svars.cnt_fltn_dds + svars.cnt_kill_dds))
			Fox.Log("svars.cntDmgIrSensor  =  " .. tostring(svars.cntDmgIrSensor))
			Fox.Log("svars.cntDmgSAlarm = " .. tostring(svars.cntDmgSAlarm))
			Fox.Log("svars.cntDmgSecCamera =  " .. tostring(svars.cntDmgSecCamera))
			Fox.Log("svars.cntDmgUav =  " .. tostring(svars.cntDmgUav))
			Fox.Log("svars.cntDmgMine =  " .. tostring(svars.cntDmgMine))
			Fox.Log("svars.cntDmgDecoy =  " .. tostring(svars.cntDmgDecoy))

			Fox.Log("svars.fobAmountOfDamage =  " .. tostring(svars.fobAmountOfDamage))
			Fox.Log("svars.numRevengePoint =  " .. tostring(svars.numRevengePoint))
			Fox.Log("svars.fobRevengePointTotal =  " .. tostring(svars.fobRevengePointTotal))
			

			Fox.Log("=== DFENCE === ")
			Fox.Log("svars.fobGmpAdding_DF  :: " .. tostring(svars.fobGmpAdding_DF))
			Fox.Log("svars.fobGmpSubtract_DF  :: " .. tostring(svars.fobGmpSubtract_DF))
			Fox.Log("svars.fobHeroAdding_DF  :: " .. tostring(svars.fobHeroAdding_DF))
			Fox.Log("svars.fobHeroSubtract_DF  :: " .. tostring(svars.fobHeroSubtract_DF))
			Fox.Log("svars.espt_df_block_goal :: " .. tostring(svars.espt_df_block_goal))
			Fox.Log("svars.espt_df_mark_ofp_count :: " .. tostring(svars.espt_df_mark_ofp_count))
			Fox.Log("svars.espt_df_plant_count :: " .. tostring(svars.espt_df_plant_count))
			Fox.Log("svars.espt_df_save_cntn :: " .. tostring(svars.espt_df_save_cntn))
			Fox.Log("svars.espt_df_save_ptwp :: " .. tostring(svars.espt_df_save_ptwp))
			Fox.Log("svars.espt_df_save_sec :: " .. tostring(svars.espt_df_save_sec))
			Fox.Log("svars.espt_df_save_dds :: " .. tostring(svars.espt_df_save_dds))
			Fox.Log("svars.espt_df_kill_ofp :: " .. tostring(svars.espt_df_kill_ofp))
			Fox.Log("svars.espt_df_fultoned :: " .. tostring(svars.espt_df_fultoned))
			Fox.Log("svars.espt_df_dead :: " .. tostring(svars.espt_df_dead))
			Fox.Log("svars.espt_df_total_result :: " .. tostring(svars.espt_df_total_result))
			Fox.Log("svars.espt_df_total_sneak :: " .. tostring(svars.espt_df_total_sneak))
			Fox.Log("svars.espt_df_total_defense :: " .. tostring(svars.espt_df_total_defense))
			Fox.Log("svars.espt_df_total_battle :: " .. tostring(svars.espt_df_total_battle))
			Fox.Log("svars.espt_df_total :: " .. tostring(svars.espt_df_total))

			Fox.Log("dumpSvarsForResult ==== END ===")
		end

		if mvars.fobDebug.setFultonCount_OF then
			mvars.fobDebug.setFultonCount_OF = false
			svars.numFultonedSnakeCount_OF = svars.numFultonedSnakeCount_OF + 1
			svars.numFultonedDDCount_OF = svars.numFultonedDDCount_OF + 1
		end
		if mvars.fobDebug.setDeadCount_OF then
			mvars.fobDebug.setDeadCount_OF = false
			svars.numDeadSnakeCount_OF = svars.numDeadSnakeCount_OF + 1
			svars.numDeadDDCount_OF = svars.numDeadDDCount_OF + 1
		end
		if mvars.fobDebug.setFultonCount_DF then
			mvars.fobDebug.setFultonCount_DF = false
			svars.numFultonedSnakeCount_DF = svars.numFultonedSnakeCount_DF + 1
			svars.numFultonedDDCount_DF = svars.numFultonedDDCount_DF + 1
		end
		if mvars.fobDebug.setDeadCount_DF then
			mvars.fobDebug.setDeadCount_DF = false
			svars.numDeadSnakeCount_DF = svars.numDeadSnakeCount_DF + 1
			svars.numDeadDDCount_DF = svars.numDeadDDCount_DF + 1
		end

		if mvars.fobDebug.setTimeLimitForNonAbortLastSecond then
			mvars.fobDebug.setTimeLimitForNonAbortLastSecond = false
			svars.timeLimitforNonAbort = 3
			if TppGameSequence.GetPatchVersion() >= PATCH_VERSION_DAY1 then
				TppUiCommand.StartWormHoleTimer( svars.timeLimitforNonAbort )
			else
				this.TimerStartTimeLimit("timeLimitforNonAbort")
			end
		end

		if mvars.fobDebug.setTimeLimitLastSecond then
			svars.timeLimitforSneaking = 3
			this.TimerStartTimeLimit("timeLimitforSneaking")
			mvars.fobDebug.setTimeLimitLastSecond = false
		end

		if mvars.fobDebug.addRevengePoint_10 then
			mvars.fobDebug.addRevengePoint_10 = false
			this.AddRevengePoint(10)
		end

		if mvars.fobDebug.dumpMbsParam then
			mvars.fobDebug.dumpMbsParam = false
			TppMotherBaseManagement.DEBUG_DumpMbsParam()
		end

		if mvars.fobDebug.forceOpenWormhole then
			mvars.fobDebug.forceOpenWormhole = false
			svars.fobIsOpenWormhole = true
		end

		
		if mvars.fobDebug.showSyncSVars then
			for svarsName, initialValue in pairs( this.saveVarsList ) do
				if Tpp.IsTypeTable( initialValue ) then
					local name, isSync, isWait = initialValue.name, initialValue.sync, initialValue.wait
					if isSync and isWait then
						if DebugText then
							DebugText.Print(DebugText.NewContext(), {0.5, 0.5, 1.0}, ": svars." .. tostring(name) .. " = " .. tostring(svars[name]) )
						end
					end
				end
			end
		end

		if mvars.fobDebug.dumpSvarsForDamage then
			mvars.fobDebug.dumpSvarsForDamage = false
			Fox.Log("dumpSvarsForDamage ==== START ===")
			Fox.Log("svars.fobSecCameraIsNokillMode = " .. tostring(svars.fobSecCameraIsNokillMode))
			Fox.Log("svars.fobSecCameraGrade = " .. svars.fobSecCameraGrade)
			Fox.Log("svars.fobSecUavIsNokillMode = " .. tostring(svars.fobSecUavIsNokillMode))
			Fox.Log("svars.fobSecUavGrade = " .. svars.fobSecUavGrade)
			Fox.Log("svars.fobIrSensorGrade = " .. svars.fobIrSensorGrade)
			Fox.Log("svars.fobSecAlarmGrade = " .. svars.fobSecAlarmGrade)
			Fox.Log("dumpSvarsForDamage ==== END ===")
		end

		if mvars.fobDebug.setSneakPlayer then
			mvars.fobDebug.setSneakPlayer = false
			TppDebug.DEBUG_SetFobPlayerSneak()
		end

		if mvars.fobDebug.setDefencePlayer then
			mvars.fobDebug.setDefencePlayer = false
			TppDebug.DEBUG_SetFobPlayerDefence()
		end
		
	end
end


 
function this.OnUpdateHost()
	if not mvars.DEBUG_isNoRestart then
		if mvars.fob_waitReadyRestart then
			if MotherBaseStage.IsClientReady() or mvars.fob_SessionMemberDeleted then
				mvars.fob_waitReadyRestart = nil
				this.StartFadeOutForRestart()
			end
		end
		
		
		
		if mvars.fob_executeHostRestart then
			if TppMission.CheckMissionState() then
				this.HostExecuteRestart()
				mvars.fob_executeHostRestart = nil
			end
		end
	end
end

 
function this.OnUpdateClient()

	if mvars.mis_missionStateIsNotInGame then return end

	
	if not TppNetworkUtil.IsSessionConnect() then
		Fox.Log("### Session is disconnected. ###")
	end
end








function this.OnGameOverHost( gameOverType )
	Fox.Log("### OnGameOverHost ###")

	
	this.DisableConnectClient()

	
	local fnc_vsCommon = function ()
		
		svars.fobIsHostWin = false

		if TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.PLAYER_DEAD )
		or TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.PLAYER_FALL_DEAD ) then
			
			svars.fobResultType = FobResult.RESULT_DEAD
		end

		if TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.FOB_FULTONED ) then
			
			svars.fobResultType = FobResult.RESULT_FULTON
		end

		if TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA ) then
			Fox.Log("### Out of MissionArea.  Mission Abort. ###")
			
			svars.fobResultType = FobResult.RESULT_ABORT
		end

		
		if TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.FOB_TIME_OVER ) then
			Fox.Log("### Time limit exceeded. Mission failed. ###")
			
			svars.fobResultType = FobResult.RESULT_TIMEOUT
		end
	end

	
	this.SwitchExecByIsGameMode(
		function ()
			
			fnc_vsCommon()

			
			TppServerManager.OpenWormhole{ open = false, retaliate = svars.numRevengePoint }

			
			local offenseLose = { heroicPoint = mvars.heroicPointOffenseLose, ogrePoint = 0 }
			this.AddHeroPointForResultOffence( offenseLose )

			
			svars.espt_df_block_goal = mvars.espionagePointDefenceBlockGoal	

			if TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.FOB_TIME_OVER )
			or TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.PLAYER_DEAD )
			or TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.PLAYER_FALL_DEAD )
			or TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.FOB_FULTONED ) then
				if this.RemovedPlayerStaffForFob() then
					Fox.Log("Host player removed.")
					mvars.fob_hostPlayerRemoved = true 	
					if TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.PLAYER_DEAD )
					or TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.PLAYER_FALL_DEAD ) then
						mvars.isCallStaffDeadRadio = true 	
					end

					
					
					if TppGameSequence.GetPatchVersion() >= PATCH_VERSION_DAY1 then
						if TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.FOB_TIME_OVER )
						or TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.FOB_FULTONED ) then
							Fox.Log("Day1 Patch AddtTempLos.")
							local staffId = Player.GetStaffIdAtInstanceIndex(OF_PLAYER_ID)
							Fox.Log("Day1 Patch AddtTempLos. staffId = " .. tostring(staffId))
							TppMotherBaseManagement.AddTempLostMyPlayerStaff{ staffId=staffId }
						end
					end
				else
					Fox.Log("Host player cannot remove.")
					
					
					if TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.PLAYER_DEAD )
					or TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.PLAYER_FALL_DEAD ) then
						svars.numDeadSnakeCount_OF = svars.numDeadSnakeCount_OF + 1
					
					elseif TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.FOB_TIME_OVER )
					or TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.FOB_FULTONED ) then
						svars.numFultonedSnakeCount_OF = svars.numFultonedSnakeCount_OF + 1
					end
				end
			end

			
			if TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.FOB_ABORT ) then
				Fox.Log("### Mission Abort By Menu or Disconnect ###")

				
				TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.FOB_ABORT_BY_MENU )

				
				TppServerManager.OpenWormhole{ open = true, retaliate = this.REVENGE_POINT.MAX }

				
				svars.fobResultType = FobResult.RESULT_ERROR

				
				TppMotherBaseManagement.ClearTempBuffer()
				Fox.Log( "TppMotherBaseManagement.ClearTempBuffer() (GameOver, Host, Actual, Abort)" )
				
				
				this.ClearResultSvars()

				
				TppEventLog.WriteEvent{
					event = EventLog.EVENT_MISSION_ABORT,
					playerIndex = 0,
					playerPos = Vector3( vars.playerPosX, vars.playerPosY, vars.playerPosZ ),
					playerDir = TppPlayer.GetRotation()
				}

				
				this.CalculateResult(CLEAR_TYPE_RESULT_ABORT)
				
				
				
				svars.fobAmountOfDamage = 0
				
				svars.fobGmpAdding_OF = 0
				svars.fobGmpSubtract_OF = 0
				svars.fobGmpAdding_DF = 0
				svars.fobGmpSubtract_DF = 0
				
			else
				this.CalculateResult()
			end

			
			TppEventLog.StopRecording()
		end,
		function ()
			
			fnc_vsCommon()

			
			TppMotherBaseManagement.ClearTempBuffer()
			Fox.Log( "TppMotherBaseManagement.ClearTempBuffer() (GameOver, Host, Sham)" )

		end,
		function ()
			if TppMotherBaseManagement.IsMbsOwner{} == true then
				TppMotherBaseManagement.ClearTempBuffer()
				Fox.Log( "TppMotherBaseManagement.ClearTempBuffer() (GameOver, Host, Visit)" )
			end
		end
	)

end







function this.OnGameOverClient( gameOverType )
	Fox.Log("### OnGameOverClient ###")

	
	TppMotherBaseManagement.ClearTempBuffer()
	Fox.Log( "TppMotherBaseManagement.ClearTempBuffer() (GameOver, Client)" )

	
	TppUiCommand.DeactivateSpySearchForFobDefense()

	
	this.SwitchExecByIsGameMode(
		function ()
			
			TppRanking.IncrementScore( "FobDefenceSucceedCount" )

			
			TppMotherBaseManagement.AwardedMeritMedalPointToPlayerStaff{ clearRank=TppDefine.MISSION_CLEAR_RANK.S } 
				
			
			this.ApplyWinReward()

			
			if TppMotherBaseManagement.IsMbsOwner{} ~= true then
				TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.DEFENCE_WIN_FOR_FRIEND )
			end

			
			if TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA )
			or TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.FOB_ABORT ) then
				
				TppUI.ShowAnnounceLog( "fobIntruderEscape" )
				o50050_radio.ClientMissionAbort()
				local defenceWinAbort = { heroicPoint = mvars.heroicPointDefenceWinAbort, ogrePoint = 0 }
				TppHero.SetAndAnnounceHeroicOgrePoint( defenceWinAbort, nil, "fobDefSuccess" )
			else
				
				local defenceWinEliminate = { heroicPoint = mvars.heroicPointDefenceWinEliminate, ogrePoint = 0 }
				TppHero.SetAndAnnounceHeroicOgrePoint( defenceWinEliminate, nil, "fobDefSuccess" )
			end

		end,
		function ()
			
			if TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA )
			or TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.FOB_ABORT ) then
				
				TppUI.ShowAnnounceLog( "fobIntruderEscape" )
				o50050_radio.ClientMissionAbort()
				TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.DEFENCE_WIN_ABORT_PRACTICE, nil, "fobDefSuccessPra" )
			else
				
				TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.DEFENCE_WIN_ELIMINATE_PRACTICE, nil, "fobDefSuccessPra" )
			end

		end,
		function ()

		end
	)

end










function this.OnMissionClearHost( missionClearType )
	Fox.Log("### OnMissionClearHost ###")

	
	this.DisableConnectClient()

	if missionClearType == TppDefine.MISSION_CLEAR_TYPE.FOB_GOAL then
		Fox.Log("### Goal!! You Win!! ###")

		this.SwitchExecByIsGameMode(
			function ()

				
				svars.fobResultType = FobResult.RESULT_GOAL

				
				TppServerManager.OpenWormhole{ open = false, retaliate = svars.numRevengePoint }
				
				if svars.fobIsThereRecoverStaff == true then
					this.AddHeroPointForResultOffence(TppHero.RETAKE_STAFF_FROM_FOB)
				end
				
				if svars.fobIsSneakForSupporter == true then
					this.AddHeroPointForResultOffence(TppHero.ATTAKCER_WIN_ON_FOB_FOR_FRIEND)
				end

				
				svars.fobIsHostWin = true

				
				local offenseWin = { heroicPoint = mvars.heroicPointOffenseWin, ogrePoint = 0 }
				this.AddHeroPointForResultOffence( offenseWin )

				
				
				TppMotherBaseManagement.AwardedMeritMedalPointToPlayerStaff{ clearRank=TppDefine.MISSION_CLEAR_RANK.S } 

				
				Fox.Log("### Set TppRanking.IncrementScore:FobSneakingGoalCount ###")
				TppRanking.IncrementScore( "FobSneakingGoalCount" )

				
				PlayRecord.RegistPlayRecord( "FOB_GOAL" )

				
				this.SetAndAnnounceEspPoint_Goal()

				
				this.ApplyWinReward()
				this.SetGoalRewardHost()

				
				TppEventLog.WriteEvent{
					event = EventLog.EVENT_PLAYER_GOAL,
					playerIndex = 0,
					playerPos = Vector3( vars.playerPosX, vars.playerPosY, vars.playerPosZ ),
					playerDir = TppPlayer.GetRotation()
				}
				
				TppEventLog.StopRecording()

				
				this.CalculateResult( CLEAR_TYPE_RESULT_GOAL )
			end,
			function ()
				
				svars.fobResultType = FobResult.RESULT_GOAL

				
				svars.fobIsHostWin = true

				if TppMotherBaseManagement.IsMbsOwner{} ~= true then
					Fox.Log("### Not Owner ###")
					
					this.AddHeroPointForResultOffence(TppHero.ATTAKCER_WIN_ON_FOB_PRACTICE)
				end
			end,
			function ()
			end
		)


	elseif missionClearType == TppDefine.MISSION_CLEAR_TYPE.FOB_ESCAPE then
		Fox.Log("### Escaped. Abort From FOB ###")
		
		svars.espt_df_block_goal = mvars.espionagePointDefenceBlockGoal	

		this.SwitchExecByIsGameMode(
			function ()
				
				svars.fobResultType = FobResult.RESULT_WORMHOLE

				
				TppServerManager.OpenWormhole{ open = false, retaliate = svars.numRevengePoint }

				
				svars.fobIsHostWin = false


				
				TppEventLog.WriteEvent{
					event = EventLog.EVENT_PLAYER_ESCAPE,
					playerIndex = 0,
					playerPos = Vector3( vars.playerPosX, vars.playerPosY, vars.playerPosZ ),
					playerDir = TppPlayer.GetRotation()
				 }
				
				TppEventLog.StopRecording()

				
				this.CalculateResult()
			end,
			function ()
				
				svars.fobResultType = FobResult.RESULT_WORMHOLE
				
				svars.fobIsHostWin = false
			end,
			function ()
			end
		)


	
	elseif missionClearType == TppDefine.MISSION_CLEAR_TYPE.FOB_DO_CRIME then
		if TppMotherBaseManagement.IsMbsOwner{} == false then
			
			this.CalculateRansomeResult()
			
			this.CalculateSecurityDamage()
		end
	end

end












function this.OnMissionClearClient( missionClearType )
	Fox.Log("### OnMissionClearClient ###")

	if missionClearType == TppDefine.MISSION_CLEAR_TYPE.FOB_GOAL then
		Fox.Log("### OffencePlayer arrived at goal. Mission failed. ###")
		this.SwitchExecByIsGameMode(
			function ()
				local defenceLose = { heroicPoint = mvars.heroicPointDefenceLose, ogrePoint = 0 }
				TppHero.SetAndAnnounceHeroicOgrePoint( defenceLose, "fobDefFailed", nil )
			end,
			function ()	end,
			function () end
		)
	elseif missionClearType == TppDefine.MISSION_CLEAR_TYPE.FOB_ESCAPE then
		Fox.Log("### OffencePlayer Escaped. Abort From FOB. ###")
		local fnc_vsCommon = function ()
			
			TppUI.ShowAnnounceLog( "fobIntruderEscape" )
		end
		this.SwitchExecByIsGameMode(
			function ()
				
				TppRanking.IncrementScore( "FobDefenceSucceedCount" )

				
				this.ApplyWinReward()

				fnc_vsCommon()
				local defenceWinAbort = { heroicPoint = mvars.heroicPointDefenceWinAbort, ogrePoint = 0 }
				TppHero.SetAndAnnounceHeroicOgrePoint( defenceWinAbort, nil, "fobDefSuccess" )

				
				if TppMotherBaseManagement.IsMbsOwner{} ~= true then
					TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.DEFENCE_WIN_FOR_FRIEND )
				end
			end,
			function ()
				fnc_vsCommon()
				TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.DEFENCE_WIN_ABORT_PRACTICE, nil, "fobDefSuccessPra" )

			end,
			function () end
		)
	end
	
	TppUiCommand.DeactivateSpySearchForFobDefense()
end





function this.IsNotShowGameOverMenu()
	Fox.Log("### IsNotShowGameOverMenu ###")
	return true
end







function this.MissionPrepare()
	do 
		local missionName = TppMission.GetMissionName()
		Fox.Log("*** " .. tostring(missionName) .. " RegiserMissionSystemCallback ***")
	end

	
	MotherBaseStage.LockCluster( MotherBaseStage.GetFirstCluster() )
	
	
	
	if not TppServerManager.FobIsSneak() then
		Gimmick.EnableNoEffectBreak(true)
	end

	
	this.securityStaffIds, this.rewardStaffIds = TppMotherBaseManagement.GetStaffsFob()

	
	this.currentClusterSetting.numClstId = MotherBaseStage.GetFirstCluster() + 1
	
	
	this.SetClusterDefine( this.currentClusterSetting.numClstId )

	this.currentClusterSetting.strMissionObjective = 	"clst_goalOfCurrentCluster_test"
	this.currentClusterSetting.strGoalMarker = 			this.CLST_PARAM[this.currentClusterSetting.numClstId].GOAL_MARKER
	this.currentClusterSetting.strGoalTrap = 			this.CLST_PARAM[this.currentClusterSetting.numClstId].GOAL
	this.currentClusterSetting.strEscapeWormholes = 	this.CLST_PARAM[this.currentClusterSetting.numClstId].ESCAPE_WORMHOLE
	this.currentClusterSetting.currentCpName = 			this.CLST_PARAM[this.currentClusterSetting.numClstId].CP_NAME
	this.currentClusterSetting.GuardTargetName = 		this.CLST_PARAM[this.currentClusterSetting.numClstId].GT_NAME
	this.currentClusterSetting.CbtSetName = 			this.CLST_PARAM[this.currentClusterSetting.numClstId].CBTSET_NAME
	this.currentClusterSetting.InnerZoneName = 			this.CLST_PARAM[this.currentClusterSetting.numClstId].INNER_ZONE_NAME
	this.currentClusterSetting.OuterZoneName = 			this.CLST_PARAM[this.currentClusterSetting.numClstId].OUTER_ZONE_NAME

	
	local grade = mtbs_cluster.GetClusterConstruct( this.currentClusterSetting.numClstId )
	
	
	if grade <= 2 then
		this.currentClusterSetting.CheckPoints = {
			this.CLST_PARAM[this.currentClusterSetting.numClstId].CHECK_POINTS.plnt1
		}
	elseif grade == 3 then
		this.currentClusterSetting.CheckPoints = {
			this.CLST_PARAM[this.currentClusterSetting.numClstId].CHECK_POINTS.plnt1,
			this.CLST_PARAM[this.currentClusterSetting.numClstId].CHECK_POINTS.plnt2,
		}
	elseif grade >= 4 then
		this.currentClusterSetting.CheckPoints = {
			this.CLST_PARAM[this.currentClusterSetting.numClstId].CHECK_POINTS.plnt1,
			this.CLST_PARAM[this.currentClusterSetting.numClstId].CHECK_POINTS.plnt2,
			this.CLST_PARAM[this.currentClusterSetting.numClstId].CHECK_POINTS.plnt3,
		}
	end

	
	mtbs_enemy.SetupClusterParam( this.CLST_PARAM )

	
	
	this.missionObjectiveDefine.clst_goalOfCurrentCluster_test = {
		gameObjectName = this.currentClusterSetting.strGoalMarker ,viewType = "all", visibleArea = 0, randomRange = 0, setNew = false, announceLog = "updateMap",
	}

	
	local command = { id = "SetIgnoreLookHeli" }
	local cpId = { type="TppCommandPost2" } 
	GameObject.SendCommand( cpId, command )

	this.PermitAbortResultOnPrepare()

	
	local systemCallbackTable ={
		
		
		OnEstablishMissionClear = function( missionClearType )
			
			TppUiStatusManager.UnsetStatus( "AnnounceLog", "INVALID_LOG" )
			TppUiStatusManager.SetStatus( "AnnounceLog", "SUSPEND_LOG" )

			this.SwitchExecByIsGameMode(
				function ()
					this.SwitchExecByIsHost( this.OnMissionClearHost, this.OnMissionClearClient, missionClearType )
					TppSequence.SetNextSequence( "Seq_ShowMissionClearDemo", { isExecMissionClear = true } )
				end,
				function ()
					this.SwitchExecByIsHost( this.OnMissionClearHost, this.OnMissionClearClient, missionClearType )
					TppSequence.SetNextSequence( "Seq_ShowMissionClearDemo", { isExecMissionClear = true } )
				end,
				function ()
					this.SwitchExecByIsHost( this.OnMissionClearHost, this.OnMissionClearClient, missionClearType )
					TppSequence.SetNextSequence( "Seq_ShowMissionClearDemo", { isExecMissionClear = true } )
				end
			)
		end,
		OnDisappearGameEndAnnounceLog = function()
			if TppMission.IsGameOver() then
				this.SwitchExecByIsGameMode(
					function ()
						
						TppMotherBaseManagement.AddMinimumSecurityStaffs{}
						if mvars.fob_hostPlayerRemoved then
							TppPlayer.ForceChangePlayerToSnake()
						end
						TppMission.ShowMissionResult()
					end,
					function ()
						TppMission.ShowMissionResult()
					end,
					function ()
						
						TppMotherBaseManagement.AddMinimumSecurityStaffs{}
						if mvars.fob_hostPlayerRemoved then
							TppPlayer.ForceChangePlayerToSnake()
						end
						TppMission.ShowMissionResult()
					end
				)
			else
				this.SwitchExecByIsGameMode(
					function ()
						TppSequence.SetNextSequence( "Seq_WaitSyncSVarsOnMissionClear", { isExecMissionClear = true } )
					end,
					function ()
						TppSequence.SetNextSequence( "Seq_ConfirmRetryPractice", { isExecMissionClear = true } )
					end,
					function ()
						TppSequence.SetNextSequence( "Seq_WaitSyncSVarsOnMissionClear", { isExecMissionClear = true } )
					end
				)
			end
		end,
		OnEndMissionCredit = function()
			
			if TppUiCommand.GetBonusPopupRegist( "staff" ) > 0 then
				TppUiCommand.ShowBonusPopupRegist( "staff" )
			else
				TppMission.OnEndMissionReward()
			end
		end,
		OnEndMissionReward = function()
			
			if not ( vars.fobSneakMode == FobMode.MODE_SHAM ) then
				TppTerminal.ReserveMissionStartMbSync()
			end

			
			local isSyncDefMissionClear, isSyncMissionClearType, isSyncDefGameOver, isSyncGameOverType = TppMission.GetSyncMissionStatus()
			if isSyncDefMissionClear then
				this.SwitchExecByIsHost(
					function()
						TppMission.MissionFinalize{ isNoFade = true }
					end, 	
					TppMission.ReturnToMission		
				)
			else
				this.SwitchExecByIsHost(
					TppMission.GameOverAbortMission, 	
					function()			
						TppMission.MissionFinalize{
							isInterruptMissionEnd = true,
							isNoFade = true,
						}
					end
				)
			end
			
			TppMission.ClearFobMode()
		end,
		OnMissionGameEndFadeOutFinish = function()		

			local clearTempBuffer = false

			
			this.SwitchExecByIsHost(
				function() 	
					this.SwitchExecByIsGameMode(
						
						function () end,
						
						function ()
							
							clearTempBuffer = true
							Fox.Log( "TppMotherBaseManagement.ClearTempBuffer() (Clear, Host, Sham)" )

						end,
						
						function ()
							
							if svars.mis_missionClearType == TppDefine.MISSION_CLEAR_TYPE.FOB_DO_CRIME then
								
								
								if TppMotherBaseManagement.IsMbsOwner{} == true then
									clearTempBuffer = true
									Fox.Log( "TppMotherBaseManagement.ClearTempBuffer() (Clear, Host, Visit, Crime)" )
								end
							else
								
								
								clearTempBuffer = true
								Fox.Log( "TppMotherBaseManagement.ClearTempBuffer() (Clear, Host, Visit, Not Crime)" )
							end
						end
					)
				end,
				function()	
					
					clearTempBuffer = true
					Fox.Log( "TppMotherBaseManagement.ClearTempBuffer() (Clear, Client)" )
				end
			)

			if clearTempBuffer == true then
				TppMotherBaseManagement.ClearTempBuffer()
			end

			this.SwitchExecByIsGameMode(
				
				function ()
					TppMotherBaseManagement.AddMinimumSecurityStaffs{}
				end,
				
				function ()	end,
				function ()
					TppMotherBaseManagement.AddMinimumSecurityStaffs{}
				end
			)
		end,
		
		
		
		
		
		OnGameOver = function( gameOverType )
			Fox.Log("OnGameOver gameOverType = " .. tostring(gameOverType))

			
			
			TppSoundDaemon.SetMute( 'Outro' )

			this.SwitchExecByIsGameMode(
				function ()
					this.SwitchExecByIsHost( this.OnGameOverHost, this.OnGameOverClient, gameOverType )
					TppSequence.SetNextSequence( "Seq_WaitSyncSVarsOnGameOver", { isExecGameOver = true } )
				end,
				function ()
					this.SwitchExecByIsHost( this.OnGameOverHost, this.OnGameOverClient, gameOverType )
					TppSequence.SetNextSequence( "Seq_ConfirmRetryPractice", { isExecGameOver = true } )
				end,
				function ()
					this.SwitchExecByIsHost( this.OnGameOverHost, this.OnGameOverClient, gameOverType )
					TppSequence.SetNextSequence( "Seq_WaitSyncSVarsOnGameOver", { isExecGameOver = true } )
				end
			)
			TppHero.UpdateHero()
			TppRanking.SendCurrentRankingScore()
			return this.IsNotShowGameOverMenu()
		end,
		
		
		
		OnOutOfMissionArea = function ()
			Fox.Log("OnOutOfMissionArea::")
			local hostOnOutOfMissionArea = function()
				Fox.Log("OnOutOfMissionArea::Host")
				
				if mvars.isClientSessionStart ~= true then
					TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA, TppDefine.GAME_OVER_RADIO.OUT_OF_MISSION_AREA )
				end
			end
			this.SwitchExecByIsHost(
				hostOnOutOfMissionArea,
				TppMission.ShowGameOverMenu
			)
		end,
		OnReturnToMission = function()
			Fox.Log("OnReturnToMission::")
		end,
		
		
		
		
		OnFobDefenceGameOver = function( fobDefenceGameOverType )
			Fox.Log("OnFobDefenceGameOver::")
			local vsCommonFunc = function (GameOverType)
				
				if ( GameOverType == TppDefine.FOB_DEFENCE_GAME_OVER_TYPE.PLAYER_DEAD ) then
					Fox.Log("OnFobDefenceGameOver::Can Respawn")
					TppUI.FadeOut( TppUI.FADE_SPEED.FADE_LOWSPEED, "FadeOutShowRespawnMenu" )
				end
			end

			this.SwitchExecByIsGameMode(
				vsCommonFunc,
				vsCommonFunc,
				function () end,
				fobDefenceGameOverType
			)


		end,
		nil
	}
	
	TppMission.RegiserMissionSystemCallback(systemCallbackTable)

	
	if DebugMenu then
		mvars.fobDebug = {}
		mvars.fobDebug.forceClearGoal = false
		DebugMenu.AddDebugMenu("FobLua", "ClearGoal", "bool", mvars.fobDebug, "forceClearGoal")
		mvars.fobDebug.forceClearEscape = false
		DebugMenu.AddDebugMenu("FobLua", "ClearEscape", "bool", mvars.fobDebug, "forceClearEscape")
		mvars.fobDebug.forceGameOverOutOfMissionArea= false
		DebugMenu.AddDebugMenu("FobLua", "GameOverOutOfMissionArea", "bool", mvars.fobDebug, "forceGameOverOutOfMissionArea")
		mvars.fobDebug.forceGameOverTimeOut = false
		DebugMenu.AddDebugMenu("FobLua", "GameOverTimeOut", "bool", mvars.fobDebug, "forceGameOverTimeOut")
		mvars.fobDebug.forceGameOverFultoned = false
		DebugMenu.AddDebugMenu("FobLua", "GameOverFultoned", "bool", mvars.fobDebug, "forceGameOverFultoned")
		mvars.fobDebug.forceWarpFromHeli = false
		DebugMenu.AddDebugMenu("FobLua", "forceWarpFromHeli", "bool", mvars.fobDebug, "forceforceWarpFromHeli")
		mvars.fobDebug.setTimeLimitEmergency = false
		DebugMenu.AddDebugMenu("FobLua", "setTimeLimitEmergency", "bool", mvars.fobDebug, "setTimeLimitEmergency")
		mvars.fobDebug.addTimeLimit60minute = false
		DebugMenu.AddDebugMenu("FobLua", "addTimeLimit60minute", "bool", mvars.fobDebug, "addTimeLimit60minute")
		mvars.fobDebug.forceCautionFocusArea = false
		DebugMenu.AddDebugMenu("FobLua", "forceCautionFocusArea", "bool", mvars.fobDebug, "forceCautionFocusArea")

		mvars.fobDebug.CalculateResult = false
		DebugMenu.AddDebugMenu("FobLua", "CalculateResult", "bool", mvars.fobDebug, "CalculateResult")

		mvars.fobDebug.dumpSvarsForResult = false
		DebugMenu.AddDebugMenu("FobLua", "dumpSvarsForResult", "bool", mvars.fobDebug, "dumpSvarsForResult")

		mvars.fobDebug.setFultonCount_OF = false
		DebugMenu.AddDebugMenu("FobLua", "setFultonCount_OF", "bool", mvars.fobDebug, "setFultonCount_OF")
		mvars.fobDebug.setDeadCount_OF = false
		DebugMenu.AddDebugMenu("FobLua", "setDeadCount_OF", "bool", mvars.fobDebug, "setDeadCount_OF")

		mvars.fobDebug.setFultonCount_DF = false
		DebugMenu.AddDebugMenu("FobLua", "setFultonCount_DF", "bool", mvars.fobDebug, "setFultonCount_DF")
		mvars.fobDebug.setDeadCount_DF = false
		DebugMenu.AddDebugMenu("FobLua", "setDeadCount_DF", "bool", mvars.fobDebug, "setDeadCount_DF")

		mvars.fobDebug.setTimeLimitForNonAbortLastSecond = false
		DebugMenu.AddDebugMenu("FobLua", "setTimeLimitForNonAbortLastSecond", "bool", mvars.fobDebug, "setTimeLimitForNonAbortLastSecond")

		mvars.fobDebug.setTimeLimitLastSecond = false
		DebugMenu.AddDebugMenu("FobLua", "setTimeLimitLastSecond", "bool", mvars.fobDebug, "setTimeLimitLastSecond")

		mvars.fobDebug.addRevengePoint_10 = false
		DebugMenu.AddDebugMenu("FobLua", "addRevengePoint_10", "bool", mvars.fobDebug, "addRevengePoint_10")

		mvars.fobDebug.dumpMbsParam = false
		DebugMenu.AddDebugMenu("FobLua", "dumpMbsParam", "bool", mvars.fobDebug, "dumpMbsParam")

		mvars.fobDebug.showSyncSVars = false
		DebugMenu.AddDebugMenu("FobLua", "showSyncSVars", "bool", mvars.fobDebug, "showSyncSVars")

		mvars.fobDebug.forceOpenWormhole = false
		DebugMenu.AddDebugMenu("FobLua", "forceOpenWormhole", "bool", mvars.fobDebug, "forceOpenWormhole")
		
		mvars.fobDebug.dumpSvarsForDamage = false
		DebugMenu.AddDebugMenu("FobLua", "dumpSvarsForDamage", "bool", mvars.fobDebug, "dumpSvarsForDamage")
		
		mvars.fobDebug.setSneakPlayer = false
		DebugMenu.AddDebugMenu("FobLua", "setSneakPlayer", "bool", mvars.fobDebug, "setSneakPlayer")

		mvars.fobDebug.setDefencePlayer = false
		DebugMenu.AddDebugMenu("FobLua", "setDefencePlayer", "bool", mvars.fobDebug, "setDefencePlayer")

	end
end


function this.OnEndMissionPrepareSequence()
	this.SwitchExecByIsGameMode(
		function () end,
		function ()
			
			vars.playerDisableActionFlag = PlayerDisableActionModeSham
		end,
		function ()
			Fox.Log("OnEndMissionPrepareSequence:: Set Disable Use Kill Weapon")
			
			this.SwitchExecByIsHost(
				function() end,
				function()
					
					vars.playerDisableActionFlag = PlayerDisableActionFlagMtbsDefault
					TppUiStatusManager.SetStatus(	"EquipHudAll", "ALL_KILL_NOUSE" )
				end
			)
		end
	)
end







this.missionObjectiveDefine = {
	clst_goalOfCurrentCluster_test = {
		gameObjectName = this.currentClusterSetting.strGoalMarker ,viewType = "all", visibleArea = 0, randomRange = 0, setNew = false, announceLog = "updateMap", 
	},

	
	announce_eliminateTarget = {
		announceLog = "eliminateTarget",
	},
	announce_achieveAllObjectives = {
		announceLog = "achieveAllObjectives",
	},

	announce_fob_defense_failed = {
		announceLog = "fobDefFailed",
	},
	announce_fob_defense_success = {
		announceLog = "fobDefSuccess",
	},

}


this.missionObjectiveTree = {
	clst_goalOfCurrentCluster_test = {},

	announce_eliminateTarget = {},
	announce_achieveAllObjectives = {},
	announce_fob_defense_failed = {},
	announce_fob_defense_success = {},
}

this.missionObjectiveEnum = Tpp.Enum{
	"clst_goalOfCurrentCluster_test",
	"announce_eliminateTarget",
	"announce_achieveAllObjectives",
	"announce_fob_defense_failed",
	"announce_fob_defense_success",
}






this.AddUniqueMapIconText = function ()
	Fox.Log("#### AddUniqueMapIconText ####")
	local markerId = this.currentClusterSetting.strGoalMarker
	this.SwitchExecByIsHost(
		function()
			
			TppUiCommand.RegisterIconUniqueInformation{ markerId = GameObject.GetGameObjectId(markerId) , langId="marker_fob_goal" }
		end,
		function()
			
			TppUiCommand.RegisterIconUniqueInformation{ markerId = GameObject.GetGameObjectId(markerId) , langId="marker_fob_goal" }
		end
	)
end




function this.Messages()
	local messageTable = {
 
			Player = {
			{
				msg = "Enter",
				sender = "fallDeath",
				func = function()
					
					
					
					
					if not TppServerManager.FobIsSneak() then
						Player.SetPadMask{
							settingName = "ClientFallDeath",
							except = true,
						}
						TppPlayer.PlayFallDeadCamera()
						
						mvars.mis_fobDisableAlertMissionArea = true
						
						if mvars.mis_isAlertOutOfMissionArea == true then
							
							mvars.mis_isAlertOutOfMissionArea = false
							TppMission.DisableAlertOutOfMissionArea()
						end
					else
						Player.SetPadMask{
							settingName = "HostFallDeath",
							except = true,
						}
						TppPlayer.PlayFallDeadCamera()
					end
				end,
				option = { isExecGameOver = true, isExecMissionClear = true },
			},
			{
				msg = "AbortFromWormhole",
				func = function ()
					
					Fox.Log("### Abort From WarmWhole ###")
					this.HideWarmHole()
				end,
				option = { isExecMissionClear = true }
			},
		},
 
		GameObject = {
			{
				msg = "Damage",
				func = function ( gameObjectId, attackId, attackerId )
					if vars.fobSneakMode == FobMode.MODE_VISIT then
						this.OnDamageInVisit( gameObjectId, attackId, attackerId )
					end
				end,
			},
		},
 
		UI = {
			{
				msg = "EndFadeOut",
				sender = "FadeOutShowExecuteRestart",
				func = function()
					
					mvars.fob_executeHostRestart = true
				end,
			},
		},
 
		Trap = {
			
			{
				msg = "Enter",
				sender = this.currentClusterSetting.strGoalTrap,
				func = function ( sender, gameObjectId )
					Fox.Log("#### Enter Goa: currentClusterSetting.strGoalTrap ####")
					if DEBUG then
						if mvars.DEBUG_noGoal == true then
							Fox.Log("#### Cannot Enter Goal: mvars.DEBUG_noGoal ####" .. tostring(mvars.DEBUG_noGoal))
						else
							this.EnterGoalArea(gameObjectId, mtbs_enemy.cpNameDefine)
						end
					else
						this.EnterGoalArea(gameObjectId, mtbs_enemy.cpNameDefine)
					end
				end,
			},
		},
 
		Timer = {
			{	
				msg = "Finish",
				sender = "TimeLimit",
				func = function ()
					Fox.Log("#### TimeOver ####")
					if mvars.isClientSessionStart ~= true then
						TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.FOB_TIME_OVER, TppDefine.GAME_OVER_RADIO.OUT_OF_MISSION_AREA )
					end
				end
			},
			{	
				msg = "Finish",
				sender = "TimerRivalApproach",
				func = function ()
					Fox.Log("#### TimerRivalApproach ####")

					mvars.fob_waitReadyRestart = true
				end
			},
		},
 
		Network = {
			{
				msg = "FobPeerNameResolved",
				func = function ()
					Fox.Log("#### Client Player Incomming!! ####")
					mvars.fob_addMemverLog = "#### Client Player Incomming! ####"
					
					if vars.fobSneakMode ~= FobMode.MODE_VISIT then
						local command = { id = "SetKeepCaution", enable=true }
						local gameObjectId = GameObject.GetGameObjectId( mtbs_enemy.cpNameDefine )
						GameObject.SendCommand( gameObjectId, command )
					end

					
					this.DisableConnectClient()

					this.StartWaitClientReadyForRestart()
					
				end
			},
			{
				msg = "OpenWormhole",
				func =	function()
					Fox.Log("#### OpenWormhole ####")
					
					svars.fobIsOpenWormhole = true
				end,
				option = { isExecMissionClear = true, isExecGameOver = true},
			},
		},
 
		Nt = {
			{
				msg = "SessionDeleteMember",
				func = function ()
					Fox.Log("#### Client Player Disconnected! ####")
					
					if TppGameSequence.GetPatchVersion() >= PATCH_VERSION_DAY1 then
						TppUiCommand.DeactivateSpySearchForFobSneak()
					end
					mvars.fob_SessionMemberDeleted = true

					if DEBUG then
						local DebugTextPrint = DebugText.Print
						local context = DebugText.NewContext()
						DebugTextPrint(context, {0.5, 0.5, 1.0}, "Client Player Disconnected!")
					end

					this.SwitchExecByIsGameMode(
						function ()	end,
						function () end,
						function ()
							
							TppUI.ShowAnnounceLog( "fob_leave_owner" )
						end
					)


				end
			},
			{
				msg = "SessionDisconnectFromHost",
				func = function ()
					Fox.Log("#### Host Player Disconnected! ####")
					svars.fobResultType = FobResult.RESULT_ERROR
					if DEBUG then
						local DebugTextPrint = DebugText.Print
						local context = DebugText.NewContext()
						DebugTextPrint(context, {0.5, 0.5, 1.0}, "Host Player Disconnected!")
					end
				end
			},
		},
		Marker = {
		},
	}
	return
	StrCode32Table( messageTable )
end









this.GameOverByCrime = function ()
	Fox.Log("#### GameOverByCrime ####")
	
	if TppServerManager.FobIsSneak() then
		mvars.isDoCrime = true
		if TppMotherBaseManagement.IsMbsOwner{} ~= true then
			TppServerManager.OpenWormhole{ open = true, retaliate = this.REVENGE_POINT.MAX }
			TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.NOTICE_CRIME )
		end
		
		TppMission.ReserveMissionClear {
			missionClearType = TppDefine.MISSION_CLEAR_TYPE.FOB_DO_CRIME,
			nextMissionId = TppDefine.SYS_MISSION_ID.MTBS_HELI
		}
	end
end






this.OnDamageInVisit = function( gameObjectId, attackId, attackerId )
	Fox.Log("#### OnDamageInVisit ####")
	
	local isSafeActiveAttack = function( attackId )
		if attackId == TppDamage.ATK_DownKick then
			return true
		else
			return false
		end
	end

	
	if attackerId == OF_PLAYER_ID then
		if isSafeActiveAttack(attackId) == false
		and TppDamage.IsActiveByAttackId( attackId ) then
			
			this.GameOverByCrime()
		end
	end
end






this.DisableConnectClient = function ()
	Fox.Log("#### DisableConnectClient ####")
	
	TppNetworkUtil.SessionEnableAccept( false )
	
	
	TppNetworkUtil.SessionDisconnectPreparingMembers()
end

this.PermitConnectClient = function ()
	Fox.Log("#### PermitConnectClient ####")
	
	TppNetworkUtil.SessionEnableAccept( true )
end








this.IsOffencePlayer = function ( playerObjId )
	if TppServerManager.FobIsSneak() and TppPlayer.IsSneakPlayerInFOB( playerObjId ) then
		Fox.Log("*** I'm OffencePlayer = ***")
		return true
	else
		Fox.Log("*** I'm DefencePlayer = ***")
		return false
	end
end

this.IsThereDefencePlayer = function()
	if TppNetworkUtil.GetSessionMemberCount() ~= 1 then
		Fox.Log("### IsThereDefencePlayer :: true ###")
		return true
	else
		Fox.Log("### IsThereDefencePlayer :: false ###")
		return false
	end
end

this.dbgSetMissionStartTime = function ()
	
	
	local start_time
	local n
	n = math.random(0,99)
	Fox.Log("*** MissionStartTimeParam = ***".. n)

	if (n % 4) == 0 then
		start_time = "12:00:00"
	elseif (n % 4) == 1 then
		start_time = "18:00:00"
	elseif (n % 4) == 2 then
		start_time = "23:00:00"
	elseif (n % 4) == 3 then
		start_time = "06:00:00"
	else
		Fox.Log("*** WrongParam:SetMissionStartTime ***")
	end

	TppClock.SaveMissionStartClock( start_time )

end







this.GetMissionLimitTime = function ()
	Fox.Log("*** GetMissionLimitTime ***")

	
	
	local clusterConstruct = mtbs_cluster.GetClusterConstruct(this.currentClusterSetting.numClstId)
	local limit_time = 3000
	local limitTimeList = {}
	
	limitTimeList = {
		this.TIME_LIMIT_RANK.NONE,
		this.TIME_LIMIT_RANK.F,
		this.TIME_LIMIT_RANK.E,
		this.TIME_LIMIT_RANK.D,
		this.TIME_LIMIT_RANK.C,
		this.TIME_LIMIT_RANK.B,
		this.TIME_LIMIT_RANK.A,
		this.TIME_LIMIT_RANK.S
	}

	
	
	local sectionRankForDefence = TppMotherBaseManagement.GetMbsSecuritySectionRank{ type = "Blockade" } + 1

	
	if limitTimeList[sectionRankForDefence] ~= nil then
		limit_time = limitTimeList[sectionRankForDefence]
	else
		Fox.Error("### SetRespawnTime :: Set time is nil ###")
	end

	return limit_time
end

this.GetMissionLimitTimeForFreePlay = function ()
	Fox.Log("*** GetMissionLimitTimeForFreePlay ***")

	
	
	local clusterConstruct = mtbs_cluster.GetClusterConstruct(this.currentClusterSetting.numClstId)
	local limit_time = 300

	if clusterConstruct > 0 then
		Fox.Log("*** plntCount ***".. clusterConstruct)
		limit_time = this.TIME_LIMIT.EACH_PLNT_FOR_FREE * clusterConstruct
		return limit_time
	else
		
		Fox.Log("*** plntCount ***".. clusterConstruct)
		return 3000
	end
end






this.StopTimerUI = function()
	TppUiCommand.EraseDisplayTimer()			
	TppUiCommand.SetDisplayTimerText( "" )		
end






this.EnterGoalArea = function ( enterObjID, cpName )
	
	if this.IsOffencePlayer( enterObjID ) == true then
		this.SwitchExecByIsHost(
			function()
				if mvars.isClientSessionStart ~= true then
					
					TppMission.ReserveMissionClear {
						missionClearType = TppDefine.MISSION_CLEAR_TYPE.FOB_GOAL,
						nextMissionId = TppDefine.SYS_MISSION_ID.MTBS_HELI
					}
				else
					Fox.Log("######## EnterGoalArea :: ClientSessionStarting ########")
				end
			end,
			function() end
		)

	end
end







this.GetGoalRewardStaff = function ()
	Fox.Log("######## GetGoalRewardStaff ########")

	return mvars.o50050_rewardStaffIds
end


this.GetGoalRewardResources = function ()
	Fox.Log("######## GetGoalRewardStaff ########")
	local numOfResources = 50
	return numOfResources
end


this.GetGoalRewardHerbs = function ()
	Fox.Log("######## GetGoalRewardStaff ########")
	local numOfHerbs = 10
	return numOfHerbs
end









this.ApplyWinReward = function()
	local rank = TppMotherBaseManagement.GetRewardLeagueRank{}
	local cluster = TppMotherBaseManagement.GetMbsFirstCluster{}
	TppMotherBaseManagement.AddPoolRewardsFob{
		leagueRank=rank,
		clusterCategory=cluster
	}
end






this.SetGoalRewardHost = function ()
	Fox.Log("######## SetGoalRewardHost ########")

	local stolenStaffs = this.GetGoalRewardStaff()		

	
	
	
	if #stolenStaffs > 0 then
		Fox.Log("######## SetGoalRewardHost ########::GetStaffs")
		
		svars.fobIsThereStolenStaff = true
		
		local CATEGORY = TppDefine.CLUSTER_NAME[this.currentClusterSetting.numClstId]

		
		local id = GameObject.CreateGameObjectId("TppSoldier2", 0 )

		for i, staffId in ipairs( stolenStaffs ) do
			
			TppMotherBaseManagement.AddTempStaffReward{ staffId=staffId, gameObjectId=id, tempStaffStatus=1, lang=0}
		end
	end

	
	TppMotherBaseManagement.AddTempStaffRecover{}

end





this.SetLooseRewardHost = function ()
	Fox.Log("######## SetLooseReward_Host ########")
	
	local currentPlayerCharacter = 0
	
	
	if currentPlayerCharacter == 0 then
		Fox.Log("######## Lost GMP for Snake ########")
		
		local ransomGMP = 10
		
	else
	
		Fox.Log("######## Lost Soldier ########")
	end
end





this.SetLooseRewardClient = function ()

end






this.FobUpdateRestartPoint = function ( playerId )
	Fox.Log("#### Enter : CheckPointTrap NO GIMMICK SAVE ####")
	if playerId == OF_PLAYER_ID then
		if TppServerManager.FobIsSneak() then
			
			TppPlayer.SetInitialPositionToCurrentPosition()

			
			TppEnemy.StoreSVars()
			
			TppMarker.StoreMarkerLocator()

			
			TppSave.ReserveVarRestoreForContinue() 
			TppSave.VarSave()
		end
	end
end









this.StartWaitClientReadyForRestart = function ()
	Fox.Log("######## StartWaitClientReadyForRestart ########")
	
	

	mvars.isClientSessionStart = true

	TppUiCommand.ShowSideFobInfo( "fob_rival", "hud_fob_rival_approach" )	

	
	Player.SetPadMask{
		settingName = "RivalApproach",
		except = true,
	}

	
	this.DisableAbort{ isDisplayTimer = false }

	
	this.StopTimerUI()

	
	local except = {}
	except["SideFobInfo"] = false
	except["AnnounceLog"] = false
	except["S_DISABLE_NPC"] = false

	
	Tpp.SetGameStatus{
		target = "all",
		enable = false,
		except = except,
		scriptName = "o50050_sequence.lua",
	}


	
	GkEventTimerManager.Start( "TimerRivalApproach", 5 )

	
	Player.CreateFobEncounterFilter()
	
	TppMusicManager.PostJingleEvent( "SingleShot", "Play_bgm_fob_jingle_matching" )

end

this.SetRivalApproachCamera = function( isPermit )
	Fox.Log("______o50050_sequence.SetRivalApproachCamera")

	Fox.Log("######## Act direct ########")
	Player.RequestToPlayCameraNonAnimation {
		
		characterId = GameObject.GetGameObjectIdByIndex("TppPlayer2", 0),
		
		isFollowPos = true,
		
		isFollowRot = true,
		
		followTime = 4,
		
		followDelayTime = 0.1,
		
		
		
		candidateRots = { {-2,164}, {-2,-164} },
		
		skeletonNames = {"SKL_004_HEAD", "SKL_011_LUARM", "SKL_021_RUARM" },
		
		
		skeletonCenterOffsets = { Vector3(0,0.1,0.05), Vector3(0.15,0,0), Vector3(-0.15,0,0) },
		skeletonBoundings = { Vector3(0.1,0.125,0.1), Vector3(0.15,0.05,0.05), Vector3(0.15,0.05,0.05) },

		
		
		
		offsetPos = Vector3(0.0,0.0,-1.0),
		
		focalLength = 21.0,
		
		aperture = 1.875,
		
		timeToSleep = 10,
		
		interpTimeAtStart = 2,

		
		fitOnCamera = false,
		
		
		timeToStartToFitCamera = 1,
		
		fitCameraInterpTime = 0.3,
		
		diffFocalLengthToReFitCamera = 16,

		
		isCollisionCheck = false,

		
		
		useLastSelectedIndex = false,

		
		callSeOfCameraInterp = true,
	}
end

this.StartFadeOutForRestart = function ()
	Fox.Log("######## StartFadeOutForRestart ########")
	TppUI.FadeOut( TppUI.FADE_SPEED.FADE_HIGHESTSPEED, "FadeOutShowExecuteRestart" )
end

this.HostExecuteRestart = function ()
	Fox.Log("######## HostExecuteRestart ########")

	
	TppEventLog.PauseRecording()

	
	TppSequence.ReserveNextSequence("Seq_Demo_SyncGameStart")

	
	TppHelicopter.ResetMissionStartHelicopterRoute()
	TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)

	
	TppMotherBaseManagement.SkipNextMissionStartTempBufferClear()

	
	TppEnemy.StoreSVars()
	TppWeather.StoreToSVars()

	
	TppSave.ReserveVarRestoreForContinue() 
	TppSave.VarSave()
	Fox.Log("######## HostExecuteRestart ######## gvars.sav_varRestoreForContinue = ".. tostring(gvars.sav_varRestoreForContinue))
		
	TppMission.ExecuteContinueFromCheckPoint()
end






this.EnterStartSneaknigFromHeli = function ()
	Fox.Log("### EnterStartSneaknigFromHeli mvars.isDoneWarpToHeli = " .. tostring(mvars.isDoneWarpToHeli))
	if mvars.isDoneWarpToHeli == false then
		
		mvars.isDoneWarpToHeli = true

		
		Player.RequestToHeliSideIdle()
		

		

		
		GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, { id="CreateWormhole", isEnter = true } )

	else
		Fox.Log("Already warp")
	end
end





this.EndStartSneaknigFromHeli = function ()
	Fox.Log("### EndStartSneaknigFromHeli ###")

	
	GameObject.SendCommand( { type="TppHeli2", index=0, }, { id="CreateWormhole", isEnter=true } ) 

	
	Player.SetPadMask{
		settingName = "fobWarpToStart",
		except = true,
	}

	
	Player.HeliSideToFOBStartPos()

	Fox.Log("### EndStartSneaknigFromHeli : pRotY = ###" .. tostring(pRotY))
	
	mvars.warpPlayerPos[2] = mvars.warpPlayerPos[2] + 1
	TppPlayer.Warp{ pos = mvars.warpPlayerPos, rotY = mvars.warpPlayerRotY ,fobRespawn = true}

	
	GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, { id="CreateWormhole", isEnter = false } )

	
	local ROT_LIST ={
		{ X = 15, Y = -15 },
		{ X = 5,  Y = -15 },
		{ X = -10,Y = -10 },
	}
	
	
	Player.RequestToSetCameraRotation {
		
		rotX = ROT_LIST[mvars.numStartPoint + 1].X,
		
		
		rotY = mvars.warpPlayerRotY + ROT_LIST[mvars.numStartPoint + 1].Y,

		
		interpTime = 2.4
	}

	if Player.StartFOBInvincible ~= nil then
		Player.StartFOBInvincible(PlayerInfo.GetLocalPlayerIndex())
	end
end






this.AfterStartSneaknigFromHeli = function ()	
	Fox.Log("### AfterStartSneaknigFromHeli ###")
	
	
	TppSequence.SetNextSequence("Seq_Game_FOB")

	mtbs_baseTelop.DispBaseName() 

	
	Player.ResetPadMask{
		settingName = "fobWarpToStart",
	}

	
	TppSoundDaemon.PostEvent( 'env_wormhole_out' )
end






this.UpdateStartPosition = function (param)
	
	local startPosId = 1

	
	
	if param == StrCode32(10) then
		startPosId = 0
	elseif param == StrCode32(20) then
		startPosId = 1
	elseif param == StrCode32(30) then
		startPosId = 2
	end

	Fox.Log("### UpdateStartPosition ###" .. startPosId)
	mvars.numStartPoint = startPosId
	
	
	local numClusterGrade = mtbs_cluster.GetClusterConstruct( this.currentClusterSetting.numClstId ) - 1
	local key = "player_locator_clst"..(this.currentClusterSetting.numClstId-1).."_plnt"..numClusterGrade.."_of".. mvars.numStartPoint

	Fox.Log("### MtbsStartPointIdentifier:key ###" .. key)
	mvars.warpPlayerPos, mvars.warpPlayerRotY = Tpp.GetLocator( "MtbsStartPointIdentifier", key ) 

	
	Player.SetWarpToPositionToWormholeFilter( Vector3(mvars.warpPlayerPos[1], mvars.warpPlayerPos[2], mvars.warpPlayerPos[3]) )
end



 





this.SetRespawnTime = function()
	Fox.Log("### SetRespawnTime ###")
	
	mvars.numDisableRespawnTime = 10
	
	local respawnTimeCountList = {}
	
	respawnTimeCountList = {
		60,		
		52,		
		48,		
		40,		
		32,		
		25,		
		16,		
		0,		
	}

	
	local rank = TppMotherBaseManagement.GetMbsCombatSectionRank{ type = "Defence" } + 1

	
	if respawnTimeCountList[rank] ~= nil then
		mvars.numDisableRespawnTime = respawnTimeCountList[rank]
	else
		Fox.Error("### SetRespawnTime :: Set time is nil ###")
	end
end



this.ShowRespawnMenu = function()
	Player.ResetPadMask{
		settingName = "ClientFallDeath",
	}

	Player.RequestToStopCameraAnimation{}	
	if Player.OnStartRespawnMenu ~= nil then
		Player.OnStartRespawnMenu()
	end

	
	TppUiStatusManager.SetStatus( "PauseMenu", "INVALID" )
	
	TppUI.OverrideFadeInGameStatus{
		EquipHud = false,
		EquipPanel = false,
		PauseMenu = false,
	}

	
	TppUI.FadeIn( TppUI.FADE_SPEED.FADE_HIGHESTSPEED )
	
	local numRspPoints = #mvars.respawnPosList
	local rspPoints = {}
	for i, key in pairs(mvars.respawnPosList) do
		local pos, rot = Tpp.GetLocator( "FobRespawnPointIdentifier", key ) 
		if pos ~= nil then
			rspPoints[i] = Vector3( pos[1], pos[2], pos[3] )
		end
	end
	TppUiCommand.StartRespawnMenuSetRecord{ wait = mvars.numDisableRespawnTime, record = numRspPoints, respawnPoints = rspPoints }
	this.ChangeRespawnPoint( 0, 0.001 )

	
	TppUiCommand.DeactivateSpySearchForFobDefense()

end









this.SetRespawnCamera = function ( param )
	
	Player.BeginRespawnCamera()
	
	Player.SetAroundCameraManualMode(true) 
	
	Player.SetAroundCameraManualModeParams{
		distance = param.distance,							
		target = Vector3(mvars.respawnPlayerPos),			
		targetInterpTime = param.interpCamTimeSec,			
		ignoreCollisionGameObjectName = "Player"	
	}
	Player.RequestToSetCameraRotation { rotX = 15, rotY = mvars.respawnPlayerRotY, interpTime = param.interpCamTimeSec }
	Player.UpdateAroundCameraManualModeParams()
end




this.ChangeRespawnPoint = function (respawnPointId, interpCamTimeSec )
	Fox.Log("### ChangeRespawnPoint :respawnPointId::###"..respawnPointId)

	
	local posId = respawnPointId
	local numClusterId = this.currentClusterSetting.numClstId-1
	local numClusterGrade = mtbs_cluster.GetClusterConstruct( this.currentClusterSetting.numClstId ) - 1
	local key = ""
	local interpCamTimeSec = interpCamTimeSec or 0.2

	
	key = mvars.respawnPosList[respawnPointId+1]

	
	if key == nil then
		Fox.Warning("o50050_sequence.ChangeRespawnPoint :: respawnPos is null")
		key = mvars.respawnPosList[1]
	end

	Fox.Log("### ChangeRespawnPoint :key::###"..key)
	mvars.respawnPlayerPos, mvars.respawnPlayerRotY = Tpp.GetLocator( "FobRespawnPointIdentifier", key ) 

	
	TppEffectUtility.CreateWormHoleEffect(mvars.respawnPlayerPos[1],mvars.respawnPlayerPos[2],mvars.respawnPlayerPos[3])

	
	mvars.respawnPlayerPos[2] = mvars.respawnPlayerPos[2] + 1

	this.SetRespawnCamera{ distance = RESPAWN_CAMERA_DISTANCE, interpCamTimeSec = interpCamTimeSec }
end






this.RespawnPlayer = function (respawnPointId)
	Fox.Log("### RespawnPlayer :respawnPointId::###"..respawnPointId)

	MotherBaseStage.SetFobClientPlayerRespawnTrg()

	TppUI.UnsetOverrideFadeInGameStatus()

	
	
	TppMain.EnableAllGameStatus()
	Player.SetAroundCameraManualMode(false)
	TppPlayer.Warp{ pos = mvars.respawnPlayerPos,rotY = mvars.respawnPlayerRotY ,fobRespawn = true}
	
	mvars.mis_fobDisableAlertMissionArea = false
	mvars.mis_isAlertOutOfMissionArea = false
	
	TppUiStatusManager.ClearStatus( "PauseMenu" )
	TppUiStatusManager.ClearStatus( "EquipHud" )
	TppUiStatusManager.ClearStatus( "EquipPanel" )

	TppUiCommand.ActivateSpySearchForFobDefense()
end


 

function this.GetAbortWarmHolePosition()
	Fox.Log("######## GetAbortWarmHolePosition ######## ")
	
	local pos = GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex(0) }, { id="GetWormholePosition" } )
	local trans = {}
	trans = TppMath.Vector3toTable(pos)
	
	svars.posAbortWarmhole_x = trans[1]
	svars.posAbortWarmhole_y = trans[2]
	svars.posAbortWarmhole_z = trans[3]

end

function this.SetAbortWarmHole()
	Fox.Log("######## SetAbortWarmHole ######## ")
	
	GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, { id="SetWormholePosition", position = Vector3{svars.posAbortWarmhole_x,svars.posAbortWarmhole_y,svars.posAbortWarmhole_z} } )
	
	GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, { id="SetWormhole", disp = true } )
end

function this.HideWarmHole()
	Fox.Log("######## HideWarmHole ######## ")
	GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, { id="SetWormhole", disp = false } )
end



function this.OpenAbortWarmhole()
	Fox.Log("######## OpenAbortWarmhole ######## ")
	
	GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, { id="SetWormholeIcon", enable=true } )
end

function this.PermitAbort()
	Fox.Log("######## PermitAbort ######## ")
	
	if TppServerManager.FobIsSneak() then
		
		GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, { id="SetWormholeIconType", enable = true } )	
	end

	
	
	if TppGameSequence.GetPatchVersion() >= PATCH_VERSION_DAY1 then
		TppUiCommand.EraseWormHoleTimer()
	end
end

function this.DisableAbort( param )
	Fox.Log("######## DisableAbort ######## param.isDisplayTimer = " .. tostring(param.isDisplayTimer))
	
	if TppGameSequence.GetPatchVersion() >= PATCH_VERSION_DAY1 then
		if param.isDisplayTimer == true then
			
			TppUiCommand.StartWormHoleTimer( this.TIME_LIMIT.NON_ABORT )
		elseif param.isDisplayTimer == false then
			TppUiCommand.StartWormHoleTimer()
		end
	end
	
	GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, { id="SetWormholeIconType", enable = false } )	
end


 
	
	

function this.RequestNoticeGimmick(gimmickId, playerId)
	Fox.Log("######## RequestNoticeGimmick ######## gimmickId::".. gimmickId .. "playerId::" .. playerId)
	if this.IsOffencePlayer( playerId ) then
		local cp = GameObject.GetGameObjectId( mtbs_enemy.cpNameDefine )
		local command = { id = "RequestNotice", type = 0, targetId = gimmickId, sourceId = playerId }
		GameObject.SendCommand( cp, command )
	end
end




this.IsAirGun = function( gameObjectId )
	if gameObjectId == nil then
		if DEBUG then
			Fox.Error("gameObjectId is nil. GameObjectTypeCheck called from " .. Tpp.DEBUG_Where(2) )
		end
		return
	end
	if gameObjectId == NULL_ID then return end
	local gameObjectType = GameObject.GetTypeIndex(gameObjectId)
	return gameObjectType == TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN
end


this.IsMortar = function( gameObjectId )
	if gameObjectId == nil then
		if DEBUG then
			Fox.Error("gameObjectId is nil. GameObjectTypeCheck called from " .. Tpp.DEBUG_Where(2) )
		end
		return
	end
	if gameObjectId == NULL_ID then return end
	local gameObjectType = GameObject.GetTypeIndex(gameObjectId)
	return gameObjectType == TppGameObject.GAME_OBJECT_TYPE_MORTAR
end


this.IsMachineGun = function( gameObjectId )
	if gameObjectId == nil then
		if DEBUG then
			Fox.Error("gameObjectId is nil. GameObjectTypeCheck called from " .. Tpp.DEBUG_Where(2) )
		end
		return
	end
	if gameObjectId == NULL_ID then return end
	local gameObjectType = GameObject.GetTypeIndex(gameObjectId)
	return gameObjectType == TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN
end
 
this.IsIrSensor = function( gameObjectId )
	if gameObjectId == nil then
		if DEBUG then
			Fox.Error("gameObjectId is nil. GameObjectTypeCheck called from " .. Tpp.DEBUG_Where(2) )
		end
		return
	end
	if gameObjectId == NULL_ID then return end
	local gameObjectType = GameObject.GetTypeIndex(gameObjectId)
	return gameObjectType == TppGameObject.GAME_OBJECT_TYPE_IR_SENSOR
end

this.IsSecurityAlarm = function( gameObjectId, locatorNameHash, dataSetNameHash )
	Fox.Log("### IsSecurityAlarm ### ")
	if gameObjectId == nil then
		if DEBUG then
			Fox.Error("gameObjectId is nil. GameObjectTypeCheck called from " .. Tpp.DEBUG_Where(2) )
		end
		return
	end
	if gameObjectId == NULL_ID then return end
	local gameObjectType = GameObject.GetTypeIndex(gameObjectId)
	if gameObjectType == TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE then
		Fox.Log("### IsSecurityAlarm ### :: IsBreakable ")
		local test = TppGimmick.GetGimmickID( gameObjectId, locatorNameHash, dataSetNameHash )
		Fox.Log("### IsSecurityAlarm ### :: GetGimmickId =  " .. tostring(test))
		if TppGimmick.GetGimmickID( gameObjectId, locatorNameHash, dataSetNameHash ) == nil then
			Fox.Log("### IsSecurityAlarm ### :: SecurityAlarm ")
			return true
		else
			Fox.Log("### IsSecurityAlarm ### :: Not SecurityAlarm ")
			return false
		end
		Fox.Log("### IsSecurityAlarm ### :: Not SecurityAlarm ")
		return false
	end
end

  
this.AddTempClash = function( gameObjectId, locatorNameHash, dataSetNameHash, AttackerId )
	if TppGameSequence.GetPatchVersion() >= PATCH_VERSION_DAY1 then
		Fox.Log("Day1 Patch AddtTempLos.")
		
		Fox.Log("### AddTempClash ###")
		if (vars.fobSneakMode == FobMode.MODE_ACTUAL or vars.fobSneakMode == FobMode.MODE_VISIT) and TppServerManager.FobIsSneak() then
			
			if this.IsAirGun(gameObjectId) then
				Fox.Log("### AddTempClash ### :: IsAirGun")
				local isWest = Gimmick.IsWestSideWeapon(gameObjectId)
				Fox.Log("### AddTempClash ### :: isWest = " .. tostring(isWest))
				if isWest == true then
					TppMotherBaseManagement.AddTempClashedPlacementCount{ resourceId=TppMotherBaseManagementConst.RESOURCE_ID_ANTI_AIR_GATLING_GUN_WEST }
				elseif isWest == false then
					TppMotherBaseManagement.AddTempClashedPlacementCount{ resourceId=TppMotherBaseManagementConst.RESOURCE_ID_ANTI_AIR_GATLING_GUN_EAST }
				end
			end
			
			if this.IsMachineGun(gameObjectId) then
				Fox.Log("### AddTempClash ### :: IsMachineGun")
				local isWest = Gimmick.IsWestSideWeapon(gameObjectId)
				Fox.Log("### AddTempClash ### :: isWest = " .. tostring(isWest))
				if isWest == true then
					TppMotherBaseManagement.AddTempClashedPlacementCount{ resourceId=TppMotherBaseManagementConst.RESOURCE_ID_EMPLACEMENT_GUN_WEST }
				elseif isWest == false then
					TppMotherBaseManagement.AddTempClashedPlacementCount{ resourceId=TppMotherBaseManagementConst.RESOURCE_ID_EMPLACEMENT_GUN_EAST }
				end
			end
			
			if this.IsMortar(gameObjectId) then
				Fox.Log("### AddTempClash ### :: IsMortar")
				TppMotherBaseManagement.AddTempClashedPlacementCount{ resourceId=TppMotherBaseManagementConst.RESOURCE_ID_MORTAR_NORMAL }
			end
		else
			Fox.Log("### AddTempClash ### :: disable add temp")
		end
	end
end


 
function this.SwitchGoalAreaSpot( switch, clstId )
	Fox.Log("### SwitchGoalAreaSpot ### :: switch " .. tostring(switch) .. " clstId = " ..tostring(clstId))
	if switch == true then
		local posList = {
			{4.689891,24.000,-3.934969},
			{-2.009,24,14.312},
			{22.44574,28,-5.500154},
			{-18,-4,-11.28},
			{-17,4,6.518},
			{8.1,28,-9.115},
			{-9.495,8,21.525},
		}
		local rotList = {
			90,
			180,
			270,
			180,
			45,
			225,
			90,
		}
		local pos = posList[clstId+1]
		local rot = rotList[clstId+1]
		local posSpotList, rotSpotY = mtbs_cluster.GetPosAndRotY_FOB( TppDefine.CLUSTER_NAME[clstId+1], "plnt0", pos , rot )
		local posSpot = Vector3(posSpotList[1],posSpotList[2]+0.0001,posSpotList[3])
		Fox.Log("### SwitchGoalAreaSpot ### :: posSpot " .. tostring(posSpot) .. " rot = " ..rot .. " rotSpotY = ".. rotSpotY)
		
		TppUiCommand.SetMbStageSpot( "goal_show", posSpot, rotSpotY )
		
		TppUiCommand.SetMbStageSpot( "goal_open" )
	elseif switch == false then
		TppUiCommand.SetMbStageSpot( "goal_close" )
	end

end



 

this.IsSnake = function( playerId, staffId )
	Fox.Log("### IsSnake ### ")
	local pType = Player.GetPlayerType( { instanceIndex = playerId} )
		








	
	if (pType == 0) or (pType == 3) or (pType == 4) then
		Fox.Log("### IsSnake : This is Snake!!###")
		return true
	else
		Fox.Log("### IsSnake : This is not Snake!!###")
		return false
	end
end

this.IsNonPermitLost = function( playerId, staffId )
	Fox.Log("### IsNonPermitLost ###  :: vars.returnStaffHeader = " .. tostring(vars.returnStaffHeader) .. ", vars.returnStaffSeeds = " .. tostring(vars.returnStaffSeeds) )
	




	local isStaffInSortie = Player.IsStaffInSortie(playerId)
	Fox.Log("### IsNonPermitLost ### isStaffInSortie = " .. tostring(isStaffInSortie))
	return isStaffInSortie
end



 
	

  
this.OffencePlayerDead = function( playerId, AttackerId )
	Fox.Log("### OffencePlayerDead ###")

	this.SwitchExecByIsGameMode(
		function ()
			if AttackerId == DF_PLAYER_ID then
				
				svars.espt_df_kill_ofp = ESPT_DF_KILL_OFP

				
				
				this.AddRevengePoint(0, true)
			end
		end,
		function () end,
		function () end
	)

end

  
this.KillOffencePlayer = function( deadId, AttackerId )
	Fox.Log("### KillOffencePlayer ###")

	if AttackerId == DF_PLAYER_ID then
		if vars.fobSneakMode == FobMode.MODE_ACTUAL then
			this.SetAndAnnounceEspPoint_EliminateOF()
			Fox.Log("### This is Not Practice ###" .. vars.fobSneakMode)
			
			
			TppMotherBaseManagement.AwardedHonorMedalToPlayerStaff()

			
			TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.KILLED_PLAYER )

		elseif vars.fobSneakMode == FobMode.MODE_SHAM then
			Fox.Log("### This is Practice ###" .. vars.fobSneakMode)
		end
	end
end


  
  
  
this.KillDefencePlayer = function( deadPlayerId, attakerId )
	Fox.Log("### KillDefencePlayer ###")
	
	if TppGameSequence.GetPatchVersion() >= PATCH_VERSION_DAY1 then
		TppUiCommand.DeactivateSpySearchForFobSneak()
	end

	
	if this.IsNonPermitLost(deadPlayerId) == false then
		
		local staffId = Player.GetStaffIdAtInstanceIndex(deadPlayerId)
		
		Fox.Log("### Killed Defence Player :: can Lost ###" .. tostring(staffId))

		
		if TppGameSequence.GetPatchVersion() >= PATCH_VERSION_DAY1 then
			
			local isDefenderEqualSupporter = TppMotherBaseManagement.IsOpponentSupporter{}
			TppMotherBaseManagement.KillTempStaffFob{ staffId = staffId, gameObjectId = deadPlayerId, isFobSupporter = isDefenderEqualSupporter }
		else
			
			
			TppMotherBaseManagement.KillTempStaffFob{ staffId = staffId, gameObjectId = deadPlayerId }
		end
	
	elseif this.IsNonPermitLost(deadPlayerId, staffId) == true then
		Fox.Log("### Killed Defence Player :: cannnot Lost ###")
		
		local currentAdd = GMP_FOR_RANSOM_DEFAULT
		if Player.GetFobDeployGmpCost then
			local currentCost = Player.GetFobDeployGmpCost(DF_PLAYER_ID)
			if currentAdd < currentCost then
				currentAdd = currentCost
			end
		end
		svars.fobGmpAdding_OF = svars.fobGmpAdding_OF + currentAdd
	end

	this.SwitchExecByIsGameMode(
		function ()
			if attakerId == OF_PLAYER_ID then
				
				this.AddRevengePoint(this.REVENGE_POINT.KILL_PLAYER)
				this.SetAndAnnounceEspPoint_EliminateDF()
				TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.KILLED_PLAYER )
			end
		end,
		function () end,
		function ()
			if attakerId == OF_PLAYER_ID then
				this.GameOverByCrime()
			end
		end
	)
end

  
this.DefencePlayerDead = function( playerId, AttackerId )
	Fox.Log("### DefencePlayerDead by Offence ###")
	this.SwitchExecByIsGameMode(
		function ()
			
			if AttackerId == OF_PLAYER_ID then
				this.SetAnnounceEspPoint( {downPoint = ESPT_DF_DEAD, downLangId = "espKill_d"} )
			end
			
			if TppGameSequence.GetPatchVersion() >= PATCH_VERSION_DAY1 then
				Fox.Log("Day1 Patch AddtTempLos.")
				
				if this.IsNonPermitLost(playerId) == false then
					
					local staffId = Player.GetStaffIdAtInstanceIndex(DF_PLAYER_ID)
					TppMotherBaseManagement.AddTempLostMyPlayerStaff{ staffId=staffId }
				end
			end
		end,
		function () end,
		function ()
			
			if AttackerId ~= OF_PLAYER_ID then
				Fox.Log("OnFobDefenceGameOver:: Leave Visit Mode")
				TppUI.FadeOut( TppUI.FADE_SPEED.FADE_LOWSPEED, "FadeOutLeaveVisitMode" )
			end
		end
	)

end

this.GameRestartCamera = function()

	Player.RequestToSetCameraRotation {
		
		rotX = 15,
		
		rotY = vars.playerRotY,

		
		interpTime = 1
	}

end


 

this.AddRevengePoint = function( addPoint, isEnableOpen )
	
	local addPt = addPoint
	if vars.fobSneakMode == FobMode.MODE_ACTUAL and TppServerManager.FobIsSneak() then
		Fox.Log("### AddRevengePoint :: addPoint = ".. tostring(addPoint))
		Fox.Log("### AddRevengePoint :: totalPoint = ".. tostring(svars.fobRevengePointTotal))

		
		if (svars.fobRevengePointTotal + addPt) > this.REVENGE_POINT.MAX then
			addPt = this.REVENGE_POINT.MAX - svars.fobRevengePointTotal
			Fox.Log("### AddRevengePoint :: addPointUpdate ===> ".. tostring(addPt))
		end
		
		svars.numRevengePoint = svars.numRevengePoint + addPt
		svars.fobRevengePointTotal = svars.fobRevengePointTotal + addPt

		
		if svars.fobRevengePointTotal <= this.REVENGE_POINT.MAX then
			
			if (TppEnemy.GetPhase( mtbs_enemy.cpNameDefine ) == TppEnemy.PHASE.ALERT) or (isEnableOpen == true )then
				TppServerManager.OpenWormhole{ open = true, retaliate = svars.numRevengePoint }
				svars.numRevengePoint = 0	
			
			else
				TppServerManager.OpenWormhole{ open = false, retaliate = svars.numRevengePoint }
				svars.numRevengePoint = 0	
			end
		end
	end
end


 




 

  
this.AddHeroPointForResultOffence = function( addPointTable )
	local hPoint = addPointTable.heroicPoint
	local oPoint = addPointTable.ogrePoint

	
	Fox.Log("### AddHeroPointForResultOffence :: addPointHero = ".. tostring(hPoint) .. "addPointOrg = " ..tostring(oPoint))
	if hPoint > 0 then
		svars.fobHeroAdding_OF = svars.fobHeroAdding_OF + hPoint
	else
		svars.fobHeroSubtract_OF = svars.fobHeroSubtract_OF + hPoint
	end
	
	
	if hPoint < 0 then
		TppMotherBaseManagement.SubHeroicPoint{ heroicPoint = -hPoint }
	elseif hPoint > 0 then
		TppMotherBaseManagement.AddHeroicPoint{ heroicPoint = hPoint }
	end

	
end

  
this.AddHeroPointForResultDefence = function( addPointTable )
	local hPoint = addPointTable.heroicPoint
	local oPoint = addPointTable.ogrePoint

	Fox.Log("### AddHeroPointForResultDefence :: addPointHero = ".. tostring(hPoint) .. "addPointOrg = " ..tostring(oPoint))
	if hPoint > 0 then
		svars.fobHeroAdding_DF = svars.fobHeroAdding_DF + hPoint
	else
		svars.fobHeroSubtract_DF = svars.fobHeroSubtract_DF + hPoint
	end
	
	
	if hPoint < 0 then
		TppMotherBaseManagement.SubHeroicPoint{ heroicPoint = -hPoint }
	elseif hPoint > 0 then
		TppMotherBaseManagement.AddHeroicPoint{ heroicPoint = hPoint }
	end

	
end


  
  
this.SetHeroicPointForClient_DiscoverAttacker = function ()
	Fox.Log("### SetHeroicPointForClient_DiscoverAttacker ###")
	
	if vars.fobSneakMode == FobMode.MODE_ACTUAL and mvars.isOccuredPlayerDamage == false then
		
		mvars.isOccuredPlayerDamage = true
		
		TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.DISCOVER_ATTACKER, nil , "fobFindIntruder")
	end
end



 

  
this.SetHeroicOnFultonPlayer = function()
	Fox.Log("### SetHeroicOnFultonPlayer ###")
	if vars.fobSneakMode == FobMode.MODE_ACTUAL then
		Fox.Log("### This is Not Practice ###" .. vars.fobSneakMode)
		TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.FULTONED_PLAYER )
	elseif vars.fobSneakMode == FobMode.MODE_SHAM then
		Fox.Log("### This is Practice ###" .. vars.fobSneakMode)
	end
end

  
this.FultonOffencePlayer = function( playerId, staffId, fultonExecuteId )
	Fox.Log("### FultonOffencePlayer ###")

	
	if fultonExecuteId == DF_PLAYER_ID then
		this.SetAndAnnounceEspPoint_FultonOF()
		if vars.fobSneakMode == FobMode.MODE_ACTUAL then
			Fox.Log("### This is Not Practice ###" .. vars.fobSneakMode)
			TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.FULTONED_PLAYER )
			TppMotherBaseManagement.AwardedHonorMedalToPlayerStaff()	
			
		elseif vars.fobSneakMode == FobMode.MODE_SHAM then
			Fox.Log("### This is Practice ###" .. vars.fobSneakMode)
		end
	end
end

  
this.OffencePlayerFultoned = function( playerId, staffId, fultonExecuteId )
	Fox.Log("### OffencePlayerFultoned ###")
	local pType = Player.GetPlayerType( { instanceIndex = playerId} )

	
	if vars.fobSneakMode == FobMode.MODE_ACTUAL then
		Fox.Log("### This is Not Practice ###" .. vars.fobSneakMode)
		
		TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.FULTONED )

		if fultonExecuteId == DF_PLAYER_ID then
			svars.espt_df_fulton_ofp = ESPT_DF_FULTON_OFP

			
			this.AddRevengePoint(0, true)

		end
	end

	TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.FOB_FULTONED, TppDefine.GAME_OVER_RADIO.OUT_OF_MISSION_AREA ) 	
end


  
this.FultonDefencePlayer = function( playerId, staffId )
	Fox.Log("### Fultoned Defence Player ###")
	if TppGameSequence.GetPatchVersion() >= PATCH_VERSION_DAY1 then
		TppUiCommand.DeactivateSpySearchForFobSneak()
	end
	this.SetAndAnnounceEspPoint_FultonDF()
	
	


	local function AddTempStaffOnDefencePlayerFultoned( playerId, staffId )
		Fox.Log(" ### Fultoned Defence Player :: can Flton : AddTempStaffOnDefencePlayerFultoned ### playerId = " .. playerId .. "::staffId = "..staffId)
		if TppGameSequence.GetPatchVersion() >= PATCH_VERSION_DAY1 then
			
			local isDefenderEqualSupporter = TppMotherBaseManagement.IsOpponentSupporter{}
			TppTerminal.AddTempStaffFulton{ staffId = staffId, gameObjectId = playerId, isFobSupporter = isDefenderEqualSupporter }
		else
			TppTerminal.AddTempStaffFulton{ staffId = staffId, gameObjectId = playerId }
		end
	end

	


	local function AddRansomeOnDefencePlayerFultoned()
		Fox.Log("### Fultoned Defence Player :: cannnot Flton : AddRansomeOnDefencePlayerFultoned ###")
		local currentAdd = GMP_FOR_RANSOM_DEFAULT
		
		if Player.GetFobDeployGmpCost then
			local currentCost = Player.GetFobDeployGmpCost(DF_PLAYER_ID)
			if currentAdd < currentCost then
				currentAdd = currentCost
			end
		end
		currentAdd = currentAdd * GMP_FOR_RANSOM_FULTON_BONUS
		svars.fobGmpAdding_OF = svars.fobGmpAdding_OF + currentAdd
	end

	this.SwitchExecByIsGameMode(
		
		function ()
			
			this.AddRevengePoint(this.REVENGE_POINT.FULTON_PLAYER)

			
			if this.IsNonPermitLost(playerId, staffId) == false then
				
				svars.fobIsThereStolenStaff = true
				AddTempStaffOnDefencePlayerFultoned( playerId, staffId )
			
			elseif this.IsNonPermitLost(playerId, staffId) == true then
				AddRansomeOnDefencePlayerFultoned()
			end
		end,
		
		function () end,
		
		function ()
			if this.IsNonPermitLost(playerId, staffId) == false then
				AddTempStaffOnDefencePlayerFultoned( playerId, staffId )
			elseif this.IsNonPermitLost(playerId, staffId) == true then
				AddRansomeOnDefencePlayerFultoned()
			end
			this.GameOverByCrime()
		end
	)

end

  
this.DefencePlayerFultoned = function( playerId, staffId )
	Fox.Log("### DefencePlayerFultoned ###")
	this.SwitchExecByIsGameMode(
		function ()
			
			this.SetAnnounceEspPoint( {downPoint = ESPT_DF_FULTONED, downLangId = "espFulton_d"} )
			if not this.IsNonPermitLost( playerId, staffId ) then
				mvars.fob_removeFultonedDefencePlayer = true
				
				if TppGameSequence.GetPatchVersion() >= PATCH_VERSION_DAY1 then
					Fox.Log("Day1 Patch AddtTempLos.")
					TppMotherBaseManagement.AddTempLostMyPlayerStaff{ staffId=staffId }
				end
			end
		end,
		function () end,
		function () end
	)


	TppUI.FadeOut( TppUI.FADE_SPEED.FADE_LOWSPEED, "FadeOutShowRespawnMenu" )
end





 
this.SetSecurityVars = function ()
	
	
	local isSecCameraMode
	local numDevelopLevel
	local INIT_GRADE_SEC_CAMERA = 3 - 1
	local INIT_GRADE_GUN_CAMERA = 4 - 1

	isSecCameraMode, numDevelopLevel = mtbs_enemy._GetSecurityCameraSetting()

	
	svars.fobSecCameraIsNokillMode = not(isSecCameraMode)
	if numDevelopLevel ~= 0 then
		if isSecCameraMode == true then
			svars.fobSecCameraGrade = numDevelopLevel + INIT_GRADE_SEC_CAMERA
		else
			svars.fobSecCameraGrade = numDevelopLevel + INIT_GRADE_GUN_CAMERA
		end
	end

	
	local isDevelopedUav
	local numDevelopType
	local SLP_UAV_INIT_GRADE = 7
	local SMK_UAV_INIT_GRADE = 4
	local LMG_UAV_INIT_GRADE = 3

	isDevelopedUav, numDevelopType = mtbs_enemy._GetUavSetting()
	if isDevelopedUav == true then
		if numDevelopType == TppUav.DEVELOP_LEVEL_LMG_0 then
			svars.fobSecUavGrade		= LMG_UAV_INIT_GRADE
			svars.fobSecUavIsNokillMode	= false
		elseif numDevelopType == TppUav.DEVELOP_LEVEL_LMG_1 then
			svars.fobSecUavGrade		= LMG_UAV_INIT_GRADE + 1
			svars.fobSecUavIsNokillMode	= false
		elseif numDevelopType == TppUav.DEVELOP_LEVEL_LMG_2 then
			svars.fobSecUavGrade		= LMG_UAV_INIT_GRADE + 2
			svars.fobSecUavIsNokillMode	= false
		elseif numDevelopType == TppUav.DEVELOP_LEVEL_SMOKE_0 then
			svars.fobSecUavGrade		= SMK_UAV_INIT_GRADE
			svars.fobSecUavIsNokillMode	= true
		elseif numDevelopType == TppUav.DEVELOP_LEVEL_SMOKE_1 then
			svars.fobSecUavGrade		= SMK_UAV_INIT_GRADE + 1
			svars.fobSecUavIsNokillMode	= true
		elseif numDevelopType == TppUav.DEVELOP_LEVEL_SMOKE_2 then
			svars.fobSecUavGrade		= SMK_UAV_INIT_GRADE + 2
			svars.fobSecUavIsNokillMode	= true
		elseif numDevelopType == TppUav.DEVELOP_LEVEL_SLEEP_0 then
			svars.fobSecUavGrade		= SLP_UAV_INIT_GRADE
			svars.fobSecUavIsNokillMode	= true
		end
	end


	local fnc_getGrade = function ( eq, dv, init )
		local numGrade
		if eq >= dv then
			numGrade = dv
		else
			if dv ~= 0 then
				if eq >= init then
					numGrade = eq
				else
					numGrade = 0
				end
			else
				numGrade = 0
			end
		end
		return numGrade
	end

	
	local IRSENSOR_INIT_GRADE = 3
	local eqGrade = TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipGrade{}
	local devGrade = TppMotherBaseManagement.GetMbsIrSensorLevel{}
	if devGrade ~= 0 then
		devGrade = devGrade + IRSENSOR_INIT_GRADE -1
	end
	svars.fobIrSensorGrade = fnc_getGrade(eqGrade, devGrade, IRSENSOR_INIT_GRADE)
	
	
	local SALARM_INIT_GRADE = 3
	local eqGrade = TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipGrade{}
	local devGrade = TppMotherBaseManagement.GetMbsStolenAlarmLevel{}
	if devGrade ~= 0 then
		devGrade = devGrade + SALARM_INIT_GRADE -1
	end
	svars.fobSecAlarmGrade = fnc_getGrade(eqGrade, devGrade, SALARM_INIT_GRADE)

	Fox.Log("dumpSvarsForDamage ==== START ===")
	Fox.Log("svars.fobSecCameraIsNokillMode = " .. tostring(svars.fobSecCameraIsNokillMode))
	Fox.Log("svars.fobSecCameraGrade = " .. svars.fobSecCameraGrade)
	Fox.Log("svars.fobSecUavIsNokillMode = " .. tostring(svars.fobSecUavIsNokillMode))
	Fox.Log("svars.fobSecUavGrade = " .. svars.fobSecUavGrade)
	Fox.Log("svars.fobIrSensorGrade = " .. svars.fobIrSensorGrade)
	Fox.Log("svars.fobSecAlarmGrade = " .. svars.fobSecAlarmGrade)
	Fox.Log("dumpSvarsForDamage ==== END ===")

end

 
 
this.PermitAbortResultOnPrepare = function ()
	Fox.Log("#### PermitAbortResultOnPrepare ###")
	mvars.mbContainer_placedCountTotal = 0
	mvars.mbIrSensor_placedCountTotal = 0
	mvars.mbMortar_placedCountTotal = 0
	mvars.mbEastTurret_placedCountTotal = 0
	mvars.mbWestTurret_placedCountTotal = 0
	mvars.mbEastAAG_placedCountTotal = 0
	mvars.mbWestAAG_placedCountTotal = 0
	mvars.mbNuclearContainer_placedCountTotal = 0
	mvars.mbStolenAlarm_placedCountTotal = 0
	mvars.isBootedVersusMode = false

	
	TppException.PermitFobExceptionHandling()
	
end


 
this.GetGimmickTotalCount = function ( name )
	local clstId = vars.mbClusterId
	local count = MotherBaseConstructConnector.GetInitialGimmickCount( clstId, name )
	if count == nil then
		Fox.Error("#### GetGimmickTotalCount :: nil count ### ")
		return
	else
		Fox.Log("#### GetGimmickTotalCount :: count = " .. count)
		return count
	end
end


 
this.SetAllGimmickPlacedCount = function ()
	Fox.Log("#### SetAllGimmickPlacedCount ###")
	mvars.mbContainer_placedCountTotal = this.GetGimmickTotalCount("Container")
	mvars.mbIrSensor_placedCountTotal = this.GetGimmickTotalCount("IrSensor")
	mvars.mbMortar_placedCountTotal = this.GetGimmickTotalCount("Mortar")
	mvars.mbEastTurret_placedCountTotal = this.GetGimmickTotalCount("EastTurret")
	mvars.mbWestTurret_placedCountTotal = this.GetGimmickTotalCount("WestTurret")
	mvars.mbEastAAG_placedCountTotal = this.GetGimmickTotalCount("EastAAG")
	mvars.mbWestAAG_placedCountTotal = this.GetGimmickTotalCount("WestAAG")
	mvars.mbNuclearContainer_placedCountTotal = this.GetGimmickTotalCount("NuclearContainer")
	mvars.mbStolenAlarm_placedCountTotal = this.GetGimmickTotalCount("StolenAlarm")

	Fox.Log("#### SetAllGimmickPlacedCount Dump start ==============> ###")
	Fox.Log("mvars.mbContainer_placedCountTotal = " .. mvars.mbContainer_placedCountTotal)
	Fox.Log("mvars.mbIrSensor_placedCountTotal = " .. mvars.mbIrSensor_placedCountTotal)
	Fox.Log("mvars.mbMortar_placedCountTotal = " .. mvars.mbMortar_placedCountTotal)
	Fox.Log("mvars.mbEastTurret_placedCountTotal = " .. mvars.mbEastTurret_placedCountTotal)
	Fox.Log("mvars.mbWestTurret_placedCountTotal = " .. mvars.mbWestTurret_placedCountTotal)
	Fox.Log("mvars.mbEastAAG_placedCountTotal = " .. mvars.mbEastAAG_placedCountTotal)
	Fox.Log("mvars.mbWestAAG_placedCountTotal = " .. mvars.mbWestAAG_placedCountTotal)
	Fox.Log("mvars.mbNuclearContainer_placedCountTotal = " .. mvars.mbNuclearContainer_placedCountTotal)
	Fox.Log("mvars.mbStolenAlarm_placedCountTotal = " .. mvars.mbStolenAlarm_placedCountTotal)
	Fox.Log("#### SetAllGimmickPlacedCount Dump ==============> End ###")


end




this.CalculateSecurityDamage = function ()
	Fox.Log("### CalculateSecurityDamage ###")
	local lostStaffs = svars.cnt_fltn_dds + svars.cnt_kill_dds
	local grade = TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipGrade{}
	local isKill = not(TppMotherBaseManagement.GetMbsClusterSecurityIsNoKillMode())

	local gmpDamage = TppMotherBaseManagement.GetAmountOfSecurityDamage{ 
		isWin = svars.fobIsHostWin,
		staff = lostStaffs,
		grade = grade,
		sensor = svars.cntDmgIrSensor,
		protect = svars.cntDmgSAlarm,
		camera= svars.cntDmgSecCamera,
		uav = svars.cntDmgUav,
		decoy = svars.cntDmgDecoy,
		mine = svars.cntDmgMine,
		isKill = isKill
	}
	if gmpDamage ~= nil then
		svars.fobAmountOfDamage = gmpDamage
	else
		svars.fobAmountOfDamage = 0
	end
end




this.CalculateEspionageTotal = function ( numClearType )
	Fox.Log("### CalculateEspionageTotal :: isHostGoal = " .. tostring(isHostGoal))
	local fnc_SetESPTotal = function (total, min, MAX)
		if total < min then
			Fox.Log("fnc_SetESPTotal:: min ")
			return min
		elseif	total > MAX then
			Fox.Log("fnc_SetESPTotal:: MAX ")
			return MAX
		else
			Fox.Log("fnc_SetESPTotal:: total ")
			return total
		end
	end

	
	svars.espt_of_total_result = svars.espt_of_goal + svars.espt_of_sneak_day

	
	
	if numClearType == CLEAR_TYPE_RESULT_ABORT then
		svars.espt_of_total_result = ESPT_OF_ABORT
	elseif numClearType ~= CLEAR_TYPE_RESULT_GOAL then
		svars.espt_of_total_result = 0
	end

	
	local sneakTotal = svars.espt_of_alert_count + svars.espt_of_plant_count - (svars.alertCount * ESPT_OF_ALERT_COUNT) + svars.espt_of_no_kill + svars.espt_of_no_reflex	
	svars.espt_of_total_sneak = fnc_SetESPTotal(sneakTotal, OF_TOTAL_SNEAK_MIN, svars.espt_of_total_sneak_max)
	if numClearType ~= CLEAR_TYPE_RESULT_GOAL then
		svars.espt_of_total_sneak = 0
	end

	
	local collectTotal = svars.espt_of_fluton_cntn + svars.espt_of_fluton_ptwp + svars.espt_of_pick_scgj + svars.espt_of_fluton_dds
	svars.espt_of_total_collect = fnc_SetESPTotal(collectTotal, OF_TOTAL_COLLECT_MIN, svars.espt_of_total_collect_max)

	
	local destroyTotal = svars.espt_of_destroy_ptwp + svars.espt_of_destroy_scgj + svars.espt_of_kill_dds - (svars.cnt_down_of * ESPT_OF_DOWNED)
	svars.espt_of_total_destroy = fnc_SetESPTotal(destroyTotal, OF_TOTAL_DESTROY_MIN, svars.espt_of_total_destroy_max)

	
	local versusTotal = svars.espt_of_kill_dfp + svars.espt_of_fluton_dfp + svars.espt_of_goal_on_versus
	svars.espt_of_total_versus = fnc_SetESPTotal(versusTotal, DF_TOTAL_VERSUS_MIN, svars.espt_of_total_versus_max)

	
	if numClearType == CLEAR_TYPE_RESULT_ABORT then
		svars.espt_of_total_result = ESPT_OF_ABORT
		svars.espt_of_total_sneak = 0
		svars.espt_of_total_collect = 0
		svars.espt_of_total_destroy = 0
		svars.espt_of_total_versus = 0
	end

	
	svars.espt_of_total = svars.espt_of_total_result + svars.espt_of_total_sneak + svars.espt_of_total_collect + svars.espt_of_total_destroy + svars.espt_of_total_versus

	
	
	svars.espt_df_total_sneak = 0
	svars.espt_df_total_battle = 0

	
	svars.espt_df_total_result = svars.espt_df_block_goal

	
	local collectTotalDF = svars.espt_df_save_cntn + svars.espt_df_save_ptwp + svars.espt_df_save_sec + svars.espt_df_save_dds
	svars.espt_df_total_defense = fnc_SetESPTotal(collectTotalDF, DF_TOTAL_COLLECT_MIN, svars.espt_df_total_defense_max)

	
	local versusTotalDF = svars.espt_df_kill_ofp + svars.espt_df_fulton_ofp - svars.espt_df_fultoned - svars.espt_df_dead + (svars.cnt_down_of * ESPT_DF_DOWN_OFP)
	svars.espt_df_total_versus = fnc_SetESPTotal(versusTotalDF, DF_TOTAL_VERSUS_MIN, svars.espt_df_total_versus_max)


	
	if numClearType == CLEAR_TYPE_RESULT_ABORT then
		svars.espt_df_total_result = 0
		svars.espt_df_total_defense = 0
		svars.espt_df_total_versus = 0
	end

	
	svars.espt_df_total = svars.espt_df_total_result + svars.espt_df_total_defense + svars.espt_df_total_versus

end

 
this.CalculateResult = function( numClearType )
	Fox.Log("### CalculateResult ### :: numClearType = " .. tostring(numClearType))
	

	
	local clusterConstruct = mtbs_cluster.GetClusterConstruct(vars.mbClusterId + 1)
	local numTotalSoldierCount = 0
	local numTotalSecurityGadjetCount = (mvars.mbMine_placedCountTotal + mvars.mbDecoy_placedCountTotal + mvars.mbSecCam_placedCountTotal + mvars.mbUav_placedCountTotal + 
										mvars.mbIrSensor_placedCountTotal + mvars.mbStolenAlarm_placedCountTotal)
	local numTotalContainerCount = mvars.mbContainer_placedCountTotal + mvars.mbNuclearContainer_placedCountTotal
	local numTotalPutWeaponCount = mvars.mbMortar_placedCountTotal + mvars.mbEastTurret_placedCountTotal + mvars.mbWestTurret_placedCountTotal + mvars.mbEastAAG_placedCountTotal + mvars.mbWestAAG_placedCountTotal


	Fox.Log("### CalculateResult :: numTotalSecurityGadjetCount = " .. numTotalSecurityGadjetCount)
	Fox.Log("### CalculateResult :: numTotalContainerCount = " .. numTotalContainerCount)
	Fox.Log("### CalculateResult :: numTotalPutWeaponCount = " .. numTotalPutWeaponCount)

	
	if mvars.mbSoldier_placedCountTotal > ESPT_SOLDIER_COUNT_MAX then
		numTotalSoldierCount = ESPT_SOLDIER_COUNT_MAX
	else
		numTotalSoldierCount = mvars.mbSoldier_placedCountTotal
	end

	Fox.Log("### CalculateResult :: numTotalSoldierCount = " .. numTotalSoldierCount)
	Fox.Log("### CalculateResult :: mbSecCam_placedCountTotal = " .. mvars.mbSecCam_placedCountTotal)
	Fox.Log("### CalculateResult :: mbUav_placedCountTotal = " .. mvars.mbUav_placedCountTotal)
	Fox.Log("### CalculateResult :: numTotalSecurityGadjetCount = " .. numTotalSecurityGadjetCount)


	
	
	
	if vars.fobSneakMode == FobMode.MODE_ACTUAL then
		
		
		local numTotalSecurityNPC = numTotalSoldierCount + mvars.mbUav_placedCountTotal + mvars.mbSecCam_placedCountTotal
		svars.espt_of_alert_count = numTotalSecurityNPC * ESPT_OF_NPC_COUNT
		svars.espt_of_plant_count = clusterConstruct * ESPT_OF_PLANT_COUNT
		
		
		if svars.alertCount == 0 then
			svars.espt_of_alert_count = svars.espt_of_alert_count * ESPT_OF_NO_ALERT
		end

		
		if svars.cnt_kill_dds == 0 then
			svars.espt_of_no_kill = numTotalSoldierCount * ESPT_OF_NO_KILL
		end

		
		if svars.reflexCount == 0 then
			svars.espt_of_no_reflex = numTotalSecurityNPC * ESPT_OF_NO_REFLEX
		end


		svars.espt_of_fluton_cntn = svars.cnt_fltn_cntn * ESPT_OF_FLUTON_CNTN
		svars.espt_of_fluton_ptwp = svars.cnt_fltn_ptwp * ESPT_OF_FLUTON_PTWP
		svars.espt_of_fluton_dds = svars.cnt_fltn_dds * ESPT_OF_FLUTON_DDS
		svars.espt_of_pick_scgj = 0

		svars.espt_of_destroy_ptwp = svars.cnt_dstr_ptwp * ESPT_OF_DESTROY_PTWP
		svars.espt_of_destroy_scgj = svars.cnt_dstr_scgj * ESPT_OF_DESTROY_SCGJ
		svars.espt_of_kill_dds = svars.cnt_kill_dds * ESPT_OF_KILL_DDS

		svars.espt_of_fluton_dfp = svars.cnt_fulton_dfp * ESPT_OF_FLUTON_DFP
		svars.espt_of_kill_dfp = svars.cnt_kill_dfp * ESPT_OF_KILL_DFP
		
		if numClearType == CLEAR_TYPE_RESULT_GOAL and mvars.isBootedVersusMode == true then
			svars.espt_of_goal_on_versus = mvars.espionagePointOffenseGoalOnVersus
		end

		
		svars.espt_df_mark_ofp_count = 0	
		svars.espt_df_plant_count = 0
		svars.espt_df_save_cntn = (numTotalContainerCount - svars.cnt_fltn_cntn) * ESPT_DF_SAVE_CNTN
		svars.espt_df_save_ptwp = (numTotalPutWeaponCount - svars.cnt_fltn_ptwp - svars.cnt_dstr_ptwp) * ESPT_DF_SAVE_PTWP
		svars.espt_df_save_sec = 0

		
		local save_dds = (numTotalSoldierCount - svars.cnt_fltn_dds - svars.cnt_kill_dds) * ESPT_DF_SAVE_DDS
		if save_dds < 0 then
			svars.espt_df_save_dds = 0
		else
			svars.espt_df_save_dds = save_dds
		end

		
		svars.espt_df_fultoned = svars.cnt_fulton_dfp * ESPT_DF_FULTONED
		svars.espt_df_dead = svars.cnt_kill_dfp * ESPT_DF_DEAD

		this.CalculateRansomeResult()
	end

	
	this.CalculateSecurityDamage()

	
	this.CalculateEspionageTotal( numClearType )























































end




this.CalculateRansomeResult = function()
	Fox.Log("#### CalculateRansomeResult ###")
	
	local gmp_ForRansomOF = 20000
	if gvars.sortieGmpCost > gmp_ForRansomOF then
		gmp_ForRansomOF = gvars.sortieGmpCost
	end
	svars.fobGmpSubtract_OF = (gmp_ForRansomOF * svars.numFultonedSnakeCount_OF * 1.5) + (gmp_ForRansomOF * svars.numDeadSnakeCount_OF)
	
	
	if svars.fobGmpAdding_OF > GMP_FOR_RANSOM_MAX then
		svars.fobGmpAdding_OF = GMP_FOR_RANSOM_MAX
	end
		
	
	svars.fobGmpAdding_DF = svars.fobGmpSubtract_OF
	svars.fobGmpSubtract_DF = svars.fobGmpAdding_OF
end

 
 
this.AddGmpByRansome = function ()
	Fox.Log("#### AddGmpByRansome ###")
	
	
	
	TppTerminal.UpdateGMP{ gmp = vars.totalBatteryPowerAsGmp }
	
	this.SwitchExecByIsHost(
		function ()
			
			if svars.fobGmpAdding_OF > GMP_FOR_RANSOM_MAX then		
				Fox.Log("Disable Adding GMP :: limit over")
			elseif svars.fobGmpAdding_OF > 0 then
				Fox.Log("#### svars.fobGmpAdding_OF = " .. svars.fobGmpAdding_OF)
				TppMotherBaseManagement.AddGmp{ gmp=svars.fobGmpAdding_OF }
			end
			
			if svars.fobGmpSubtract_OF > 0 then
				Fox.Log("#### svars.fobGmpSubtract_OF = " .. svars.fobGmpSubtract_OF)
				TppMotherBaseManagement.SubGmp{ gmp=svars.fobGmpSubtract_OF }
			end
		end,
		function ()
			
			if svars.fobGmpAdding_DF > 0 then
				Fox.Log("#### svars.fobGmpAdding_OF = " .. svars.fobGmpAdding_DF)
				TppMotherBaseManagement.AddGmp{ gmp=svars.fobGmpAdding_DF }
			end
			
			if svars.fobGmpSubtract_DF > GMP_FOR_RANSOM_MAX then
				Fox.Log("Disable Sub GMP :: limit over")
			elseif svars.fobGmpSubtract_DF > 0 then
				Fox.Log("#### svars.fobGmpAdding_OF = " .. svars.fobGmpSubtract_DF)
				TppMotherBaseManagement.SubGmp{ gmp=svars.fobGmpSubtract_DF }
			end
		end
	)
end

 
this.ClearResultSvars = function ()
	Fox.Log("#### ClearResultSvars ###")

	
	svars.espt_of_alert_count = 0
	svars.espt_of_plant_count = 0
	svars.espt_of_fluton_dfp = 0
	svars.espt_of_fluton_cntn = 0
	svars.espt_of_fluton_ptwp = 0
	svars.espt_of_pick_scgj = 0
	svars.espt_of_fluton_dds = 0
	svars.espt_of_kill_dfp = 0
	svars.espt_of_destroy_ptwp = 0
	svars.espt_of_destroy_scgj = 0
	svars.espt_of_kill_dds = 0
	svars.espt_df_block_goal = 0
	svars.espt_df_kill_ofp = 0
	svars.espt_df_mark_ofp_count = 0
	svars.espt_df_plant_count = 0
	svars.espt_df_save_cntn = 0
	svars.espt_df_save_ptwp = 0
	svars.espt_df_save_sec = 0
	svars.espt_df_save_dds = 0
	svars.espt_df_fultoned = 0
	svars.espt_df_dead = 0

	
	svars.espt_of_total_result = 0
	svars.espt_of_total_sneak = 0
	svars.espt_of_total_collect = 0
	svars.espt_of_total_destroy = 0
	svars.espt_of_total_versus = 0
	svars.espt_of_total = 0

	svars.espt_df_total_result = 0
	svars.espt_df_total_sneak = 0
	svars.espt_df_total_defense = 0
	svars.espt_df_total_battle = 0
	svars.espt_of_total_versus = 0
	svars.espt_df_total = 0

	
	svars.fobAmountOfDamage = 0

	
	svars.fobGmpAdding_OF = 0
	svars.fobGmpSubtract_OF = 0
	svars.fobGmpAdding_DF = 0
	svars.fobGmpSubtract_DF = 0

end




 




this.SetAnnounceEspPoint = function ( AnnounceParam )
	Fox.Log("### SetAnnounceEspPoint :: upPoint = " .. tostring(AnnounceParam.upPoint) .. "downPoint = " .. tostring(AnnounceParam.downPoint) .. "   downLangId = " .. tostring(AnnounceParam.downLangId) .. "   upLangId = " .. tostring(AnnounceParam.upLangId))
	if AnnounceParam.sbj == nil then
		Fox.Log("### SetAnnounceEspPoint ### :: no subject ")
		if AnnounceParam.downPoint ~= nil then
			Fox.Log("### SetAnnounceEspPoint ### :: point lower 0  ")
			if AnnounceParam.downLangId ~= nil then
				Fox.Log("### SetAnnounceEspPoint ### :: call announce  ")
				TppUI.ShowAnnounceLog( AnnounceParam.downLangId, AnnounceParam.downPoint )
			end
		elseif AnnounceParam.upPoint ~= nil then
			Fox.Log("### SetAnnounceEspPoint ### :: point upper 0  ")
			if AnnounceParam.upLangId ~= nil then
				Fox.Log("### SetAnnounceEspPoint ### :: call announce  ")
				TppUI.ShowAnnounceLog( AnnounceParam.upLangId, AnnounceParam.upPoint )
			end
		end
	else
		Fox.Log("### SetAnnounceEspPoint ### :: has subject ")
		if AnnounceParam.downPoint ~= nil then
			Fox.Log("### SetAnnounceEspPoint ### :: point lower 0  ")
			if AnnounceParam.downLangId ~= nil then
				Fox.Log("### SetAnnounceEspPoint ### :: call announce  ")
				TppUI.ShowAnnounceLog( AnnounceParam.downLangId, AnnounceParam.sbj, AnnounceParam.downPoint )
			end
		elseif AnnounceParam.upPoint ~= nil then
			Fox.Log("### SetAnnounceEspPoint ### :: point upper 0  ")
			if AnnounceParam.upLangId ~= nil then
				Fox.Log("### SetAnnounceEspPoint ### :: call announce  ")
				TppUI.ShowAnnounceLog( AnnounceParam.upLangId, AnnounceParam.sbj, AnnounceParam.upPoint )
			end
		end
	end
end


  
  
function this.SetAndAnnounceEspPoint_Goal()
	if vars.fobSneakMode == FobMode.MODE_ACTUAL then
		svars.espt_of_goal = svars.espt_of_goal + mvars.espionagePointOffenseGoal
		
		this.SetAnnounceEspPoint( {point = mvars.espionagePointOffenseGoal} )
	end
end

function this.SetAndAnnounceEspPoint_FultonCntn()
	if vars.fobSneakMode == FobMode.MODE_ACTUAL then
		
		svars.cnt_fltn_cntn = svars.cnt_fltn_cntn + 1
		this.SwitchExecByIsHost(
			function ()
				this.SetAnnounceEspPoint( {upPoint = ESPT_OF_FLUTON_CNTN, sbj = "cmmn_name_container", upLangId = "espFultonContainer_a" } )
			end,
			function ()
				this.SetAnnounceEspPoint( {downPoint = ESPT_DF_SAVE_CNTN, sbj = "cmmn_name_container", downLangId = "espFultonContainer_d"} )
			end
		)
	end
end

function this.SetAndAnnounceEspPoint_FultonPtwp( strFultoned )
	if vars.fobSneakMode == FobMode.MODE_ACTUAL then
		
		svars.cnt_fltn_ptwp = svars.cnt_fltn_ptwp + 1
		
		this.SwitchExecByIsHost(
			function ()
				this.SetAnnounceEspPoint( {upPoint = ESPT_OF_FLUTON_PTWP, sbj = strFultoned, upLangId = "espFultonContainer_a" } )
			end,
			function ()
				this.SetAnnounceEspPoint( {downPoint = ESPT_DF_SAVE_PTWP, sbj = strFultoned, downLangId = "espFultonContainer_d"} )
			end
		)
	end
end

function this.SetAndAnnounceEspPoint_PickUpScgj( strFultoned )
	if vars.fobSneakMode == FobMode.MODE_ACTUAL then
	
	
	
	end
end

function this.SetAndAnnounceEspPoint_FultonDds()
	if vars.fobSneakMode == FobMode.MODE_ACTUAL then
	
		svars.cnt_fltn_dds = svars.cnt_fltn_dds + 1
		this.SwitchExecByIsHost(
			function ()
				this.SetAnnounceEspPoint( {upPoint = ESPT_OF_FLUTON_DDS, sbj = "cmmn_name_sec_staff", upLangId = "espFultonContainer_a" } )
			end,
			function ()
				this.SetAnnounceEspPoint( {downPoint = ESPT_DF_SAVE_DDS, sbj = "cmmn_name_sec_staff", downLangId = "espFultonContainer_d"} )
			end
		)
	end
end

function this.SetAndAnnounceEspPoint_DestroyPtwp( strDestoryed )
	if vars.fobSneakMode == FobMode.MODE_ACTUAL then
	
		svars.cnt_dstr_ptwp = svars.cnt_dstr_ptwp + 1
		this.SwitchExecByIsHost(
			function ()
				this.SetAnnounceEspPoint( {upPoint = ESPT_OF_DESTROY_PTWP, sbj = strDestoryed, upLangId = "espDestroy_a" } )
			end,
			function ()
				this.SetAnnounceEspPoint( {downPoint = ESPT_DF_SAVE_PTWP, sbj = strDestoryed, downLangId = "espDestroy_d"} )
			end
		)
	end
end

function this.SetAndAnnounceEspPoint_DestroyScgj( strDestoryed )
	svars.cnt_dstr_scgj = svars.cnt_dstr_scgj + 1
	if vars.fobSneakMode == FobMode.MODE_ACTUAL then
	
		this.SwitchExecByIsHost(
			function ()
				this.SetAnnounceEspPoint( {upPoint = ESPT_OF_DESTROY_SCGJ, sbj = strDestoryed, upLangId = "espDestroy_a" } )
			end,
			function () end
		)
	end
end

function this.SetAndAnnounceEspPoint_DestroyPlaced( strDestoryed )
	if vars.fobSneakMode == FobMode.MODE_ACTUAL then
		this.SwitchExecByIsHost(
			function ()
				this.SetAnnounceEspPoint( {upPoint = ESPT_OF_DESTROY_SCGJ, sbj = strDestoryed, upLangId = "espDestroy_a" } )
			end,
			function () end
		)
	end
end



function this.SetAndAnnounceEspPoint_KillDds()
	if vars.fobSneakMode == FobMode.MODE_ACTUAL then
	
		svars.cnt_kill_dds = svars.cnt_kill_dds + 1
		this.SwitchExecByIsHost(
			function ()
				this.SetAnnounceEspPoint( {upPoint = ESPT_OF_KILL_DDS, sbj = "cmmn_name_sec_staff", upLangId = "espKillStaff_a" } )
			end,
			function ()
				this.SetAnnounceEspPoint( {downPoint = ESPT_DF_SAVE_DDS, sbj = "cmmn_name_sec_staff", downLangId = "espKillStaff_d"} )
			end
		)
	end
end

function this.SetAndAnnounceEspPoint_FultonDF()
	if vars.fobSneakMode == FobMode.MODE_ACTUAL then
		svars.cnt_fulton_dfp = svars.cnt_fulton_dfp + 1
	
		this.SwitchExecByIsHost(
			function ()
				this.SetAnnounceEspPoint( {upPoint = ESPT_OF_FLUTON_DFP, sbj = "result_fob_guardian", upLangId = "espFulton_a" } )
			end,
			function ()
	
			end
		)
	end
end


function this.SetAndAnnounceEspPoint_EliminateDF()
	if vars.fobSneakMode == FobMode.MODE_ACTUAL then
		svars.cnt_kill_dfp = svars.cnt_kill_dfp + 1
	
		this.SwitchExecByIsHost(
			function ()
				this.SetAnnounceEspPoint( {upPoint = ESPT_OF_KILL_DFP, sbj = "result_fob_guardian", upLangId = "espKill_a" } )
			end,
			function ()
	
			end
		)
	end
end



  
function this.SetAndAnnounceEspPoint_MarkOf()
	if vars.fobSneakMode == FobMode.MODE_ACTUAL then
	
		svars.cnt_mark_of = svars.cnt_mark_of + 1
		this.SwitchExecByIsHost(
			function () end,
			function ()
				this.SetAnnounceEspPoint( {upPoint = ESPT_DF_MARK_OFP_COUNT, upLangId = "espMarking_d" } )
			end
		)
	end
end

function this.SetAndAnnounceEspPoint_AttackedAndAlert()
	if vars.fobSneakMode == FobMode.MODE_ACTUAL then
	
		svars.cnt_mark_of = svars.cnt_mark_of + 1
		this.SwitchExecByIsHost(
			function () end,
			function ()
				this.SetAnnounceEspPoint( {upPoint = ESPT_DF_MARK_OFP_COUNT, upLangId = "espMarking_d" } )
			end
		)
	end
end

function this.SetAndAnnounceEspPoint_EliminateOF()
	if vars.fobSneakMode == FobMode.MODE_ACTUAL then
	
		this.SetAnnounceEspPoint( {upPoint = ESPT_DF_KILL_OFP, upLangId = "espKillTarget_d" } )
	end
end

function this.SetAndAnnounceEspPoint_FultonOF()
	if vars.fobSneakMode == FobMode.MODE_ACTUAL then
		this.SetAnnounceEspPoint( {upPoint = ESPT_DF_FULTON_OFP, upLangId = "espFultonTarget_d" } )
	end
end


function this.OnPlayerStaminaOut(playerId , value )
	if vars.fobSneakMode == FobMode.MODE_ACTUAL then
		
		local lang_of = "esp_sleep"
		local lang_df = "esp_sleep_a"
		
		
		if value == 0 then
			lang_of = "esp_stun"
			lang_df = "esp_stun_a"
		end

		if playerId == OF_PLAYER_ID then
			this.SwitchExecByIsHost(
				function()	
					
					if svars.cnt_down_of < ESPT_DOWN_COUNT_LIMIT then
						svars.cnt_down_of = svars.cnt_down_of + 1
					end
					Fox.Log("_____Host OnPlayerStaminaOut.")
					
					this.SetAnnounceEspPoint( {downPoint = ESPT_OF_DOWNED, downLangId = lang_of} )
				end,
				function()	
					Fox.Log("_____Client OnPlayerStaminaOut.")
					
					this.SetAnnounceEspPoint( {upPoint = ESPT_DF_DOWN_OFP, upLangId = lang_df } )
				end
			)
		end
	end
	
	
	if TppServerManager.FobIsSneak()
	and ( playerId == OF_PLAYER_ID ) then
		TppHero.SetAndAnnounceHeroicOgrePoint{ heroicPoint = -50, ogrePoint = 0 }
	end
end




this.OnPlayerDamagedOffence = function ( isAlertDamage )
	Fox.Log("### OnPlayerDamagedOffence :: AttackId = " .. tostring(AttackId))

	local fnc_vsCommon = function (isAlertDamage)
		if isAlertDamage == true then
			
			
			local cp = GameObject.GetGameObjectId( mtbs_enemy.cpNameDefine )
			if TppEnemy.GetPhase( mtbs_enemy.cpNameDefine ) ~= TppEnemy.PHASE.ALERT then
				local command = { id = "SetPhase", phase=TppGameObject.PHASE_ALERT }
				GameObject.SendCommand( cp, command )
			end
		else
			Fox.Log("### OnPlayerDamagedOffence :: Non Alert Damage ")
		end
	end

	this.SwitchExecByIsGameMode(
		fnc_vsCommon,
		fnc_vsCommon,
		function () end,
		isAlertDamage
	)
end

this.OnPlayerDamagedDefence = function ()
	Fox.Log("### OnPlayerDamagedDefence")

	this.SwitchExecByIsGameMode(
		function () end,
		function () end,
		function ()
			this.GameOverByCrime()
		end
	)
end





function this.SwitchHighPrioInterrogation( switch )
	Fox.Log("### SwitchHighPrioInterrogation ::" .. tostring(switch))
	local cp = GameObject.GetGameObjectId(mtbs_enemy.cpNameDefine)
	if switch == true then
		TppInterrogation.AddHighInterrogation( cp,{ o50050_enemy.INTER_SEARCHING_DEFENCE,} )
	elseif switch == false then
		TppInterrogation.RemoveHighInterrogation(  cp,{ o50050_enemy.INTER_SEARCHING_DEFENCE,} )
	else
		Fox.Error("### SwitchHighPrioInterrogation :: param is nil")
	end
end




function this.IsThereRecoverableStaff()
	local count = TppMotherBaseManagement.GetRecoverStaffCount()
	Fox.Log("### IsThereRecoverableStaff ::" .. tostring(count))
	if count > 0 then
		return true
	else
		return false
	end
end


function this.IsFobSneakForSupport()
	local isForSupport = TppMotherBaseManagement.IsWormholeOther{}
	Fox.Log("### IsFobSneakForSupport ::" .. tostring(isForSupport))
	return isForSupport
end





this.TimerStartTimeLimit = function (timerName)

	Fox.Log("___________o50050_sequence.TimerStartTimeLimit() / timerName : "..tostring(timerName))
	Fox.Log("___________ TimeSec : "..tostring(this.TIME_LIMIT_LIST[timerName].TimeSec ) .." HostTimeCountLang : ".. tostring(this.TIME_LIMIT_LIST[timerName].HostTimeCountLang ).." ClientTimeCountLang: "..tostring(this.TIME_LIMIT_LIST[timerName].ClientTimeCountLang ))

	Fox.Log("________svars.timeLimitforSneaking : "..tostring(svars.timeLimitforSneaking))

	TppUiStatusManager.SetStatus("DisplayTimer", "NO_TIMECOUNT_SUB")

	if timerName == "timeLimitforVisiting" then
		TppUI.StartDisplayTimer{
			svarsName = timerName,
			cautionTimeSec = this.TIME_LIMIT_LIST[timerName].TimeSec,
		}
		TppUiCommand.SetDisplayTimerText( this.TIME_LIMIT_LIST[timerName].HostTimeCountLang )	
	else
		TppUI.StartDisplayTimer{
			svarsName = timerName,
			cautionTimeSec = this.TIME_LIMIT_LIST[timerName].TimeSec,
		}
		if TppServerManager.FobIsSneak() then
			TppUiCommand.SetDisplayTimerText( this.TIME_LIMIT_LIST[timerName].HostTimeCountLang )	
		else
			TppUiCommand.SetDisplayTimerText( this.TIME_LIMIT_LIST[timerName].ClientTimeCountLang )	
		end
	end
	Fox.Log("___________o50050_sequence.TimerStartTimeLimit()____________END")
end


this.StartTelopMissionObjective = function(isHost)

	if TppSequence.GetContinueCount() > 0 then
		return
	end
	

	local OBJECTIVE_DISPLAY_TIME_SEC = 6.0

	local objectiveLang = ""
	local nameLang 		= ""

	if isHost then
		objectiveLang = "obj_mission_50_50050_00"
		nameLang = "name_mission_50_50050_00"
	else
		objectiveLang = "obj_mission_50_50050_10"
		nameLang = "name_mission_50_50050_10"
	end

	TppUiCommand.RegistTelopCast( "CenterLarge", OBJECTIVE_DISPLAY_TIME_SEC, objectiveLang, nameLang )
	TppUiCommand.RegistTelopCast( "PageBreak", 1.0 )

	TppUiCommand.StartTelopCast()
end



this.SetCameraEscapeFromWH = function ( gameObjectId, timerName, announceLog )
	Fox.Log("### SetCameraEscapeFromWH ###")
	if mvars.ply_gameOverCameraGameObjectId ~= nil then
		Fox.Error("TppPlayer.StartGameOverCamera : already played another camera")
		return
	end

	mvars.ply_gameOverCameraGameObjectId = gameObjectId
	mvars.ply_gameOverCameraStartTimerName = timerName
	mvars.ply_gameOverCameraAnnounceLog = announceLog

	Fox.Log("TppPlayer.StartGameOverCamera : gameObjectId = " .. tostring(gameObjectId) .. ", timerName = " .. tostring(timerName) )

	TppUiStatusManager.SetStatus( "AnnounceLog", "INVALID_LOG" )

	




	vars.playerDisableActionFlag = PlayerDisableAction.SUBJECTIVE_CAMERA

	GkEventTimerManager.Start( "Timer_StartEscapeCamera", 0.25 )
end



 
this.OnDeadGameObject = function (gameObjectId, AttackerId)
	Fox.Log("### Dead gameObjectId = ".. tostring(gameObjectId) .. "AttackerId = " .. tostring(AttackerId))
	if AttackerId == OF_PLAYER_ID then
		Fox.Log("### Offence Killed someone ###")
		
		if Tpp.IsSoldier( gameObjectId ) then
			
			local vsModefunc = function () 
				this.AddRevengePoint(this.REVENGE_POINT.KILL_STAFF)
				this.SetAndAnnounceEspPoint_KillDds()
			end
			this.SwitchExecByIsGameMode(
				function ()
					vsModefunc()
				end,
				function ()
					vsModefunc()
				end,
				function ()
					svars.cnt_kill_dds = svars.cnt_kill_dds + 1			
					if TppMotherBaseManagement.IsMbsOwner{} ~= true then
						TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.KILLED_DDS )
					end
				end
			)
		end
		
		if Tpp.IsSecurityCamera( gameObjectId ) then
			svars.cntDmgSecCamera = svars.cntDmgSecCamera + 1
			this.AddRevengePoint(this.REVENGE_POINT.DESTROY_SEC_GADJET)
			this.SetAndAnnounceEspPoint_DestroyScgj( "mb_fob_sec_camera" )
		end
		
		if Tpp.IsUAV( gameObjectId ) then
			svars.cntDmgUav = svars.cntDmgUav + 1
			this.AddRevengePoint(this.REVENGE_POINT.DESTROY_SEC_GADJET)
			this.SetAndAnnounceEspPoint_DestroyScgj( "mb_fob_sec_uav" )
		end

	end

	
	if Tpp.IsSoldier( gameObjectId ) then
		this.SwitchExecByIsHost(
			function ()
				local commandStaffId = { id = "GetStaffId" }
				local staffId = GameObject.SendCommand( gameObjectId, commandStaffId )
				TppMotherBaseManagement.KillTempStaffFob{ staffId = staffId, gameObjectId = gameObjectId }
			end,
			function ()
				Fox.Log("### Dead DD Soldier ###")
			end
		)
	end

	
	
	this.SwitchExecByIsGameMode(
		function () end,
		function () end,
		function ()
			this.GameOverByCrime()
		end
	)

end

 
this.OnBreakPlaced = function (playerId, equipId, index, isPlayerPlaced)
	Fox.Log("#### OnBreakPlaced : #### playerId = ".. tostring(playerId) .. "equipId = " ..equipId .. "index = ".. index .. "isPlayerPlaced = " .. tostring(isPlayerPlaced))
	if playerId == OF_PLAYER_ID and isPlayerPlaced == 0 then	
		if TppPlayer.IsDecoy( equipId ) == true then
			Fox.Log("#### OnBreakPlaced : #### :: IsDecoy")
			this.AddRevengePoint(this.REVENGE_POINT.DESTROY_SEC_GADJET)
			this.SetAndAnnounceEspPoint_DestroyPlaced( "mb_fob_sec_decoy" )
			svars.cntDmgDecoy = svars.cntDmgDecoy + 1
		elseif TppPlayer.IsMine( equipId ) == true then
			Fox.Log("#### OnBreakPlaced : #### :: IsMine")
			this.AddRevengePoint(this.REVENGE_POINT.DESTROY_SEC_GADJET)
			this.SetAndAnnounceEspPoint_DestroyPlaced( "mb_fob_sec_mine" )
			svars.cntDmgMine = svars.cntDmgMine + 1
		end


		
		this.SwitchExecByIsGameMode(
			function () end,
			function () end,
			function ()
				this.GameOverByCrime()
			end
		)
	end
end


 
this.OnPickupPlaced = function (playerId, equipId, instanceIndex)
	Fox.Log("#### OnPickupPlaced : #### playerId = ".. tostring(playerId) .. "equipId = " ..equipId .. "instanceIndex = ".. instanceIndex)
	if playerId == OF_PLAYER_ID and TppPlaced.IsLocator( instanceIndex ) == true then
		if TppPlayer.IsDecoy( equipId ) == true then
			Fox.Log("#### OnPickupPlaced : #### :: IsDecoy")
			this.AddRevengePoint(this.REVENGE_POINT.DESTROY_SEC_GADJET)
			svars.cntDmgDecoy = svars.cntDmgDecoy + 1
		elseif TppPlayer.IsMine( equipId ) == true then
			Fox.Log("#### OnPickupPlaced : #### :: IsMine")
			this.AddRevengePoint(this.REVENGE_POINT.DESTROY_SEC_GADJET)
			svars.cntDmgMine = svars.cntDmgMine + 1
		end

		
		this.SwitchExecByIsGameMode(
			function () end,
			function () end,
			function ()
				this.GameOverByCrime()
			end
		)
	end
end

 
this.OnBreakGimmick = function ( gameObjectId, locatorNameHash, dataSetNameHash, AttackerId )
	Fox.Log("### BreakGimmick gameObjectId = ".. tostring(gameObjectId) .. "AttackerId = " .. tostring(AttackerId))
	if AttackerId == OF_PLAYER_ID then
		
		if this.IsIrSensor(gameObjectId) then
			svars.cntDmgIrSensor = svars.cntDmgIrSensor + 1
			
			this.AddRevengePoint(this.REVENGE_POINT.DESTROY_SEC_GADJET)
			this.SetAndAnnounceEspPoint_DestroyScgj( "mb_fob_sec_infrared" )
		end
		
		if this.IsAirGun(gameObjectId) then
			this.AddRevengePoint(this.REVENGE_POINT.DESTROY_PUT_WEAPON)
			this.SetAndAnnounceEspPoint_DestroyPtwp( "cmmn_name_antiair" )
			this.SwitchExecByIsGameMode(
				function ()
				end,
				function ()
				end,
				function ()
					if TppMotherBaseManagement.IsMbsOwner{} ~= true then
						TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.BREAK_PTW_ANTIAIR )
					end
				end
			)
		end
		
		if this.IsMachineGun(gameObjectId) then
			this.AddRevengePoint(this.REVENGE_POINT.DESTROY_PUT_WEAPON)
			this.SetAndAnnounceEspPoint_DestroyPtwp( "cmmn_name_gunsheet" )
			this.SwitchExecByIsGameMode(
				function ()
				end,
				function ()
				end,
				function ()
					if TppMotherBaseManagement.IsMbsOwner{} ~= true then
						TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.BREAK_PTW_MACHINEGUN )
					end
				end
			)
		end
		
		if this.IsMortar(gameObjectId) then
			this.AddRevengePoint(this.REVENGE_POINT.DESTROY_PUT_WEAPON)
			this.SetAndAnnounceEspPoint_DestroyPtwp( "cmmn_name_mortar" )
			this.SwitchExecByIsGameMode(
				function ()
				end,
				function ()
				end,
				function ()
					if TppMotherBaseManagement.IsMbsOwner{} ~= true then
						TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.BREAK_PTW_MORTAR )
					end
				end
			)

		end

		
		this.SwitchExecByIsGameMode(
			function () end,
			function () end,
			function ()
				this.GameOverByCrime()
			end
		)

	end

	this.AddTempClash( gameObjectId, locatorNameHash, dataSetNameHash, AttackerId )

end

 
this.OnBreakGimmickBurglarAlarm = function ( AttackerId )
	Fox.Log("### BreakGimmickBurglarAlarm AttackerId = " .. tostring(AttackerId))
	if AttackerId == OF_PLAYER_ID then
		svars.cntDmgSAlarm = svars.cntDmgSAlarm + 1
		this.AddRevengePoint(this.REVENGE_POINT.DESTROY_SEC_GADJET)
		this.SetAndAnnounceEspPoint_DestroyScgj( "mb_fob_sec_warning_d" )
	end
end




this.RetrySelectCancel = function ()
	Fox.Log( " ### RetrySelectCancel ### " )
	
	if TppMission.IsGameOver() == true then
		TppSequence.SetNextSequence( "Seq_WaitSyncSVarsOnGameOver", { isExecGameOver = true } )
	else
		TppSequence.SetNextSequence( "Seq_WaitSyncSVarsOnMissionClear", { isExecMissionClear = true } )
	end
end



this.WriteEventDefencePlayerStart = function ()
	
	local key = "player_locator_clst"..(this.currentClusterSetting.numClstId-1).."_plnt0_df0"	
	Fox.Log("### MtbsDefenceStartPointIdentifier:key ###" .. key)
	local pPos, pRotY = Tpp.GetLocator( "MtbsStartPointIdentifier", key ) 
	
	if pPos == nil then
		Fox.Error("### WriteEventDefencePlayerStart:: Cannot Get DF StartPos From Identifier ###")
		return
	end

	
	TppEventLog.WriteEvent{
		event = EventLog.EVENT_PLAYER_START,
		playerIndex = 1,
		playerPos = Vector3( pPos[1], pPos[2], pPos[3] ),
		playerDir = pRotY
	}
end

this.CallRadioClientResult = function ()
	Fox.Log("### CallRadioClientResult ###")
	local isCallRadioTaken_Wormhole = false
	local isCallRadioTaken_NonWormhole = false
	local isCallRadioDead = false
	
	if TppMotherBaseManagement.IsMbsOwner{} == true then
		if svars.fobCaptureSoldierOwnerCount > 0 then
			if svars.fobIsOpenWormhole == true then
				isCallRadioTaken_Wormhole = true
			else
				isCallRadioTaken_NonWormhole = true
			end
		end
	end

	if svars.fobStaffDeadOwnerCount > 0 or svars.fobStaffDeadSupporterCount > 0 then
		isCallRadioDead = true
	end
	
	
	if isCallRadioTaken_Wormhole == true then
		o50050_radio.ClientWin_SomeoneRemove()
	elseif isCallRadioTaken_NonWormhole == true then
		o50050_radio.ClientResultGottenStaff()
	elseif isCallRadioDead == true then
		o50050_radio.ClientWin_SomeoneDead()
	end
end






sequences.Seq_Demo_SyncGameStart = {
	OnEnter = function( self )

		Fox.Log("Seq_Demo_SyncGameStart.OnEnter")

		mvars.finishSyncGameStart = false

		TppMission.EnableInGameFlag()	

		
		this.SetServerParameter()

		if TppServerManager.FobIsSneak() then
			if TppNetworkUtil.GetSessionMemberCount() == 1 then
				self.GameStartFadeIn()
			else
				svars.fob_isHostGameStart = true
			end
		else
			Fox.Log("Client wait host game start.")
			Gimmick.JoinNewClientSyncRequest()
		end
	end,
	OnLeave = function()
		Fox.Log("Seq_Demo_SyncGameStart.OnLeave")

	end,
	OnUpdate = function( self )

		
		TppUI.ShowAccessIconContinue()

		if not mvars.DEBUG_isNoRestart then
			local isSessionConnect = TppNetworkUtil.IsSessionConnect()
			local isSyncGameStart = SVarsIsSynchronized("fob_isHostGameStart")
			if TppServerManager.FobIsSneak() then
				if svars.fob_isHostGameStart and isSyncGameStart then
					self.GameStartFadeIn()
				else
					if DebugText then
						if TppNetworkUtil.GetSessionMemberCount() ~= 1 then
							DebugText.Print(DebugText.NewContext(), {0.5, 0.5, 1.0}, "[Seq_Demo_SyncGameStart] Host : wait sync game start.")
						end
					end
				end
			else
				if not isSessionConnect then
					Fox.Warning("Client : Already session closed.")	
				elseif ( svars.fob_isHostGameStart and Gimmick.IsJoinNewClientSynced() ) then
					self.GameStartFadeIn()
				else
					if DebugText then
						DebugText.Print(DebugText.NewContext(), {0.5, 0.5, 1.0}, "[Seq_Demo_SyncGameStart] Client : wait host game start.")
					end
				end
			end
		end
	end,
	GameStartFadeIn = function()
		if not mvars.finishSyncGameStart then
			mvars.finishSyncGameStart = true
			TppDemo.EnableInGameFlagIfResereved()
			TppSequence.SetNextSequence("Seq_Game_FOB")
			Gimmick.EnableNoEffectBreak(false)
			TppUI.FadeIn( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeInFobGameStart" )
			if Player.StartFOBInvincible ~= nil then
				Player.StartFOBInvincible(0)
				Player.StartFOBInvincible(1)
			end
		end
	end,
}





sequences.Seq_Game_StartFromHeli = {
	
	Messages = function ( self )
		return
		StrCode32Table {
			Player = {
				{
					msg = "IntoWormhole",
					func = function ()
						this.EndStartSneaknigFromHeli()
					end
				},
				{
					msg = "OutFromWormhole",
					func = function ()
						this.AfterStartSneaknigFromHeli()
					end
				},
				{
					msg = "PlayerHeliWarpToFobStart",
					func = function ()
						this.EnterStartSneaknigFromHeli()
					end
				},
			},
 
			Placed = {
				{	
					msg = "OnBreakPlaced",
					func = this.OnBreakPlaced,
				},
			},
			GameObject = {
				{	
					msg = "RoutePoint2", sender = "SupportHeli",
					func = function (sender,routeId,param,messageId)
						if messageId == StrCode32("UpdateStartPoint") then			
							this.UpdateStartPosition( param )
							this.EnterStartSneaknigFromHeli()
						end
						if messageId == StrCode32("SetStartPoint") then			
							Fox.Log( " ### SetStartPoint ### " )
							this.UpdateStartPosition( param )
						end
					end
				},
				{	
					msg = "Dead",
					func = this.OnDeadGameObject,
				},
				{	
					msg = "BreakGimmick",
					func = this.OnBreakGimmick,
				},
				{
					
					msg = "BreakGimmickBurglarAlarm",
					func = this.OnBreakGimmickBurglarAlarm,
				},
			},
			Radio = {
				{
					msg = "Finish",
					sender = o50050_radio.MissionStartRadioList,
					func = function (radioGroupName)
						Fox.Log("#### f5000_rtrg0020 is finish ####" .. tostring(radioGroupName))
						this.StartTelopMissionObjective(true)
						this.TimerStartTimeLimit("timeLimitforSneaking")
					end
				},
			},
			Timer = {
				{	
					msg = "Finish",
					sender = "TimerStartDelay",
					func = function ()
						Fox.Log("#### TimerStartDelay ####")
						local fnc_vsCommon = function ()
							
							local radioGroups = o50050_radio.GetHostMissionStart( svars.fobIsThereRecoverStaff )
							Fox.Log("#### radioGroups ####")
							
							TppMission.UpdateObjective{
								radio = {
									radioGroups = radioGroups,
								},
								objectives = {
									"clst_goalOfCurrentCluster_test",
								}
							}
						end
						this.SwitchExecByIsGameMode(
							function () fnc_vsCommon() end,
							function () fnc_vsCommon() end,
							function ()
								
								this.TimerStartTimeLimit("timeLimitforVisiting")
							end
						)

					end
				},
				{	
					msg = "Finish",
					sender = "TimerDelayDispPlace",
					func = function ()
						Fox.Log("#### TimerDelayDispPlace ####")

						
						local oceanId = TppMotherBaseManagement.GetMbsOceanAreaId{}
						Fox.Log("________ oceanId id "..tostring(oceanId))
						for value,oceanIds in pairs(this.OCEAN_LIST) do
							for i, key in pairs(oceanIds) do
								if key == oceanId then
									TppUiCommand.CallMissionTelopTyping(tostring(value))
									return
								end
							end
						end

					end
				},
			},
		}
	end,
	OnEnter = function (self)
		
		svars.numRevengePoint = 0
		mvars.isDoneWarpToHeli = false
		mvars.isBootedVersusMode = false

		
		local h,m,s = TppClock.FormalizeTime(vars.clock, "time")
		if h >5 and h < 18 then
			svars.espt_of_sneak_day = ESPT_OF_SNEAK_DAY
		end

		
		this.SetSecurityVars()
		this.SetAllGimmickPlacedCount()
		
		
		local numStalmLv = TppMotherBaseManagement.GetMbsStolenAlarmLevel{}
		if numStalmLv == nil then
			Fox.Error("### Cannot Get StolenAlarmLv ###")
		elseif numStalmLv > 2 then
			mvars.numBurglarAlarmRange = RANGE_ALRM_LV03
			mvars.numBurglarAlarmTime = TIME_ALRM_LV03
		else
			mvars.numBurglarAlarmRange = RANGE_ALRM_LV01
			mvars.numBurglarAlarmTime = TIME_ALRM_LV01
		end

		
		GkEventTimerManager.Start( "TimerStartDelay", 5 )
		
		TppTerminal.UnSetUsageRestrictionOnFOB( false )

		
		svars.fobIsThereRecoverStaff = this.IsThereRecoverableStaff()
		
		svars.fobIsSneakForSupporter = this.IsFobSneakForSupport()

		
		TppSoundDaemon.PostEvent( 'env_wormhole_in' )
		o50050_sound.SetPhase_startFOB()

		
		GkEventTimerManager.Start( "TimerDelayDispPlace", 18 )

		
		this.SwitchGoalAreaSpot( true, this.currentClusterSetting.numClstId -1 )

		
		this.AddUniqueMapIconText()

		
		this.SetServerParameter()

		
		
		local fnc_vsCommon = function ()
			
			svars.timeLimitforSneaking = this.GetMissionLimitTime()
			
			if svars.fobIsThereRecoverStaff == true then
				TppRadio.SetOptionalRadio( "Set_f5000_rtrg0020" )
			else
				TppRadio.SetOptionalRadio( "Set_f5000_rtrg0010" )
			end
		end
		this.SwitchExecByIsGameMode(
			function ()
				
				fnc_vsCommon()
				
				this.AddRevengePoint(this.REVENGE_POINT.SNEAKING_FOB)

				
				TppTrophy.Unlock( 22 )
			end,
			function ()
				
				fnc_vsCommon()
			end,
			function ()
				
				svars.timeLimitforVisiting = this.GetMissionLimitTime()
			end
		)
	end,

	OnLeave = function ()
		
		TppPlayer.SetInitialPositionToCurrentPosition()
	end,

	OnUpdate = function ()
	end,

}





sequences.Seq_Game_FOB = {
	Messages = function( self )
		local messageTable = {
 
			Player = {
				{
					
					
					msg = "DeadInFOB",
					func = function (deadPlayerIndex,AttackerId)
						
						Fox.Log("DeadInFOB ::: deadPlayerIndex =" .. tostring(deadPlayerIndex) .. "AttackerId = ".. tostring(AttackerId))
						if deadPlayerIndex == OF_PLAYER_ID then
							this.SwitchExecByIsHost(
								this.OffencePlayerDead, 
								this.KillOffencePlayer,	
								deadPlayerIndex,
								AttackerId
							)
						end
						
						if deadPlayerIndex == DF_PLAYER_ID then
							this.SwitchExecByIsHost(
								this.KillDefencePlayer, 
								this.DefencePlayerDead,	
								deadPlayerIndex,
								AttackerId
							)
						end
					end
				},
				{
					
					msg = "PlayerDamaged",
					func = function (HitObjId, AttackId, AttackerObjId)
						if (HitObjId == OF_PLAYER_ID) and (AttackerObjId == DF_PLAYER_ID) then
							this.SwitchExecByIsHost(
								function()	
									if TppGameSequence.GetPatchVersion() >= PATCH_VERSION_DAY1 then
										this.OnPlayerDamagedOffence(Player.IsAlertImmediatelyOnFob( AttackId ))
										Fox.Log("### OnPlayerDamagedOffence :: isAlertDamage = " .. tostring(isAlertDamage))
									end
								end,
								function()	
									Fox.Log("_____Client Attack Host.") 
									this.SetHeroicPointForClient_DiscoverAttacker()
								end
							)
						elseif (HitObjId == DF_PLAYER_ID) and (AttackerObjId == OF_PLAYER_ID) then
							this.SwitchExecByIsHost(
								function()	
									this.OnPlayerDamagedDefence()
								end,
								function()	
									Fox.Log("_____Host Attack Client.")
								end
							)
						end
					end
				},
				{
					msg = "PlayerFultoned",
					func = function (fultonedPlayerId, staffId, isSuccess, fultonExecuteId)
						Fox.Log("### PlayerFultoned ### fultonExecuteId = " .. tostring(fultonExecuteId) )
						
						if (fultonedPlayerId == OF_PLAYER_ID) then
							
							if mvars.isClientSessionStart ~= true then
								this.SwitchExecByIsHost(
									this.OffencePlayerFultoned, 
									this.FultonOffencePlayer,	
									fultonedPlayerId,
									staffId,
									fultonExecuteId
								)
							end
						
						elseif (fultonedPlayerId == DF_PLAYER_ID) then
							this.SwitchExecByIsHost(
								this.FultonDefencePlayer, 	
								this.DefencePlayerFultoned,	
								fultonedPlayerId,
								staffId,
								fultonExecuteId
							)
						end
					end
				},
				{
					msg = "AbortFromWormholeStart",
					func = function ()
						
						
						Fox.Log("### AbortFromWormholeStart ###")
						if TppServerManager.FobIsSneak() then
							
							mvars.isAbortFromWhole = true
							if mvars.isClientSessionStart ~= true then
								
								TppMission.ReserveMissionClear {
									missionClearType = TppDefine.MISSION_CLEAR_TYPE.FOB_ESCAPE,
									nextMissionId = TppDefine.SYS_MISSION_ID.MTBS_HELI
								}
							end
						end
					end
				},
				{
					







					msg = "CqcHoldStart",
					func = function(AttackPlayerId, ReceivePlayerId)
						Fox.Log("#### CqcHoldStart : #### AttackPlayerId = ".. tostring(AttackPlayerId) .. "ReceivePlayerId = " ..ReceivePlayerId)
						if (ReceivePlayerId == OF_PLAYER_ID) and (AttackPlayerId == DF_PLAYER_ID) then
							this.SwitchExecByIsHost(
								function()	
									
									this.OnPlayerDamagedOffence(true)
								end,
								function()	
									Fox.Log("_____Client Attack Host.") 
									this.SetHeroicPointForClient_DiscoverAttacker()
								end
							)
						end
					end,
				},
				{
					msg = "OnPickUpPlaced",
					func = this.OnPickupPlaced,
				},
				{
					msg = "OnPlayerStaminaOut",
					func = this.OnPlayerStaminaOut,
				},
				{
					msg = "IconFultonShown",
					func = function (gameObjectId, targetObjectId, isContainer, isNuclear)
						Fox.Log("#### IconFultonShown :: gameObjectId = " .. tostring(gameObjectId) .. " isNuclear = " .. tostring(isNuclear))
						if gameObjectId == OF_PLAYER_ID then
							
							if vars.fobSneakMode == FobMode.MODE_ACTUAL then
								if isNuclear == 1 then
									o50050_radio.NearByNuclear()
								end
							end
						end
					end,
				},
			},
 
			Placed = {
				{	
					msg = "OnBreakPlaced",
					func = this.OnBreakPlaced,
				},
			},
 
			Trap = {
				{
					msg = "Enter",
					sender = this.currentClusterSetting.CheckPoints,
					func = function ( trap, gameObjectId )
						Fox.Log("#### Enter : CheckPointTrap :: trap = " .. tostring(trap) .. "  gameObjectId = " .. tostring(gameObjectId))
						
						
						local grade = mtbs_cluster.GetClusterConstruct( this.currentClusterSetting.numClstId )
						if grade > 1 then
							this.FobUpdateRestartPoint( gameObjectId )
						else
							Fox.Log(" No Save : grade has not checkpoint.")
						end
					end,
				},
			},
 
			GameObject = {
				{
					msg = "Dead",
					func = this.OnDeadGameObject,
				},
				{
					msg = "BreakGimmick",
					func = this.OnBreakGimmick,
				},
				{
					
					msg = "BreakGimmickBurglarAlarm",
					func = this.OnBreakGimmickBurglarAlarm,
				},
				{
					msg = "Fulton",
					func = function( gameObjectId, arg1, arg2, arg3 )
						
						TppTerminal.OnFultonMessage( gameObjectId, arg1, arg2, arg3 )

						mvars.fultonInfo = mvars.fultonInfo or {}
						mvars.fultonInfo[gameObjectId] = { gameObjectId, arg1, arg2, arg3 }
					end,
				},
				{
					msg = "FultonInfo",
					func = function ( gameObjectId, fultonedPlayer )
						Fox.Log("### FultonInfo gameObjectId = ".. tostring(gameObjectId) .. "fultonedPlayer = " .. tostring(fultonedPlayer))
						
						TppTerminal.OnFultonInfoMessage( gameObjectId, fultonedPlayer )
						
						mvars.fultonInfo = mvars.fultonInfo or {}
						local fultonInfo = mvars.fultonInfo[gameObjectId]
						if fultonInfo == nil then
							Fox.Log("### FultonInfo :: Not Fulton Success ")
							return
						end
						if fultonedPlayer == OF_PLAYER_ID then
							if Tpp.IsSoldier( gameObjectId ) then
								this.SwitchExecByIsGameMode(
									function ()
										
										
										svars.fobIsThereStolenStaff = true
										this.AddRevengePoint(this.REVENGE_POINT.FULTON_STAFF)
										this.SetAndAnnounceEspPoint_FultonDds()
									end,
									function () end,
									function ()
										svars.cnt_fltn_dds = svars.cnt_fltn_dds + 1
										if TppMotherBaseManagement.IsMbsOwner{} ~= true then
											TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.KILLED_DDS )
										end
									end
								)
							end
							if Tpp.IsFultonContainer( gameObjectId ) then
								this.AddRevengePoint(this.REVENGE_POINT.FULTON_CONTAINER)
								this.SetAndAnnounceEspPoint_FultonCntn()
								this.SwitchExecByIsGameMode(
									function ()
										if Gimmick.CallBurglarAlarm( gameObjectId, mvars.numBurglarAlarmRange, mvars.numBurglarAlarmTime ) == true then
											Fox.Log("___________o50050_sequence.Seq_Game_FOB.Gimmick.CallBurglarAlarm / Fulton")
											this.RequestNoticeGimmick(gameObjectId, OF_PLAYER_ID)
										end
									end,
									function ()
										if Gimmick.CallBurglarAlarm( gameObjectId, mvars.numBurglarAlarmRange, mvars.numBurglarAlarmTime ) == true then
											Fox.Log("___________o50050_sequence.Seq_Game_FOB.Gimmick.CallBurglarAlarm / Fulton")
											this.RequestNoticeGimmick(gameObjectId, OF_PLAYER_ID)
										end
									end,
									function ()
										if TppMotherBaseManagement.IsMbsOwner{} ~= true then
											TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.FULTON_CONTAINER )
										end
									end
								)
							end

							if this.IsAirGun( gameObjectId ) then
								this.AddRevengePoint(this.REVENGE_POINT.FULTON_PUT_WEAPON)
								this.SetAndAnnounceEspPoint_FultonPtwp( "cmmn_name_antiair" )

								this.SwitchExecByIsGameMode(
									function ()
										if Gimmick.CallBurglarAlarm( gameObjectId, mvars.numBurglarAlarmRange, mvars.numBurglarAlarmTime ) == true then
											Fox.Log("___________o50050_sequence.Seq_Game_FOB.Gimmick.CallBurglarAlarm / Fulton")
											this.RequestNoticeGimmick(gameObjectId, OF_PLAYER_ID)
										end
									end,
									function ()
										if Gimmick.CallBurglarAlarm( gameObjectId, mvars.numBurglarAlarmRange, mvars.numBurglarAlarmTime ) == true then
											Fox.Log("___________o50050_sequence.Seq_Game_FOB.Gimmick.CallBurglarAlarm / Fulton")
											this.RequestNoticeGimmick(gameObjectId, OF_PLAYER_ID)
										end
									end,
									function ()
										if TppMotherBaseManagement.IsMbsOwner{} ~= true then
											TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.BREAK_PTW_ANTIAIR )
										end
									end
								)
							end

							if this.IsMortar( gameObjectId ) then
								this.AddRevengePoint(this.REVENGE_POINT.FULTON_PUT_WEAPON)
								this.SetAndAnnounceEspPoint_FultonPtwp("cmmn_name_mortar")

								this.SwitchExecByIsGameMode(
									function ()
									end,
									function ()
									end,
									function ()
										if TppMotherBaseManagement.IsMbsOwner{} ~= true then
											TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.BREAK_PTW_MORTAR )
										end
									end
								)
							end

							if this.IsMachineGun( gameObjectId ) then
								this.AddRevengePoint(this.REVENGE_POINT.FULTON_PUT_WEAPON)
								this.SetAndAnnounceEspPoint_FultonPtwp("cmmn_name_gunsheet")

								this.SwitchExecByIsGameMode(
									function ()
									end,
									function ()
									end,
									function ()
										if TppMotherBaseManagement.IsMbsOwner{} ~= true then
											TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.BREAK_PTW_MACHINEGUN )
										end
									end
								)
							end
							
							mvars.fultonInfo[gameObjectId] = nil
						
							
							this.SwitchExecByIsGameMode(
								function () end,
								function () end,
								function ()
									this.GameOverByCrime()
								end
							)
						end
					end
				},
				{
					msg = "FultonFailed",
					func = function (gameObjectId)
						
						if Tpp.IsFultonContainer( gameObjectId ) or this.IsAirGun( gameObjectId ) then
							Fox.Log("___________o50050_sequence.Seq_Game_FOB.Gimmick.CallBurglarAlarm / FultonFailed ")
							
							if Gimmick.CallBurglarAlarm( gameObjectId, mvars.numBurglarAlarmRange, mvars.numBurglarAlarmTime ) == true then
								this.SwitchExecByIsGameMode(
									function() this.RequestNoticeGimmick(gameObjectId, OF_PLAYER_ID) end,
									function() this.RequestNoticeGimmick(gameObjectId, OF_PLAYER_ID) end,
									function() end
								)
							end
						end
					end
				},
				{
					msg = "ChangePhase", sender = mtbs_enemy.cpNameDefine,
					func = function (gameObjectId, phaseName)
						
						if phaseName == TppGameObject.PHASE_ALERT then
							
							o50050_sound.PlayAlertSiren( true )

							
							this.SwitchGoalAreaSpot(false)

							
							
							if mvars.isDisableAbortTime == false then
								this.DisableAbort{ isDisplayTimer = false }
							end
							
							
							
							if vars.fobSneakMode == FobMode.MODE_ACTUAL then
								this.SwitchExecByIsHost(
									function ()
										
										this.AddRevengePoint(0)

										
										if TppHero.IsHero() == true then
											TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.STARTED_COMBAT_ON_FOB_HERO, "fobFound", nil )
										else
											TppHero.SetAndAnnounceHeroicOgrePoint( TppHero.STARTED_COMBAT_ON_FOB, "fobFound", nil )
										end

										
										TppEventLog.WriteEvent{
											event = EventLog.EVENT_ALERT,
											playerIndex = 0,
											playerPos = Vector3( vars.playerPosX, vars.playerPosY, vars.playerPosZ ),
											playerDir = TppPlayer.GetRotation()
										}
									end,
									function ()
									end
								)
							end
						elseif phaseName < TppGameObject.PHASE_ALERT then
							
							o50050_sound.PlayAlertSiren( false )

							
							this.SwitchGoalAreaSpot( true, this.currentClusterSetting.numClstId -1 )

							
							
							if mvars.isDisableAbortTime == false then
								this.PermitAbort()
							end
						end
					end
				},
				{
					msg = "BurglarAlarmTrap",
					
					
						
						
						
						
					func = function (bAlarmId, bAlarmHash, bAlarmDataSetName, gameObjectId)
						this.SwitchExecByIsGameMode(
							function() this.RequestNoticeGimmick(bAlarmId,gameObjectId) end,
							function() this.RequestNoticeGimmick(bAlarmId,gameObjectId) end,
							function() end
						)
					end
				},
				{	
					
					msg = "WarningGimmick",
					func = function (irSensorId, irHash, irDataSetName, gameObjectId)
						this.SwitchExecByIsGameMode(
							function() this.RequestNoticeGimmick(irSensorId,gameObjectId) end,
							function() this.RequestNoticeGimmick(irSensorId,gameObjectId) end,
							function() end
						)
					end
				},
			},
 
			UI = {
				{
					msg = "EndFadeOut", sender = "FadeOutShowRespawnMenu",
					func = this.ShowRespawnMenu,
					option = { isExecMissionClear = true, isExecDemoPlaying = true, isExecGameOver = true}
				},
				{	
					msg = "EndFadeOut", sender = "FadeOutLeaveVisitMode",
					func = function ()
						TppMission.ReturnToMission()
					end,
					option = { isExecGameOver = true }
				},
				{
					msg = "DisplayTimerTimeUp",
					func = function ()
						Fox.Log("#### DisplayTimerTimeUp:: svars.timeLimitforSneaking = ####"..svars.timeLimitforSneaking)
						
						if svars.timeLimitforSneaking <= 1 then
							if TppServerManager.FobIsSneak() then
								if mvars.isClientSessionStart ~= true then
									TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.FOB_TIME_OVER, TppDefine.GAME_OVER_RADIO.OUT_OF_MISSION_AREA )
								end
							end
						elseif svars.timeLimitforVisiting <= 1 then		
							if TppServerManager.FobIsSneak() then
								if mvars.isClientSessionStart ~= true then
									TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.FOB_TIME_OVER, TppDefine.GAME_OVER_RADIO.OUT_OF_MISSION_AREA )
								end
							end
						end
					end
				},
				{	
					msg = "WormHoleTimerTimeUp",
					func = function ( RestTime , PassTime )
						mvars.isDisableAbortTime = false
						
						if TppEnemy.GetPhase( mtbs_enemy.cpNameDefine ) ~= TppEnemy.PHASE.ALERT then
							
							this.PermitAbort()
						end
					end
				},
				{
					msg = "DisplayTimerLap",
					func = function ( RestTime , PassTime )
						
						if RestTime == this.TIME_LIMIT.CAUTION_TIME_SEC then
							o50050_sound.SetScene_emergencyTime()
						end
					end
				},
				{
					msg = "RespawnClose",
					func = function(respawnPointId)
						this.RespawnPlayer(respawnPointId)

					end,
				},
				{
					msg = "RespawnChange",
					func = function(respawnPointId)
						this.ChangeRespawnPoint(respawnPointId)
					end,
				},

			},
 
			Timer = {
				{	
					msg = "Finish",
					sender = "UiStartDelay",
					func = function ()
						Fox.Log("#### UiStartDelay ####")
						
						this.SwitchExecByIsGameMode(
							function ()
								this.TimerStartTimeLimit("timeLimitforSneaking")
							end,
							function ()
								this.TimerStartTimeLimit("timeLimitforSneaking")
							end,
							function ()
								this.TimerStartTimeLimit("timeLimitforVisiting")
							end
						)
					end
				},
				{
					msg = "Finish",
					sender = "DefenceSearchStartDelay",
					func = function ()
						Fox.Log("#### DefenceSearchStartDelay ####")
						
						TppUiCommand.ActivateSpySearchForFobDefense()
					end
				},
			},
 
			MotherBaseStage = {
				{	
					
					msg = "RespawnClientPlayer",
					func = function ()
						Fox.Log("#### RespawnClientPlayer::Set svars.mis_fobDefenceGameOver Init ####")
						svars.mis_fobDefenceGameOver = TppDefine.FOB_DEFENCE_GAME_OVER_TYPE.INIT
						svars.numRespawnCount = svars.numRespawnCount + 1
						if TppGameSequence.GetPatchVersion() >= PATCH_VERSION_DAY1 then
							TppUiCommand.ActivateSpySearchForFobSneak()
						end
					end
				},
			},
		}
		return
		StrCode32Table( messageTable )
	end,


 
	OnEnter = function ()
		Fox.Log("### Seq_Game_FOB ###")
		
		this._SetupPazRoom(MotherBaseStage.GetCurrentCluster())

		
		this.PermitConnectClient()

		
		this.EnableMultiPlaySession( true )

		
		this.OpenAbortWarmhole()

		
		mvars.numSearchingDefenceTime = 42

		
		TppMusicManager.PostJingleEvent( 'SuspendPhase', 'Play_bgm_fob_jingle_start' )

		
		TppTrap.Enable( this.currentClusterSetting.InnerZoneName )
		TppTrap.Enable( this.currentClusterSetting.OuterZoneName )

		
		
		TppTerminal.UnSetUsageRestrictionOnFOB( false )

		
		o50050_enemy.SetTimerCheckFocusArea()


		
		mvars.mbSoldier_PermitRouteChange = true
		mvars.isClientSessionStart = false			

		
		mvars.isOccuredPlayerDamage = false

		
		mvars.isDisableAbortTime = false
		
		
		if svars.fob_isHostGameStart == false then
			
			if vars.fobIsEvent == FobIsEvent.NOT_EVENT and TppMotherBaseManagement.IsMbsOwner{} ~= true then
				Fox.Log("### Not Owner ###")
				TppServerManager.SendNoticeSneakMotherBase()
			end
			
			
			this.GetAbortWarmHolePosition()
			
			this.SwitchExecByIsGameMode(
				function ()
					
					TppEventLog.StartRecording( TppCoder.GetWorldCenter() )

					
					TppEventLog.WriteEvent{
						event = EventLog.EVENT_PLAYER_START,
						playerIndex = 0,
						playerPos = Vector3( vars.playerPosX, vars.playerPosY, vars.playerPosZ ),
						playerDir = TppPlayer.GetRotation()
					}
				end,
				function () end,
				function () end
			)

			
			if not TppMission.IsMissionStart() then
				
				GkEventTimerManager.Start( "UiStartDelay", 1 )
			end

		
		elseif svars.fob_isHostGameStart == true then
			Fox.Log("### Seq_Game_FOB with Client ###")

			
			local numStalmLv = TppMotherBaseManagement.GetMbsStolenAlarmLevel{}
			if numStalmLv == nil then
				Fox.Error("### Cannot Get StolenAlarmLv ###")
			elseif numStalmLv > 2 then
				mvars.numBurglarAlarmRange = RANGE_ALRM_LV03
				mvars.numBurglarAlarmTime = TIME_ALRM_LV03
			else
				mvars.numBurglarAlarmRange = RANGE_ALRM_LV01
				mvars.numBurglarAlarmTime = TIME_ALRM_LV01
			end

			
			this.SetAllGimmickPlacedCount()


			
			this.SwitchGoalAreaSpot( true, this.currentClusterSetting.numClstId -1 )

			
			this.GameRestartCamera()

			
			this.SetAbortWarmHole()

			mvars.isBootedVersusMode = true


			
			local vsModefunc = function ()
				
				local command = { id = "SetKeepCaution", enable=true }
				local gameObjectId = GameObject.GetGameObjectId( mtbs_enemy.cpNameDefine )
				GameObject.SendCommand( gameObjectId, command )
				
				this.DisableAbort{ isDisplayTimer = true }
				mvars.isDisableAbortTime = true
				
				if TppEnemy.GetPhase( mtbs_enemy.cpNameDefine ) == TppEnemy.PHASE.ALERT then
					this.SwitchGoalAreaSpot(false)
					o50050_sound.PlayAlertSiren( false )
				end
				
			end

			
			this.SwitchExecByIsGameMode(
				function ()
					
					TppEventLog.ResumeRecording()
					vsModefunc()
				end,
				function ()
					vsModefunc()
				end,
				function () end
			)

			
			
			mvars.respawnPosList = {}
			local grade = mtbs_cluster.GetClusterConstruct( this.currentClusterSetting.numClstId )
			for idx = 1, 1 do 
				for k, posKey in pairs(this.CLST_PARAM[this.currentClusterSetting.numClstId].RESPAWN_POS[idx]) do
					table.insert( mvars.respawnPosList, posKey )
				end
			end

			
			this.SetRespawnTime()

			
			TppGameStatus.Set("o50050_sequence.lua","S_ENABLE_FOB_PLAYER_HIDE")
	
	
			
			svars.timeLimitforNonAbort = this.TIME_LIMIT.NON_ABORT
			
			svars.timeLimitforSneaking = svars.timeLimitforSneaking + svars.timeLimitforNonAbort
			
			GkEventTimerManager.Start( "UiStartDelay", 1 )

			
			mtbs_baseTelop.DispBaseName()

			
			this.AddUniqueMapIconText()



			
			if TppServerManager.FobIsSneak() then
				Fox.Log("### for HostPlayer ###")

				
				this.ClearGameStatusOnStartVersus()	
			
			
				
				TppUiStatusManager.ClearStatus( "PauseMenu" )


				
				local vsModeHostfunc = function ()
					
					if svars.fobIsThereRecoverStaff == true then
						TppRadio.SetOptionalRadio( "Set_f5000_rtrg0020" )
					else
						TppRadio.SetOptionalRadio( "Set_f5000_rtrg0010" )
					end

					
					TppUI.ShowAnnounceLog( "fobRivalArrive" )

					
					if TppGameSequence.GetPatchVersion() >= PATCH_VERSION_DAY1 then
						TppUiCommand.ActivateSpySearchForFobSneak()
					end
				end

				
				this.SwitchExecByIsGameMode(
					function ()
						vsModeHostfunc()
						this.WriteEventDefencePlayerStart()

						
						TppEventLog.WriteEvent{
							event = EventLog.EVENT_RESTART,
							playerIndex = 0,
							playerPos = Vector3( vars.playerPosX, vars.playerPosY, vars.playerPosZ ),
							playerDir = TppPlayer.GetRotation()
						}

					end,
					function ()
						vsModeHostfunc()
					end,
					function () end
				)

			else
				Fox.Log("### for ClientPlayer ###")

				
				o50050_enemy.SetFriendly()
				
				o50050_enemy.SetMarkerOnDefence()

				
				local vsModeClientfunc = function ()
 
					
					if svars.fobIsThereRecoverStaff == true then
						TppRadio.SetOptionalRadio( "Set_f5000_rtrg0040" )
					else
						TppRadio.SetOptionalRadio( "Set_f5000_rtrg0030" )
					end

					
					o50050_radio.ClientMissionStart( svars.fobIsThereRecoverStaff )

					
					GkEventTimerManager.Start( "DefenceSearchStartDelay", TIME_DF_START_SEARCH_SEC )

					
					TppMission.UpdateObjective{
						objectives = {
							"clst_goalOfCurrentCluster_test",
						}
					}

					
					this.StartTelopMissionObjective( false )
				end

				
				this.SwitchExecByIsGameMode(
					function ()
						vsModeClientfunc()
					end,
					function ()
						vsModeClientfunc()
					end,
					function ()
						
						GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, { id="SetWormholeIconType", enable = false } )	
					end
				)
			end
		else
			Fox.Error("svars.fob_isHostGameStart is nil")
		end
	end,

 
	OnLeave = function ()
		Fox.Log("leave seq_start")
		if not TppServerManager.FobIsSneak() then
			
			TppGameStatus.Reset("o50050_sequence.lua","S_ENABLE_FOB_PLAYER_HIDE")
		end
		
		
		this.EnableMultiPlaySession( false )
	end,

	OnUpdate = function ()

		
		if TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.FOB_ABORT ) == true then
			TppUI.ShowAccessIconContinue()
		end
	end,

}




function this.IsAllResultSVarsSynchronized()
	local isAllSynced = true
	for svarsName, initialValue in pairs( this.saveVarsList ) do
		if Tpp.IsTypeTable( initialValue ) then
			local name, isSync, isWait = initialValue.name, initialValue.sync, initialValue.wait
			if isSync and isWait then
				local count = 1
				if initialValue.arraySize ~= nil then
					count = initialValue.arraySize
				end
				for index = 0, count - 1 do
					local isSynced = TppScriptVars.SVarsIsSynchronized(name, index)
					if DebugText then
						DebugText.Print(DebugText.NewContext(), {0.5, 0.5, 1.0}, "isSynced = " .. tostring(isSynced) .. ": svars." .. tostring(name) .. "[" .. tostring(index) .. "]"  )
						
					end
					if not isSynced then
						isAllSynced = false
					end
				end
			end
		end
	end

	return isAllSynced
end


function this.HostSetNextSequenceWithCheckSVarsSynced( nextSeqeunce, option )
	local isAllSynced = this.IsAllResultSVarsSynchronized()
	if not isAllSynced then
		return
	end
	if svars.fobIsAllResultSVarsSynced == false then
		svars.fobIsAllResultSVarsSynced = true
		return
	end
	TppSequence.SetNextSequence( nextSeqeunce, option )
end


function this.ClientSetNextSequenceWithCheckSVarsSynced( nextSeqeunce, option )
	local canGoNextSequence = svars.fobIsAllResultSVarsSynced
	if ( not TppNetworkUtil.IsSessionConnect() ) then
		Fox.Error("ClientSetNextSequenceWithCheckSVarsSynced : Already session closed. skip wait svars sync.")
		canGoNextSequence = true
	end
	if canGoNextSequence then
		TppSequence.SetNextSequence( nextSeqeunce, option )
	end
end


function this.EnableMultiPlaySession( enable )
	local platform = Fox.GetPlatformName()
	if platform == "PS4" then
		Fox.Log( "#### EnableMultiPlaySession( " .. tostring( enable ) .. " ) ####" )
		TppNetworkUtil.EnableMultiPlaySession( enable )
	end
end




sequences.Seq_ShowMissionClearDemo = {
	
	Messages = function ( self )
		return
		StrCode32Table {
			Timer = {
				{	
					msg = "Finish",
					sender = "ResultDelay",
					func = function ()
						Fox.Log("#### ResultDelay ####")
						this.SwitchExecByIsHost(
							TppMission.MissionGameEnd,	
							TppMission.MissionGameEnd	
						)
					end,
					option = { isExecMissionClear = true, }
				},
				{
					msg = "Finish", sender = "Timer_HostWin",
					func = function()
						TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_fob_jingle_achieved" )
					end,
					option = { isExecMissionClear = true },
				},
				{
					msg = "Finish", sender = "Timer_ClientLose",
					func = function()
						TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_fob_jingle_not_achieved" )
					end,
					option = { isExecMissionClear = true },
				},
				{
					msg = "Finish", sender = "Timer_HostWHAbort",
					func = function()
						
						TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_fob_jingle_retreat" )

						Player.RequestToSetCameraRotation {
							
							rotX = 45,
							
							rotY = vars.playerRotY,
							
							interpTime = 1
						}

					end,
					option = { isExecMissionClear = true },
				},
				{
					msg = "Finish", sender = "Timer_ClientWHAbort",
					func = function()
						TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_fob_jingle_achieved" )
					end,
					option = { isExecMissionClear = true },
				},
				{
					msg = "Finish", sender = "Timer_StartEscapeCamera",
					func = TppPlayer._StartGameOverCamera,
					option = { isExecMissionClear = true },
				},
			},
			UI = {
				{
					msg = "EndFadeOut", sender = "EndFadeOut_StartTargetEscapeCamera",
					func = TppPlayer._SetTargetDeadCamera,
					option = { isExecMissionClear = true },
				},
			},
		}
	end,
	OnEnter = function(self)
		Fox.Log( " ### Seq_ShowMissionClearDemo ### " )
		Fox.Log( " _____________o50050_sequence.sequences.Seq_ShowMissionClearDemo onEnter / missionClearType : "..tostring(svars.mis_missionClearType) .." isHostWin: ".. tostring(svars.fobIsHostWin) )

		local fnc_vsCommon = function ()
			
			if svars.fobIsHostWin then
				this.SwitchExecByIsHost(
					self.HostWin,			
					self.ClientLose			
				)
			else
				
				if svars.mis_missionClearType == TppDefine.MISSION_CLEAR_TYPE.FOB_ESCAPE then
					this.SwitchExecByIsHost(
						self.HostWHAbort,			
						self.ClientWHAbort			
					)
				
				else
					Fox.Log( " ______THIS MISSION CLEAR TYPE IS UNKONWN.__________ " )
					GkEventTimerManager.Start( "ResultDelay", 1 )
				end
			end
		end
	
		
		this.StopTimerUI()

		
		this.SwitchExecByIsGameMode(
			function ()
				fnc_vsCommon()
			end,
			function ()
				fnc_vsCommon()
			end,
			function ()
				this.SwitchExecByIsHost(
					self.HostVisitEnd,			
					self.ClientVisitEnd			
				)
			end
		)
	end,

	HostWin = function()
		
		GkEventTimerManager.Start( "ResultDelay", 3.25 )

		TppMission.UpdateObjective{
			objectives = { "announce_achieveAllObjectives" },
		}

		o50050_radio.HostMissionWin()

		TppPlayer.FOBPlayMissionClearCamera()

		
		GkEventTimerManager.Start("Timer_HostWin", 0.25 )

	end,
	ClientLose = function()
		
		GkEventTimerManager.Start( "ResultDelay", 7 )

		
		TppUiCommand.StopRespawnMenu()

		o50050_radio.ClientMissionLose()

		TppPlayer.FOBPlayMissionClearCamera()

		
		GkEventTimerManager.Start("Timer_ClientLose", 0.25 )

	end,

	HostWHAbort = function()
		GkEventTimerManager.Start( "ResultDelay", 3 )

		
		GkEventTimerManager.Start("Timer_HostWHAbort", 0.25 )

		o50050_radio.HostMissionAbort()

	end,

	ClientWHAbort = function()
		GkEventTimerManager.Start( "ResultDelay", 3 )

		
		GkEventTimerManager.Start("Timer_ClientWHAbort", 0.25 )

		o50050_radio.ClientMissionAbort()

		
		this.SetCameraEscapeFromWH( OF_PLAYER_ID, "EndFadeOut_StartTargetEscapeCamera" )

		
		TppUiCommand.StopRespawnMenu()

		TppUI.ShowAnnounceLog( "fobRivalEscape" )

		TppMission.UpdateObjective{
			objectives = { "announce_achieveAllObjectives" },
		}
	end,

	HostVisitEnd = function()
		local delayTime = 1
		if mvars.isDoCrime == true then
			delayTime = 3.25
			
			o50050_radio.DoCrimeAndGameOver()
		end
		GkEventTimerManager.Start( "ResultDelay", delayTime )
	end,


	ClientVisitEnd = function()
		
		GkEventTimerManager.Start( "ResultDelay", 1 )

		
		TppUiCommand.StopRespawnMenu()
	end,

}


sequences.Seq_WaitSyncSVarsOnMissionClear = {

	OnEnter = function()
		Fox.Log( " ### Seq_WaitSyncSVarsOnMissionClear ### " )
	end,
	OnUpdate = function()
		
		TppUI.ShowAccessIconContinue()

		this.SwitchExecByIsHost(
			this.HostSetNextSequenceWithCheckSVarsSynced,	
			this.ClientSetNextSequenceWithCheckSVarsSynced,	
			"Seq_ShowMissionClearResult",
			{ isExecMissionClear = true }
		)
	end,

	OnLeave = function()
		TppNetworkUtil.CloseSession()
	end,
}


sequences.Seq_ShowMissionClearResult = {
	Messages = function ( self )
		return
		StrCode32Table {
			UI = {
				{
					msg = "DispFobResultAtkGet",
					func = function ()
						Fox.Log("#### DispFobResultFobGet ####")
					end,
					option = { isExecMissionClear = true, }
				},
				{
					msg = "DispFobResultFobGet",
					func = function ()
						Fox.Log("#### DispFobResultFobGet ####")
					end,
					option = { isExecMissionClear = true, }
				},
				{
					msg = "DispFobResultFobLost",
					func = function ()
						Fox.Log("#### DispFobResultFobLost ####")
						this.SwitchExecByIsHost(
							function ()
							end,	
							function ()
								this.CallRadioClientResult()
							end
						)
					end,
					option = { isExecMissionClear = true, }
				},
				{
					msg = "DispFobResultWormHole",
					func = function ()
						Fox.Log("#### DispFobResultWormHole ####")
						this.SwitchExecByIsHost(
							function ()
								o50050_radio.HostResultOpenWarmhole()	
							end,
							function ()
								o50050_radio.ClientResultOpenWarmhole()	
							end
						)
					end,
					option = { isExecMissionClear = true, }
				},
			},
		}
	end,
	OnEnter = function()
		this.AddGmpByRansome()				
		TppMission.ShowMissionResult()
	end,
}



sequences.Seq_WaitSyncSVarsOnGameOver = {

	OnEnter = function()
		Fox.Log( " ### Seq_WaitSyncSVarsOnGameOver ### " )
		TppTerminal.AddStaffsFromTempBuffer( true )
	end,
	OnUpdate = function()
		
		TppUI.ShowAccessIconContinue()

		this.SwitchExecByIsHost(
			this.HostSetNextSequenceWithCheckSVarsSynced,		
			this.ClientSetNextSequenceWithCheckSVarsSynced,	
			"Seq_ShowGameOverResult",
			{ isExecGameOver = true }
		)
	end,
	OnLeave = function()
		TppNetworkUtil.CloseSession()
	end,

}



sequences.Seq_ShowGameOverResult = {
	


















	Messages = function ( self )
		return
		StrCode32Table {
			UI = {
				{
					msg = "DispFobResultWinlose",
					func = function ()
						Fox.Log("#### DispFobResultWinlose ####")
						this.SwitchExecByIsHost(
							function ()	
								if mvars.isCallStaffDeadRadio == true then
									o50050_radio.HostResultMissionLose_DD_Dead()
								end
							end,
							function ()	
							end
						)
					end,
					option = { isExecGameOver = true, }
				},
				{
					msg = "DispFobResultFobGet",
					func = function ()
						Fox.Log("#### DispFobResultFobGet ####")
					end,
					option = { isExecGameOver = true, }
				},
				{
					msg = "DispFobResultFobLost",
					func = function ()
						Fox.Log("#### DispFobResultFobLost ####")
						this.SwitchExecByIsHost(
							function ()	
							end,
							function ()	
								this.CallRadioClientResult()
							end
						)
					end,
					option = { isExecGameOver = true, }
				},
				{
					msg = "DispFobResultWormHole",
					func = function ()
						Fox.Log("#### DispFobResultWormHole ####")
						this.SwitchExecByIsHost(
							function ()	
								o50050_radio.HostResultOpenWarmhole()	
							end,
							function ()	
								o50050_radio.ClientResultOpenWarmhole()	
							end
						)
					end,
					option = { isExecGameOver = true, }
				},
			},
			Timer = {
				{
					msg = "Finish",
					sender = "ResultDelayGameOver",
					func = function ()
						Fox.Log("#### ResultDelayGameOver ####")
						this.SwitchExecByIsHost(
							TppMission.ShowMissionGameEndAnnounceLog,	
							TppMission.ShowMissionGameEndAnnounceLog	
						)
					end,
					option = { isExecGameOver = true, }
				},
			},
		}
	end,

	OnEnter = function( self )
		Fox.Log( " ### Seq_ShowGameOverResult ### " )
		Fox.Log( " _____________o50050_sequence.sequences.Seq_ShowGameOverResult onEnter / gameOverType : "..tostring(svars.mis_gameOverType) .." isHostWin: ".. tostring(svars.fobIsHostWin) )

		local fnc_vsCommon = function ()
			
			if not svars.fobIsHostWin then
				this.SwitchExecByIsHost(
					self.HostLose,			
					self.ClientWin			
				)
			end
		end

		
		this.AddGmpByRansome()
		this.StopTimerUI()
		
		SubtitlesCommand.SetIsEnabledUiPrioStrong(true)


		this.SwitchExecByIsGameMode(
			function ()
				fnc_vsCommon()
			end,
			function ()
				fnc_vsCommon()
			end,
			function ()
				this.SwitchExecByIsHost(
					self.HostVisitEnd,			
					self.ClientVisitEnd			
				)
			end
		)

	end,

	HostLose = function()
		
		GkEventTimerManager.Start( "ResultDelayGameOver", 6 )
		
		o50050_radio.HostMissionLose()

		TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_fob_jingle_not_achieved" )

		Player.RequestToSetCameraRotation {
			
			rotX = 30,
			
			rotY = vars.playerRotY,

			
			interpTime = 1
		}
	end,

	ClientWin = function()
		
		GkEventTimerManager.Start( "ResultDelayGameOver", 8 )
		
		if TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.PLAYER_DEAD )
		or TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA ) then
			TppPlayer.FOBStartGameOverCamera( 0, "EndFadeOut_StartTargetDeadCamera" )
		end

		
		TppUiCommand.StopRespawnMenu()

		TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_fob_jingle_achieved" )

		o50050_radio.ClientMissionWin()

		TppMission.UpdateObjective{
			objectives = { "announce_achieveAllObjectives" },
		}

	end,

	CallRadio_ResultFobLost = function()
		
		GkEventTimerManager.Start( "ResultDelayGameOver", 8 )

		TppPlayer.FOBStartGameOverCamera( 0, "EndFadeOut_StartTargetDeadCamera" )

		TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_fob_jingle_achieved" )

		o50050_radio.ClientMissionWin()

		TppMission.UpdateObjective{
			objectives = { "announce_fob_defense_success" },
		}
		TppMission.UpdateObjective{
			objectives = { "announce_achieveAllObjectives" },
		}
	end,

	HostVisitEnd = function()
		GkEventTimerManager.Start( "ResultDelayGameOver", 1 )
	end,


	ClientVisitEnd = function()
		
		GkEventTimerManager.Start( "ResultDelayGameOver", 1 )
		
		TppUiCommand.StopRespawnMenu()

	end,

	OnLeave = function()
		SubtitlesCommand.SetIsEnabledUiPrioStrong(false)
	end,

}

sequences.Seq_DefenceGameOver = {

	OnEnter = function()
		TppMission.AbortMission{
			isInterrupt = true,
			isAlreadyGameOver = true,
		}
	end,
}



sequences.Seq_ConfirmRetryPractice = {
	Messages = function ( self )
		return
		StrCode32Table {
			Timer = {
				{	
					msg = "Finish",
					sender = "DialogRetryDelay",
					func = function ()
						Fox.Log("#### DialogRetryDelay ####")
						mvars.isFinishRetryDelay = true
						
						TppUI.FadeOut( TppUI.FADE_SPEED.FADE_HIGHESTSPEED, "FadeOutShowRetryPopup" )
						
						TppUiCommand.ShowPopup( "dialog_practis_restart", Popup.TYPE_TWO_BUTTON )
					end,
					option = { isExecMissionClear = true, isExecGameOver = true}
				},
			},
		}
	end,

	OnEnter = function()
		Fox.Log( " ### Seq_ConfirmRetryPractice ### " )
		
		mvars.isFinishRetryDelay = false
		local isDisplayPopUp = true

		if this.IsThereDefencePlayer() == true										
		or TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.FOB_ABORT ) then	
			isDisplayPopUp = false
		end

		if isDisplayPopUp == true then
			local delayTimer = 1
			
			if TppMission.IsGameOver() == true then
				delayTimer = 6
			end
			GkEventTimerManager.Start( "DialogRetryDelay", delayTimer )
		else
			this.RetrySelectCancel()
		end

	end,

	OnLeave = function()

	end,

	OnUpdate = function()
		
		if mvars.isFinishRetryDelay ~= true then
			return
		end

		if TppUiCommand.IsShowPopup() then
			return
		else
			Fox.Log("#### PopupClose ####")
			
			local select = TppUiCommand.GetPopupSelect()
			
			if select == Popup.SELECT_OK then
				
				if TppGameMode.GetUserMode() == TppGameMode.U_KONAMI_LOGIN then
					
					
					if mvars.isDefiniteRetryPractice ~= true then
						mvars.isDefiniteRetryPractice = true
						TppMission.ExecuteRestartMission()
					end
				else
					
					TppSequence.SetNextSequence( "Seq_ErrorDialogOnRetryPractice", {isExecGameOver = true, isExecMissionClear = true } )
				end
			else
				
				
				this.RetrySelectCancel()
			end
		end
	end,
}



sequences.Seq_ErrorDialogOnRetryPractice = {
	OnEnter = function()
		Fox.Log( " ### Seq_ErrorDialogOnRetryPractice ### " )
		
		TppUiCommand.ShowPopup( "system_3300_all", Popup.TYPE_ONE_BUTTON )
	end,

	OnLeave = function()

	end,

	OnUpdate = function()
		if TppUiCommand.IsShowPopup() then
			return
		else
			Fox.Log("#### PopupClose ####")
			this.RetrySelectCancel()
		end
	end,

}






function this._SetupPazRoom(clusterId)
	if clusterId ~= TppDefine.CLUSTER_DEFINE.Medical then return end

	local layoutCode = vars.mbLayoutCode

	
	if (vars.mbLayoutCode >= 10) and (vars.mbLayoutCode <= 13) then
		numLayout = 13
	elseif (vars.mbLayoutCode >= 20) and (vars.mbLayoutCode <= 23) then
		numLayout = 23
	elseif (vars.mbLayoutCode >= 30) and (vars.mbLayoutCode <= 33) then
		numLayout = 33
	elseif (vars.mbLayoutCode >= 40) and (vars.mbLayoutCode <= 43) then
		numLayout = 43
	elseif (vars.mbLayoutCode >= 70) and (vars.mbLayoutCode <= 73) then
		numLayout = 73
	elseif (vars.mbLayoutCode >= 80) and (vars.mbLayoutCode <= 83) then
		numLayout = 83
	elseif (vars.mbLayoutCode >= 90) and (vars.mbLayoutCode <= 93) then
		numLayout = 93
	else
		numLayout = vars.mbLayoutCode
	end
	
	do 
		local doorName = "ly0"..tostring(numLayout).."_cl04_item0000|cl04pl0_uq_0040_gimmick2|mtbs_door006_door001_gim_n0002|srt_mtbs_door006_door001"
		local dataSetPath = "/Assets/tpp/level/location/mtbs/block_area/ly0"..tostring(layoutCode).."/cl04/mtbs_ly0"..tostring(layoutCode).."_cl04_item.fox2"
		Gimmick.SetEventDoorLock( doorName, dataSetPath, true, 0 )
	end
	do 
		TppDataUtility.SetEnableDataFromIdentifier( "mtbs_uni0040_155641_587", "Light_PazRoom", false, false )
		TppDataUtility.SetEnableDataFromIdentifier( "mtbs_uni0040_155641_587", "Probe_PazRoom", false, false )
		TppDataUtility.SetEnableDataFromIdentifier( "mtbs_uni0040_155641_587", "Trap_PazRoom", false, false )
	end
	do 
		local dataSetName = "/Assets/tpp/level/location/mtbs/block_area/ly0".. tostring(layoutCode) .. "/cl04/mtbs_ly0" ..tostring(layoutCode) .."_cl04_item.fox2"
		local switchOnLeavePazRoom = "ly0"..tostring(numLayout).."_cl04_item0000|cl04pl0_uq_0040_gimmick2|gntn_swtc001_vrtn001_gim_n0001|srt_gntn_swtc001_vrtn001"
		
		Gimmick.InvisibleGimmick( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, switchOnLeavePazRoom, dataSetName, true )
	end
end





function this.SetServerParameter()

	local parameters = TppNetworkUtil.GetFobServerParameter()

	
	mvars.heroicPointOffenseWin				= 500	
	mvars.heroicPointOffenseLose			= -50	
	mvars.heroicPointDefenceWinEliminate	= 300	
	mvars.heroicPointDefenceWinAbort		= 100	
	mvars.heroicPointDefenceLose			= -30	
	mvars.espionagePointOffenseGoal			= 150	
	mvars.espionagePointOffenseGoalOnVersus	= 100	
	mvars.espionagePointDefenceBlockGoal	= 100	

	Fox.Log( "Initialize ServerParameter" )
	Fox.Log( " heroicPointOffenseWin             :" .. tostring( mvars.heroicPointOffenseWin ) )
	Fox.Log( " heroicPointOffenseLose            :" .. tostring( mvars.heroicPointOffenseLose ) )
	Fox.Log( " heroicPointDefenceWinEliminate    :" .. tostring( mvars.heroicPointDefenceWinEliminate ) )
	Fox.Log( " heroicPointDefenceWinAbort        :" .. tostring( mvars.heroicPointDefenceWinAbort ) )
	Fox.Log( " heroicPointDefenceLose            :" .. tostring( mvars.heroicPointDefenceLose ) )
	Fox.Log( " espionagePointOffenseGoal         :" .. tostring( mvars.espionagePointOffenseGoal ) )
	Fox.Log( " espionagePointOffenseGoalOnVersus :" .. tostring( mvars.espionagePointOffenseGoalOnVersus ) )
	Fox.Log( " espionagePointDefenceBlockGoal    :" .. tostring( mvars.espionagePointDefenceBlockGoal ) )

	Fox.Log( "SetServerParameter:" .. tostring( parameters ) )

	if parameters then
		
		for i, parameter in ipairs( parameters ) do
			if i == FobServerParameter.HEROIC_POINT_OFFENSE_WIN then
				mvars.heroicPointOffenseWin = parameter
				Fox.Log( " Set heroicPointOffenseWin:" .. tostring( parameter ) )
			elseif i == FobServerParameter.HEROIC_POINT_OFFENSE_LOSE then
				mvars.heroicPointOffenseLose = parameter
				Fox.Log( " Set heroicPointOffenseLose:" .. tostring( parameter ) )
			elseif i == FobServerParameter.HEROIC_POINT_DEFENCE_WIN_ELIMINATE then
				mvars.heroicPointDefenceWinEliminate = parameter
				Fox.Log( " Set heroicPointDefenceWinEliminate:" .. tostring( parameter ) )
			elseif i == FobServerParameter.HEROIC_POINT_DEFENCE_WIN_ABORT then
				mvars.heroicPointDefenceWinAbort = parameter
				Fox.Log( " Set heroicPointDefenceWinAbort:" .. tostring( parameter ) )
			elseif i == FobServerParameter.HEROIC_POINT_DEFENCE_LOSE then
				mvars.heroicPointDefenceLose = parameter
				Fox.Log( " Set heroicPointDefenceLose:" .. tostring( parameter ) )
			elseif i == FobServerParameter.ESPIONAGE_POINT_OFFENSE_GOAL then
				mvars.espionagePointOffenseGoal = parameter
				Fox.Log( " Set espionagePointOffenseGoal:" .. tostring( parameter ) )
			elseif i == FobServerParameter.ESPIONAGE_POINT_OFFENSE_GOAL_ON_VERSUS then
				mvars.espionagePointOffenseGoalOnVersus = parameter
				Fox.Log( " Set espionagePointOffenseGoalOnVersus:" .. tostring( parameter ) )
			elseif i == FobServerParameter.ESPIONAGE_POINT_DEFENCE_BLOCK_GOAL then
				mvars.espionagePointDefenceBlockGoal = parameter
				Fox.Log( " Set espionagePointDefenceBlockGoal:" .. tostring( parameter ) )
			end
		end
	end
end




return this
