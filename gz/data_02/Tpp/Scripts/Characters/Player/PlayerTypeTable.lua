PlayerTypeTable = {

InitTable = function()
	PlayerManager:ClearTable()
	PlayerManager:AddTable(
		"PLTypeNormal",
		"/Assets/tpp/parts/chara/sna/sna0_main0_def_v00.parts",
		"/Assets/tpp/pack/player/parts/plparts_sna0_main0_def_v00.fpk",
		"/Assets/tpp/pack/player/motion/plmot_base_default.fpk",
		"/Assets/tpp/motion/mtar/player/TppNewPlayer_layers.mtar",
		"/Assets/tpp/motion/mtar/player/TppNewPlayerFacial.mtar"
	)
	PlayerManager:AddTable(
		"PLTypeHospital",
		"/Assets/tpp/parts/chara/sna/sna1_main0_def_v00.parts",
		"/Assets/tpp/pack/player/parts/plparts_sna1_main0_def_v00.fpk",
		"/Assets/tpp/pack/player/motion/plmot_base_default.fpk",
		"/Assets/tpp/motion/mtar/player/TppNewPlayer_layers.mtar",
		"/Assets/tpp/motion/mtar/player/TppNewPlayerFacial.mtar"
	)
	PlayerManager:AddTable(
		"PLTypeSneakingSuit",
		"/Assets/tpp/parts/chara/sna/sna2_main0_def_v00.parts",
		"/Assets/tpp/pack/player/parts/plparts_sna2_main0_def_v00.fpk",
		"/Assets/tpp/pack/player/motion/plmot_base_gz.fpk",
		"/Assets/tpp/motion/mtar/player/TppGzPlayer_layers.mtar",
		"/Assets/tpp/motion/mtar/player/TppGzPlayerFacial.mtar"
	)
	PlayerManager:AddTable(
		"PLTypeScarf",
		"/Assets/tpp/parts/chara/sna/sna0_main1_def_v00.parts",
		"/Assets/tpp/pack/player/parts/plparts_sna0_main1_def_v00.fpk",
		"/Assets/tpp/pack/player/motion/plmot_base_default.fpk",
		"/Assets/tpp/motion/mtar/player/TppNewPlayer_layers.mtar",
		"/Assets/tpp/motion/mtar/player/TppNewPlayerFacial.mtar"
	)
	PlayerManager:AddTable(
		"PLTypeMgs1",
		"/Assets/tpp/parts/chara/sna/sna6_main0_def_v00.parts",
		"/Assets/tpp/pack/player/parts/plparts_sna6_main0_def_v00.fpk",
		"/Assets/tpp/pack/player/motion/plmot_base_gz.fpk",
		"/Assets/tpp/motion/mtar/player/TppGzPlayer_layers.mtar",
		"/Assets/tpp/motion/mtar/player/TppGzPlayerFacial.mtar"
	)
	PlayerManager:AddTable(
		"PLTypeRaiden",
		"/Assets/tpp/parts/chara/rai/rai0_main0_def_v00.parts",
		"/Assets/tpp/pack/player/parts/plparts_rai0_main0_def_v00.fpk",
		"/Assets/tpp/pack/player/motion/plmot_base_gz.fpk",
		"/Assets/tpp/motion/mtar/player/TppGzPlayer_layers.mtar",
		"/Assets/tpp/motion/mtar/player/TppGzPlayerFacial.mtar"
	)
	PlayerManager:AddTable(
		"PLTypeNinja",
		"/Assets/tpp/parts/chara/nin/nin0_main0_def_v00.parts",
		"/Assets/tpp/pack/player/parts/plparts_nin0_main0_def_v00.fpk",
		"/Assets/tpp/pack/player/motion/plmot_base_gz.fpk",
		"/Assets/tpp/motion/mtar/player/TppGzPlayer_layers.mtar",
		"/Assets/tpp/motion/mtar/player/TppGzPlayerFacial.mtar"
	)			
end,
	
}
