local e={}e.DeclareGVarsTable={{name="ini_isReturnToTitle",type=TppScriptVars.TYPE_BOOL,value=false,save=false},{name="ini_isTitleMode",type=TppScriptVars.TYPE_BOOL,value=false,save=false},{name="DEBUG_initMissionToTitle",type=TppScriptVars.TYPE_BOOL,value=false,save=false},{name="DEBUG_showSysVars",type=TppScriptVars.TYPE_BOOL,value=false,save=false},{name="DEBUG_showGameStatus",type=TppScriptVars.TYPE_BOOL,value=false,save=false},{name="usingNormalMissionSlot",type=TppScriptVars.TYPE_BOOL,value=true,save=false},{name="DEBUG_usingTemporarySaveData",type=TppScriptVars.TYPE_BOOL,value=true,save=false},{name="permitGameSave",type=TppScriptVars.TYPE_BOOL,value=true,save=false},{name="needWaitMissionInitialize",type=TppScriptVars.TYPE_BOOL,value=false,save=false},{name="enableResultPause",type=TppScriptVars.TYPE_BOOL,value=false,save=false},{name="forcePlayerPositionDemoCenter",type=TppScriptVars.TYPE_BOOL,value=false,save=false},{name="mis_nextMissionCodeForEmergency",type=TppScriptVars.TYPE_UINT32,value=0,save=false},{name="mis_nextLayoutCodeForEmergency",type=TppScriptVars.TYPE_UINT32,value=TppDefine.INVALID_LAYOUT_CODE,save=false},{name="mis_nextClusterIdForEmergency",type=TppScriptVars.TYPE_UINT32,value=TppDefine.INVALID_CLUSTER_ID,save=false},{name="mis_nextMissionStartRouteForEmergency",type=TppScriptVars.TYPE_UINT32,value=0,save=false},{name="gameDataLoadingResult",type=TppScriptVars.TYPE_INT8,value=TppDefine.SAVE_FILE_LOAD_RESULT.INIT,save=false},{name="elapsedTimeSinceLastPlay",type=TppScriptVars.TYPE_UINT32,value=0,save=false},{name="isPlayedHappyBirthDayToday",type=TppScriptVars.TYPE_BOOL,value=false,save=false},{name="waitLoadingTipsEnd",type=TppScriptVars.TYPE_BOOL,value=false,save=false},{name="isMissionClearedS10030",type=TppScriptVars.TYPE_BOOL,value=false,save=false},{name="canExceptionHandling",type=TppScriptVars.TYPE_BOOL,value=true,save=false},{name="reservedMissionStartMbSync",type=TppScriptVars.TYPE_BOOL,value=false,save=false},{name="sav_SaveResultCheckFileName",type=TppScriptVars.TYPE_UINT32,value=0,save=false},{name="sav_isReservedMbSaveResultNotify",type=TppScriptVars.TYPE_BOOL,value=false,save=false},{name="isContinueFromTitle",type=TppScriptVars.TYPE_BOOL,value=false,save=false},{name="exc_processState",type=TppScriptVars.TYPE_UINT8,value=0,save=false},{name="exc_exceptionProcessing",type=TppScriptVars.TYPE_BOOL,value=false,save=false},{name="exc_processingExecptionType",type=TppScriptVars.TYPE_UINT8,value=0,save=false},{name="exc_processingExecptionGameMode",type=TppScriptVars.TYPE_UINT8,value=0,save=false},{name="exc_exceptionQueueDepth",type=TppScriptVars.TYPE_UINT8,value=0,save=false},{name="exc_exceptionQueue",arraySize=TppDefine.EXCEPTION_QUEUE_MAX,type=TppScriptVars.TYPE_UINT8,value=0,save=false},{name="exc_queueGameMode",arraySize=TppDefine.EXCEPTION_QUEUE_MAX,type=TppScriptVars.TYPE_UINT8,value=0,save=false},{name="ene_soldier2CommonPackageLabelIndex",type=TppScriptVars.TYPE_UINT32,value=TppDefine.DEFAULT_SOLIDER2_COMMON_PACKAGE,save=false},{name="title_nextLocationCode",type=TppScriptVars.TYPE_UINT8,value=30,save=false},{name="title_nextMissionCode",type=TppScriptVars.TYPE_UINT16,value=0,save=false},{name="f30050_missionPackIndex",type=TppScriptVars.TYPE_UINT8,value=0,save=false},{name="isNewGame",type=TppScriptVars.TYPE_BOOL,value=true,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="missionStartClock",type=TppScriptVars.TYPE_UINT32,value=(12*60)*60,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="missionStartWeather",type=TppScriptVars.TYPE_UINT8,value=TppDefine.WEATHER.SUNNY,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="missionStartWeatherNextTime",type=TppScriptVars.TYPE_FLOAT,value=(5*60)*60,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="missionStartExtraWeatherInterval",type=TppScriptVars.TYPE_FLOAT,value=(8*60)*60,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="initAmmoStockIds",arraySize=TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT,type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="initAmmoStockCounts",arraySize=TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT,type=TppScriptVars.TYPE_UINT16,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="initAmmoInWeapons",arraySize=TppDefine.WEAPONSLOT.GUN_WEAPON_MAX,type=TppScriptVars.TYPE_UINT16,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="initAmmoSubInWeapons",arraySize=TppDefine.WEAPONSLOT.GUN_WEAPON_MAX,type=TppScriptVars.TYPE_UINT16,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="mis_isStartFromHelispace",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="mis_isStartFromFreePlay",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="mis_missionStartRecoverDemoType",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION_RESTARTABLE},{name="totalMissionClearCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="totalPerfectStealthMissionClearCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="totalStealthMissionClearCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="totalRetryCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_RETRY},{name="totalNeutralizeCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="totalKillCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="totalBreakVehicleCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="totalHelicopterDestoryCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="totalWalkerGearDestoryCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="totalBreakPlacedGimmickCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="totalBreakBurglarAlarmCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="totalMineRemoveCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="totalAnnihilateOutPostCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="totalAnnihilateBaseCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="totalMarkingCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="totalInterrogateCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="totalRescueCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="totalheadShotCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="ply_isUsingTempPlayerType",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ply_lastPlayerPartsTypeUsingTemp",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ply_lastPlayerCamoTypeUsingTemp",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ply_lastPlayerHandTypeUsingTemp",type=TppScriptVars.TYPE_UINT16,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ply_lastPlayerTypeUsingTemp",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ply_lastPlayerFaceIdUsingTemp",type=TppScriptVars.TYPE_UINT16,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ply_lastPlayerFaceEquipIdUsingTemp",type=TppScriptVars.TYPE_UINT16,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ply_isUsingTempWeapons",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ply_isUsingTempItems",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ply_lastWeaponsUsingTemp",arraySize=12,type=TppScriptVars.TYPE_UINT16,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ply_lastItemsUsingTemp",arraySize=8,type=TppScriptVars.TYPE_UINT16,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ply_lastHandEquipUsingTemp",type=TppScriptVars.TYPE_UINT16,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ply_useMissionStartPos",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ply_missionStartPos",type=TppScriptVars.TYPE_FLOAT,value=0,arraySize=3,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ply_missionStartRot",type=TppScriptVars.TYPE_INT32,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ply_useMissionStartPosForNoOrderBox",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ply_missionStartPosForNoOrderBox",type=TppScriptVars.TYPE_FLOAT,value=0,arraySize=3,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ply_missionStartRotForNoOrderBox",type=TppScriptVars.TYPE_INT32,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="sav_varRestoreForContinue",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ply_initialPlayerState",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ply_missionStartPoint",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="heli_missionStartRoute",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="str_storySequence",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="str_missionOpenPermission",type=TppScriptVars.TYPE_BOOL,value=false,arraySize=TppDefine.MISSION_COUNT_MAX,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="str_missionOpenFlag",type=TppScriptVars.TYPE_BOOL,value=false,arraySize=TppDefine.MISSION_COUNT_MAX,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="str_missionClearedFlag",type=TppScriptVars.TYPE_BOOL,value=false,arraySize=TppDefine.MISSION_COUNT_MAX,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="str_missionNewOpenFlag",type=TppScriptVars.TYPE_BOOL,value=false,arraySize=TppDefine.MISSION_COUNT_MAX,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="str_isAllMissionCleared",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="str_isAllMissionSRankCleared",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="str_elapsedMissionCount",arraySize=TppDefine.ELAPSED_MISSION_COUNT_MAX,type=TppScriptVars.TYPE_INT8,value=-127,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="str_didLostQuiet",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="isHero",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="firstRescueMillerClearedGMP",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="mis_isExistOpenMissionFlag",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="mis_checkPoint",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="mis_orderBoxName",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="mis_nextMissionCodeForMissionClear",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="mis_missionClearState",type=TppScriptVars.TYPE_UINT8,value=TppDefine.MISSION_CLEAR_STATE.INIT,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="mis_quietCallCountOnMissionStart",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="ene_isRecoverdInterpreterAfgh",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ene_isRecoverdInterpreterMafr",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ene_fovaUniqueTargetIds",type=TppScriptVars.TYPE_UINT16,value=0,arraySize=TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT,save=false},{name="ene_fovaUniqueFaceIds",type=TppScriptVars.TYPE_UINT16,value=0,arraySize=TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT,save=false},{name="ene_fovaUniqueBodyIds",type=TppScriptVars.TYPE_UINT16,value=0,arraySize=TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT,save=false},{name="ene_fovaUniqueFlags",type=TppScriptVars.TYPE_UINT8,value=0,arraySize=TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT,save=false},{name="ene_takingOverHostageCount",type=TppScriptVars.TYPE_UINT8,value=0,save=true},{name="ene_takingOverHostagePositions",type=TppScriptVars.TYPE_FLOAT,value=0,arraySize=TppDefine.MAX_TAKING_OVER_HOSTAGE_COUNT*3,save=true},{name="ene_takingOverHostageStaffIdsUpper",type=TppScriptVars.TYPE_UINT32,value=0,arraySize=TppDefine.MAX_TAKING_OVER_HOSTAGE_COUNT,save=true},{name="ene_takingOverHostageStaffIdsLower",type=TppScriptVars.TYPE_UINT32,value=0,arraySize=TppDefine.MAX_TAKING_OVER_HOSTAGE_COUNT,save=true},{name="ene_takingOverHostageFaceIds",type=TppScriptVars.TYPE_UINT16,value=0,arraySize=TppDefine.MAX_TAKING_OVER_HOSTAGE_COUNT,save=true},{name="ene_takingOverHostageFlags",type=TppScriptVars.TYPE_UINT32,value=0,arraySize=TppDefine.MAX_TAKING_OVER_HOSTAGE_COUNT,save=true},{name="col_daimondStatus_afgh",type=TppScriptVars.TYPE_UINT8,value=0,arraySize=2e3,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="col_markerStatus_afgh",type=TppScriptVars.TYPE_UINT32,value=0,arraySize=33,save=true,category=TppScriptVars.CATEGORY_MISSION_RESTARTABLE},{name="col_isRegisteredInDb_afgh",type=TppScriptVars.TYPE_BOOL,value=0,arraySize=2e3,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="col_daimondStatus_mafr",type=TppScriptVars.TYPE_UINT8,value=0,arraySize=2e3,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="col_markerStatus_mafr",type=TppScriptVars.TYPE_UINT32,value=0,arraySize=33,save=true,category=TppScriptVars.CATEGORY_MISSION_RESTARTABLE},{name="col_isRegisteredInDb_mafr",type=TppScriptVars.TYPE_BOOL,value=0,arraySize=2e3,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="col_daimondStatus_mtbs",type=TppScriptVars.TYPE_UINT8,value=0,arraySize=1e3,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="col_markerStatus_mtbs",type=TppScriptVars.TYPE_UINT32,value=0,arraySize=33,save=true,category=TppScriptVars.CATEGORY_MISSION_RESTARTABLE},{name="col_isRegisteredInDb_mtbs",type=TppScriptVars.TYPE_BOOL,value=0,arraySize=1e3,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="gim_missionStartBreakableObjects",type=TppScriptVars.TYPE_UINT8,value=0,arraySize=1024,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="gim_checkPointBreakableObjects",type=TppScriptVars.TYPE_UINT8,value=0,arraySize=1024,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="gim_missionStartFultonableObjects",type=TppScriptVars.TYPE_UINT8,value=0,arraySize=1024,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="gim_checkPointStartFultonableObjects",type=TppScriptVars.TYPE_UINT8,value=0,arraySize=1024,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="gim_brekableLightName",type=TppScriptVars.TYPE_UINT32,value=0,arraySize=128,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="gim_brekableLightStatus",type=TppScriptVars.TYPE_BOOL,value=false,arraySize=128,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ply_isAllGotStation_Afgh",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="ply_isAllGotStation_Mafr",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_isPushRewardOpenSection",type=TppScriptVars.TYPE_BOOL,value=false,save=true,arraySize=8,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_isPushRewardAnimalPlatform",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_isPushRewardOpenMBDvcArmsMenu",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_isPushRewardGunSmith",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_isPushRewardCanDevDDog",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_isPushRewardCanDevQuiet",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_isPushRewardCanDevDWalker",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_isPushRewardCanDevBattleGear",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_isPushRewardCanDevNuclear",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_isPushRewardOpenFob",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_isPushRewardBuddyCommand",arraySize=5,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_isPushRewardBattleGearDevelopComplete",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_isPushRewardOpenWeaponCustomize",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_isPushConstructedFirstFob",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_isPushRewardCanCustomVehicle",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_isPushRewardCanDevArm",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_isPushRewardSeparationPlatform",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_isPushRewardCanDevQuietEquip",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_isPushRewardCanDevParasiteSuit",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_doneUpdatePandemicLimit",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="pck_missionPackLabelName",type=TppScriptVars.TYPE_UINT32,value=Fox.StrCode32"default",save=true,category=TppScriptVars.CATEGORY_MISSION},{name="rwd_missionRewardLangEnum",arraySize=TppDefine.REWARD_MAX.MISSION,type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="rwd_missionRewardStackSize",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="rwd_missionRewardParam",arraySize=TppDefine.REWARD_MAX.MISSION*TppDefine.REWARD_PARAM.MAX,type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="rwd_mbManagementRewardLangEnum",arraySize=TppDefine.REWARD_MAX.MB_MANAGEMENT,type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="rwd_mbManagementRewardStackSize",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="rwd_mbManagementRewardParam",arraySize=TppDefine.REWARD_MAX.MB_MANAGEMENT*TppDefine.REWARD_PARAM.MAX,type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="res_bestRank",type=TppScriptVars.TYPE_UINT8,arraySize=TppDefine.MISSION_COUNT_MAX,value=(TppDefine.MISSION_CLEAR_RANK.E+1),save=true,category=TppScriptVars.CATEGORY_MISSION},{name="res_missionClearHistorySize",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="res_missionClearHistory",type=TppScriptVars.TYPE_UINT16,arraySize=TppDefine.MISSION_CLEAR_HISTORY_LIMIT,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="res_neutralizeCount",type=TppScriptVars.TYPE_UINT8,arraySize=((TppDefine.PLAYSTYLE_HISTORY_MAX+1)*TppDefine.PLAYSTYLE_SAVE_INDEX_MAX),value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="res_neutralizeHistorySize",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="res_neutralizeCountForPlayData",type=TppScriptVars.TYPE_UINT32,arraySize=TppDefine.PLAYSTYLE_SAVE_INDEX_MAX,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="res_headShotCount",type=TppScriptVars.TYPE_UINT32,arraySize=(TppDefine.PLAYSTYLE_HISTORY_MAX+1),value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="res_isStealth",type=TppScriptVars.TYPE_BOOL,arraySize=(TppDefine.PLAYSTYLE_HISTORY_MAX+1),value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="res_isPerfectStealth",type=TppScriptVars.TYPE_BOOL,arraySize=(TppDefine.PLAYSTYLE_HISTORY_MAX+1),value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ui_isTaskLastComleted",arraySize=#TppDefine.MISSION_LIST*TppDefine.MAX_MISSION_TASK_COUNT,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="solface_groupNumber",type=TppScriptVars.TYPE_UINT32,value=672983,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="hosface_groupNumber",type=TppScriptVars.TYPE_UINT32,value=88069,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="trm_doneIsolateByManual",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_donePandemicEvent",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_donePandemicTutorial",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_lastPandemicBingoCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_currentPandemicBingoCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_currentPandemicRestCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_fobTutorialState",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_doneFobTutorialInThisGame",type=TppScriptVars.TYPE_BOOL,value=false,save=false,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_recoveredSoldierCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_recoveredHostageCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_recoveredAfghGoatCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_recoveredMafrGoatCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_recoveredDonkeyCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_recoveredZebraCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_recoveredOkapiCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_animalRecoverHistory",type=TppScriptVars.TYPE_UINT32,arraySize=TppDefine.MAX_ANIMAL_RECOVERED_HISTORY_SIZE,value=0,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="trm_animalRecoverHistorySize",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="rnk_isOpen",arraySize=TppDefine.RANKING_MAX,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_TotalTacticalTakeDownCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_XPersonMarkingTime",type=TppScriptVars.TYPE_FLOAT,value=999999,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_FirstHeadShotTime",type=TppScriptVars.TYPE_FLOAT,value=999999,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_FirstHeadShotTimeTranq",type=TppScriptVars.TYPE_FLOAT,value=999999,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_FirstCommandPostAnnihilateTime",type=TppScriptVars.TYPE_FLOAT,value=999999,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_CboxGlidingDistance",type=TppScriptVars.TYPE_FLOAT,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_MechaNeutralizeCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_LongestBirdShotDistance",type=TppScriptVars.TYPE_FLOAT,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_XPersonPerfectStealthCQCNeutralizeTime",type=TppScriptVars.TYPE_FLOAT,value=999999,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_XRocketArmNeutralizeTime",type=TppScriptVars.TYPE_FLOAT,value=999999,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_FobSneakingGoalCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_FobDefenceSucceedCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_NuclearDisposeCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_missionBestScore",type=TppScriptVars.TYPE_UINT32,value=0,arraySize=TppDefine.MISSION_COUNT_MAX,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_missionBestScoreUsedLimitEquip",type=TppScriptVars.TYPE_UINT32,value=0,arraySize=TppDefine.MISSION_COUNT_MAX,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_mtbs_q42010",type=TppScriptVars.TYPE_FLOAT,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_mtbs_q42020",type=TppScriptVars.TYPE_FLOAT,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_mtbs_q42030",type=TppScriptVars.TYPE_FLOAT,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_mtbs_q42040",type=TppScriptVars.TYPE_FLOAT,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_mtbs_q42050",type=TppScriptVars.TYPE_FLOAT,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_mtbs_q42060",type=TppScriptVars.TYPE_FLOAT,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rnk_mtbs_q42070",type=TppScriptVars.TYPE_FLOAT,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="qst_currentQuestName",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_QUEST},{name="qst_currentQuestStepNumber",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_QUEST},{name="qst_questOpenFlag",arraySize=TppDefine.QUEST_MAX,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_QUEST},{name="qst_questRepopFlag",arraySize=TppDefine.QUEST_MAX,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_QUEST},{name="qst_questClearedFlag",arraySize=TppDefine.QUEST_MAX,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_QUEST},{name="qst_questActiveFlag",arraySize=TppDefine.QUEST_MAX,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_QUEST},{name="rwd_questRewardLangEnum",arraySize=TppDefine.REWARD_MAX.QUEST,type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_QUEST},{name="rwd_questRewardStackSize",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_QUEST},{name="rwd_questRewardParam",arraySize=TppDefine.REWARD_MAX.QUEST*TppDefine.REWARD_PARAM.MAX,type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_QUEST},{name="qst_allQuestCleared",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_QUEST},{name="qst_randomFaceId",arraySize=TppDefine.QUEST_FACE_MAX,type=TppScriptVars.TYPE_UINT16,value=0,save=true,category=TppScriptVars.CATEGORY_QUEST},{name="qst_elapseCount",type=TppScriptVars.TYPE_INT8,value=-127,save=true,category=TppScriptVars.CATEGORY_QUEST},{name="qst_volginQuestCleared",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="qst_failedIndex",arraySize=10,type=TppScriptVars.TYPE_INT32,value=-1,save=true,category=TppScriptVars.CATEGORY_QUEST},{name="retryCount",type=TppScriptVars.TYPE_INT32,value=0,save=true,category=TppScriptVars.CATEGORY_RETRY},{name="failedCount",type=TppScriptVars.TYPE_INT32,value=0,save=true,category=TppScriptVars.CATEGORY_RETRY},{name="timeParadoxCount",type=TppScriptVars.TYPE_INT32,value=0,save=true,category=TppScriptVars.CATEGORY_RETRY},{name="playTime",type=TppScriptVars.TYPE_INT32,value=0,save=true,category=TppScriptVars.CATEGORY_RETRY},{name="crawlTime",type=TppScriptVars.TYPE_INT32,value=0,save=true,category=TppScriptVars.CATEGORY_RETRY},{name="squatTime",type=TppScriptVars.TYPE_INT32,value=0,save=true,category=TppScriptVars.CATEGORY_RETRY},{name="continueTipsCount",type=TppScriptVars.TYPE_INT32,value=1,save=true,category=TppScriptVars.CATEGORY_RETRY},{name="sortieGmpCost",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="chickenCapClearCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="elapsedTimeSinceLastUseChickCap",type=TppScriptVars.TYPE_UINT32,value=((2*24)*60)*60,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="rad_isFinishMissionListTutorial",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="s10043_forceMissionClear",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="f30050_hangerLevel",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="f30050_NuclearAbolitionCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="f30050_isInitNuclearAbolitionCount",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="s10100_boyEscape",arraySize=#TppDefine.S10100_BOY_LIST,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="s10100_boyEscapeCurrentPlay",arraySize=#TppDefine.S10100_BOY_LIST,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="quietHasFriendshipWithChildFlag",arraySize=#TppDefine.S10100_BOY_LIST,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="s10240_isPlayedFuneralDemo",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="trp_isGot",arraySize=48,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},{name="mbFreeDemoPlayedFlag",arraySize=#TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="mbFreeDemoPlayRequestFlag",arraySize=#TppDefine.MB_FREEPLAY_DEMO_REQUESTFLAG_LIST,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="mbFreeDemoPlayNextIndex",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="pazEventPhase",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="pazLookedPictureCount",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="forceMbRadioPlayedFlag",arraySize=#TppDefine.FORCE_MB_RETURN_RADIO_LIST,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ui_isTipsGuideShownOnce",arraySize=TppDefine.MAX_TIPS_GUIDE_SHOWN_ONCE,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ui_isTipsGuidShownInThisGame",arraySize=TppDefine.MAX_TIPS_GUIDE_SHOWN_ONCE,type=TppScriptVars.TYPE_BOOL,value=false,save=false,category=TppScriptVars.CATEGORY_MISSION},{name="ui_isControlGuideShownOnce",arraySize=TppDefine.MAX_CONTROL_GUIDE_SHOWN_ONCE,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},{name="ui_isControlGuidShownInThisGame",arraySize=TppDefine.MAX_CONTROL_GUIDE_SHOWN_ONCE,type=TppScriptVars.TYPE_BOOL,value=false,save=false,category=TppScriptVars.CATEGORY_MISSION},{name="isChangeDlcStatus",type=TppScriptVars.TYPE_BOOL,value=false,save=false},{name="dbg_forceMaster",type=TppScriptVars.TYPE_BOOL,value=false,save=false},{name="dbg_autoMissionOpenClearCheck",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},nil}TppScriptVars.DeclareGVars(e.DeclareGVarsTable)if Fox.GetPlatformName()=="PS3"then
e.DeclareGVarsTable=nil
end
function e.AllInitialize()if e.DeclareGVarsTable==nil then
return
end
for a,e in ipairs(e.DeclareGVarsTable)do
local r,e,a=e.name,e.arraySize,e.value
if e and(e>1)then
for e=0,(e-1)do
gvars[r][e]=a
end
else
gvars[r]=a
end
end
end
return e