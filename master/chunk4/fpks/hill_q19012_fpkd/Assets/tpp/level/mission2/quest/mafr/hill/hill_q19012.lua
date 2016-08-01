local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId






local TARGET_HOSTAGE_NAME = "hos_quest_0000"


this.QUEST_TABLE = {
	
	questType = TppDefine.QUEST_TYPE.RECOVERED,
	
	cpList = {
		nil
	},
	
	enemyList = {
		{
			enemyName = "sol_quest_0000",
			route_d = "rt_quest_d_0000", 	route_c = "rt_quest_c_0000",
			cpName = "mafr_hillNorth_ob",
			soldierSubType = "PF_C",
		},
		{
			enemyName = "sol_quest_0001",
			route_d = "rt_quest_d_0001", 	route_c = "rt_quest_c_0001",
			cpName = "mafr_hillNorth_ob",
			soldierSubType = "PF_C",
		},
	},
	
	vehicleList = {
		nil
	},
	
	hostageList = {
		{
			hostageName		= TARGET_HOSTAGE_NAME,
			bodyId			= TppDefine.QUEST_BODY_ID_LIST.Q19012,
			faceId			= TppDefine.QUEST_FACE_ID_LIST.Q19012,
			uniqueTypeId	= TppDefine.UNIQUE_STAFF_TYPE_ID.QUEST_KIKONGO,
			langType		= "afrikaans",
			voiceType		= { "hostage_a", },
		},
	},
	
	targetList = {
		TARGET_HOSTAGE_NAME,
	},
}



function this.OnAllocate()
	 TppQuest.RegisterQuestStepList{
		"QStep_Start",
		"QStep_Main",
		nil
	}
	
	
	TppEnemy.OnAllocateQuestFova( this.QUEST_TABLE )
	
	
	TppHostage2.SetHostageType{ 
		gameObjectType	= "TppHostageUnique",
		hostageType		= "NoStand",
	}
	
	TppQuest.RegisterQuestStepTable( quest_step )
	TppQuest.RegisterQuestSystemCallbacks{
		OnActivate = function()
			Fox.Log("quest_recv_child OnActivate")
			
			TppEnemy.OnActivateQuest( this.QUEST_TABLE )
		end,
		OnDeactivate = function()
			Fox.Log("quest_recv_child OnDeactivate")
			
			TppEnemy.OnDeactivateQuest( this.QUEST_TABLE )
		end,
		OnOutOfAcitveArea = function()
		end,
		OnTerminate = function()
			
			this.SwitchEnableQuestHighIntTable( false, "mafr_hillNorth_ob", this.questCpInterrogation )
			
			TppEnemy.OnTerminateQuest( this.QUEST_TABLE )
		end,
	}
	
	mvars.fultonInfo = TppDefine.QUEST_CLEAR_TYPE.NONE
end




this.Messages = function()
	return
	StrCode32Table {
		Block = {
			{
				msg = "StageBlockCurrentSmallBlockIndexUpdated",
				func = function() end,
			},
		},
	}
end




function this.OnInitialize()
	TppQuest.QuestBlockOnInitialize( this )
end

function this.OnUpdate()
	TppQuest.QuestBlockOnUpdate( this )
end

function this.OnTerminate()
	TppQuest.QuestBlockOnTerminate( this )
	
	TppUiCommand.UnRegisterIconUniqueInformation( GameObject.GetGameObjectId( TARGET_HOSTAGE_NAME ) )
end








quest_step.QStep_Start = {
	OnEnter = function()
		TppQuest.SetNextQuestStep( "QStep_Main" )
		this.SwitchEnableQuestHighIntTable( true, "mafr_hillNorth_ob", this.questCpInterrogation )
		
		TppUiCommand.RegisterIconUniqueInformation{ markerId = GameObject.GetGameObjectId(TARGET_HOSTAGE_NAME), langId = "marker_ene_translator" }
	end,
}

quest_step.QStep_Main = {
	Messages = function( self )
		return
		StrCode32Table {
			GameObject = {
				{	
					msg = "Dead",
					func = function( gameObjectId )
						local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "Dead", gameObjectId )
						TppQuest.ClearWithSave( isClearType )
					end
				},
				{	
					msg = "FultonInfo",
					func = function( gameObjectId )
						if mvars.fultonInfo ~= TppDefine.QUEST_CLEAR_TYPE.NONE then
							TppQuest.ClearWithSave( mvars.fultonInfo )
						end
						mvars.fultonInfo = TppDefine.QUEST_CLEAR_TYPE.NONE
					end
				},
				{	
					msg = "Fulton",
					func = function( gameObjectId )
						local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "Fulton", gameObjectId )
						mvars.fultonInfo = isClearType
					end
				},
				{	
					msg = "FultonFailed",
					func = function( gameObjectId, locatorName, locatorNameUpper, failureType )
						if failureType == TppGameObject.FULTON_FAILED_TYPE_ON_FINISHED_RISE then
							local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "FultonFailed", gameObjectId )
							TppQuest.ClearWithSave( isClearType )
						end
					end
				},
				{	
					msg = "PlacedIntoVehicle",
					func = function( gameObjectId, vehicleGameObjectId )
						if Tpp.IsHelicopter( vehicleGameObjectId ) then
							local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "InHelicopter", gameObjectId )
							TppQuest.ClearWithSave( isClearType )
						end
					end
				},
			},
		}
	end,
	OnEnter = function()
		Fox.Log("QStep_Main OnEnter")
	end,
	OnLeave = function()
		Fox.Log("QStep_Main OnLeave")
	end,
}







this.InterCall_hostage_pos01 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : Quest InterCall_hostage_pos01")
	

	TppMarker.EnableQuestTargetMarker( TARGET_HOSTAGE_NAME )		

end


this.questCpInterrogation = {
	
	{ name = "enqt1000_1i1210", func = this.InterCall_hostage_pos01, },	



}

this.SwitchEnableQuestHighIntTable = function( flag, commandPostName, questCpInterrogation )

	local commandPostId = GameObject.GetGameObjectId( "TppCommandPost2" , commandPostName )

	if flag then
		
		TppInterrogation.SetQuestHighIntTable( commandPostId, questCpInterrogation )
	else
		
		TppInterrogation.RemoveQuestHighIntTable( commandPostId, questCpInterrogation )
	end

end

return this