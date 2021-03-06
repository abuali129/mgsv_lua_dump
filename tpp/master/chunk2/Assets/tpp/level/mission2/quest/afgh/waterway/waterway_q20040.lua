local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId









local TARGET_HOSTAGE_NAME = "hos_quest_0000"


this.QUEST_TABLE = {
	
	questType = TppDefine.QUEST_TYPE.RECOVERED,
	
	cpList = {
		{
			cpName = "quest_cp",
			cpPosition_x = -1700.586, cpPosition_y = 350.250, cpPosition_z = -320.083, cpPosition_r = 100.0,
			isOuterBaseCp = true,
			gtName = "gt_quest_0000",
			gtPosition_x = -1700.586, gtPosition_y = 350.250, gtPosition_z = -320.083, gtPosition_r = 100.0,
		},
	},
	
	
	enemyList = {
		{ 
			enemyName = "sol_quest_0004",
			route_d = "rt_quest_d_0000", 	route_c = "rt_quest_c_0000",
			powerSetting = { "SNIPER", }
		},
		{ 
			enemyName = "sol_quest_0005",
			route_d = "rt_quest_d_0001", 	route_c = "rt_quest_c_0001",
			powerSetting = { "SNIPER", }
		},
		{ 
			enemyName = "sol_quest_0006",
			route_d = "rt_quest_d_0002", 	route_c = "rt_quest_c_0002",
			powerSetting = { "SNIPER", }
		},
		{ 
			enemyName = "sol_quest_0007",
			route_d = "rt_quest_d_0003", 	route_c = "rt_quest_c_0003",
			powerSetting = { "SNIPER", }
		},
	},
	
	vehicleList = {
		nil
	},
	
	hostageList = {
		{
			hostageName = TARGET_HOSTAGE_NAME,
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
			
			TppEnemy.OnTerminateQuest( this.QUEST_TABLE )
		end,
	}
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
end








quest_step.QStep_Start = {
	OnEnter = function()
		TppQuest.SetNextQuestStep( "QStep_Main" )
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
					msg = "Fulton",
					func = function( gameObjectId )
						local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "Fulton", gameObjectId )
						TppQuest.ClearWithSave( isClearType )
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
					msg = "Unconscious",
					func = function( gameObjectId )
						local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "Unconscious", gameObjectId )
						TppQuest.ClearWithSave( isClearType )
					end
				},
				{	
					msg = "VehicleBroken",
					func = function( gameObjectId, state )
						if state == StrCode32("End") then
							local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "VehicleBroken", gameObjectId )
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





return this
