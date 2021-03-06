local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.radioList = {
	"f2000_rtrg1110",
	"f2000_rtrg1120",
	"f2000_rtrg1130",
}

this.debugRadioLineTable = {
}




this.optionalRadioList = {
	"Set_f2000_oprg4010",	
}









this.MissionListGuide00 = function()
	Fox.Log("#### s10211_radio.MissionStart ####")
	TppRadio.Play( "f2000_rtrg1110" )
end

this.MissionListGuide10 = function()
	Fox.Log("#### s10211_radio.MissionStart ####")
	TppRadio.Play( "f2000_rtrg8010" , { delayTime = "mid" })
end

this.AddGZStaff = function()
	Fox.Log("#### s10211_radio.MissionStart ####")
	TppRadio.Play( "f2000_rtrg1130" )

end

this.SetOptionalRadioFromSituation = function()
	
	local canSortieAnyBuddy =	TppBuddyService.CanSortieBuddyType( BuddyType.DOG )			or
								TppBuddyService.CanSortieBuddyType( BuddyType.QUIET )			or
								TppBuddyService.CanSortieBuddyType( BuddyType.WALKER_GEAR )

	
	if TppStory.IsMissionOpen(10140) and not(TppStory.IsMissionCleard(10140))then		
		this.SetOptionalRadioInEmergency()
		return
	elseif TppStory.IsMissionOpen(10150) and not(TppStory.IsMissionCleard(10150))then	
		this.SetOptionalRadioInEmergency()
		return
	elseif TppStory.IsMissionOpen(10151) and not(TppStory.IsMissionCleard(10151))then	
		this.SetOptionalRadioInEmergency()
		return
	elseif TppStory.IsMissionOpen(10240) and not(TppStory.IsMissionCleard(10240))then	
		this.SetOptionalRadioInEmergency()
		return
	end
	
	
	TppRadio.SetOptionalRadio("Set_f2000_oprg4010")			
	
	
	
	if(canSortieAnyBuddy)then
		this.InsertToActiveOptionalRadio("f2000_oprg0310")		
	end

	
	if(TppStory.IsMissionCleard(10240))then
		
	elseif(TppStory.IsMissionCleard(10140))then
		this.InsertToActiveOptionalRadio("f2000_oprg0300")		

	elseif(TppStory.IsMissionCleard(10120))then
		this.InsertToActiveOptionalRadio("f2000_oprg0290")		
	
	elseif(TppStory.IsMissionCleard(10070))then
		this.InsertToActiveOptionalRadio("f2000_oprg0280")		
	
	elseif(TppStory.IsMissionCleard(10030))then
		this.InsertToActiveOptionalRadio("f2000_oprg1030")		
		this.InsertToActiveOptionalRadio("f2000_oprg1020")		
		this.InsertToActiveOptionalRadio("f2000_oprg0240")		
	end

	
	if(TppDemo.IsPlayedMBEventDemo("EntrustDdog"))then
		if(TppBuddyService.CanSortieBuddyType( BuddyType.DOG ))then
		else
			this.InsertToActiveOptionalRadio("f2000_oprg0260")	
		end
		
	end
	if TppStory.CanArrivalQuietInMB(true) then
		if(TppBuddyService.CanSortieBuddyType( BuddyType.QUIET ))then
		else
			this.InsertToActiveOptionalRadio("f2000_oprg0270")	
		end
	end
end

this.InsertToActiveOptionalRadio = function(targetRadio)
	local radioDaemon =RadioDaemon:GetInstance()
	TppRadioCommand.RegisterRadioGroupToActiveRadioGroupSetInsert( targetRadio, 0 )
end

this.RemoveToActiveOptionalRadio = function(targetRadio)
	local radioDaemon =RadioDaemon:GetInstance()
	TppRadioCommand.UnregisterRadioGroupFromActiveRadioGroupSet( targetRadio )
end

this.SetOptionalRadioInEmergency = function()
	Fox.Log("#### heli_common_radio.SetOptionalRadioFromSituation #### In Emergency! Base Optional Radio Replace Special Edition.")
	TppRadio.SetOptionalRadio("Set_f2000_oprg4020")
end




return this
