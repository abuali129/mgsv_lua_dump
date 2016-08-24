function GetEntryWeaponSelectAttachment(t)local _=""..t
local e=""..(t+1)local t="id_customize_itmLst_record000"..(_..".UI_ID_C_ItmList_record.")local t={type="MgoUiMenuEntry",name="menu_entry_weapon_edit_attachment_"..e,states={{type="MgoUiAnimationStateSwitch",name="stateInit",mode="enter",control="play",layout=t.."UI_ID_C_ItmLst_Focus_Out"},{type="MgoUiAnimationStateSwitch",name="stateInit",mode="enter",control="play",layout=t.."UI_ID_C_ItmLst_Edge_Off"},{type="MgoUiAnimationStateSwitch",name="stateInit",mode="enter",control="play",layout=t.."UI_ID_C_ItmLst_New_Off"},{type="MgoUiAnimationStateSwitch",name="stateHot",mode="enter",control="play",layout=t.."UI_ID_C_ItmLst_Focus"},{type="MgoUiAnimationStateSwitch",name="stateHot",mode="enter",control="stop",layout=t.."UI_ID_C_ItmLst_Focus_Out"},{type="MgoUiAnimationStateSwitch",name="stateIdle",mode="enter",control="play",layout=t.."UI_ID_C_ItmLst_Focus_Out"},{type="MgoUiAnimationStateSwitch",name="stateIdle",mode="enter",control="stop",layout=t.."UI_ID_C_ItmLst_Focus"},{type="MgoUiAnimationStateSwitch",name="stateHot",mode="enter",control="play",loop="true",layout=t.."UI_ID_C_ItmLst_Cursor_Noise"}},widgets={{type="MgoUiLabel",name="label_weapon_edit_attachment_name_"..e,source="mgo_idroid_weapon_edit_list_name",index=_,layout=t.."UI_ID_C_ItmLst_ItmName_txt",default="D.Name"},{type="MgoUiImage",name="image_weapon_edit_attachment_"..e,source="mgo_idroid_weapon_edit_list_texture",index=_,layout=t.."UI_ID_C_ItmLst_ItmIcon",default="Icon"},{type="MgoUiLabel",name="label_weapon_edit_attachment_ammo_"..e,source="mgo_idroid_weapon_edit_list_ammo",index=_,layout=t.."UI_ID_C_WepParam_num_txt",default=""},{type="MgoUiLabel",name="label_weapon_edit_attachment_weight_"..e,source="mgo_idroid_weapon_edit_list_weight",index=_,layout=t.."UI_ID_C_WepParam_Wgt_txt",default=""},{type="MgoUiLabel",name="label_weapon_edit_attachment_dmgtype_"..e,source="mgo_idroid_weapon_edit_list_dmgtype",index=_,layout=t.."UI_DmgType_txt",default=""},{type="MgoUiLabel",name="label_weapon_edit_attachment_eqp"..e,source="mgo_idroid_weapon_edit_list_eqp",index=_,layout=t.."UI_mark_eqp_txt",default=""},{type="MgoUiAnimation",name="anim_weapon_attachment_list_"..(e.."_ctrl"),source="mgo_idroid_weapon_edit_list_anim_ctrl",index=_,layout="",options={{key="_on_",layout=t.."UI_ID_C_ItmLst_On"},{key="_off_",layout=t.."UI_ID_C_ItmLst_Off"}}},{type="MgoUiAnimation",name="anim_weapon_attachment_list_"..(e.."_ammo"),source="mgo_idroid_weapon_edit_list_anim_ammo",index=_,layout="",options={{key="_off_",layout=t.."UI_ID_C_IL_wppm_num_none"},{key="_wep_",layout=t.."UI_ID_C_IL_wppm_num_wep"},{key="_itm_",layout=t.."UI_ID_C_IL_wppm_num_itm"}}},{type="MgoUiAnimation",name="anim_weapon_attachment_list_"..(e.."_weight"),source="mgo_idroid_weapon_edit_list_anim_weight",index=_,layout="",options={{key="_on_",layout=t.."UI_ID_C_IL_wppm_wgt_on"},{key="_off_",layout=t.."UI_ID_C_IL_wppm_wgt_off"}}},{type="MgoUiAnimation",name="anim_weapon_attachment_list_"..(e.."_dmgtype"),source="mgo_idroid_weapon_edit_list_anim_dmgtype",index=_,layout="",options={{key="_off_",layout=t.."UI_ID_C_IL_type_none"},{key="_dmg_",layout=t.."UI_ID_C_IL_type_dmg"},{key="_zzz_",layout=t.."UI_ID_C_IL_type_zzz"}}},{type="MgoUiAnimation",name="anim_weapon_attachment_list_"..(e.."_slot"),source="mgo_idroid_weapon_edit_list_slot",index=_,layout="",options={{key="_off_",layout=t.."UI_ID_C_IL_wpcat_pri_none"},{key="_hip_",layout=t.."UI_ID_C_IL_wpcat_pri_hip"},{key="_back_",layout=t.."UI_ID_C_IL_wpcat_pri_back"}}},{type="MgoUiAnimation",name="anim_weapon_attachment_list_"..(e.."_eqp"),source="mgo_idroid_weapon_edit_list_anim_eqp",index=_,layout="",options={{key="_on_",layout=t.."UI_ID_C_ItmLst_EQ_On"},{key="_off_",layout=t.."UI_ID_C_ItmLst_EQ_Off"}}},{type="MgoUiAnimation",name="anim_weapon_attachment_list_"..(e.."_lvlctrl"),source="mgo_idroid_weapon_edit_list_levelctrl",index=_,layout="",options={{key="_on_",layout=t.."UI_ID_C_ItmLst_Lvl_On"},{key="_off_",layout=t.."UI_ID_C_ItmLst_Lvl_Off"}}}}}return t
end
CharacterModWeaponEditAttach={widgets={{type="MgoUiLabel",name="label_attachment_edit_list_num",source="mgo_idroid_edit_list_num",layout="UI_ID_Customize_PT2_layout.UI_ID_C_ItmLst_Num_txt",default="[0]"},{type="MgoUiLabel",name="label_list_description",source="mgo_idroid_gear_edit_list_help",layout="UI_ID_Customize_PT2_layout.UI_ID_C_ItmLst_Help_txt",default="[0]",textUnitCount=12},{type="MgoUiLabel",name="label_list_description_sdw",source="mgo_idroid_gear_edit_list_help",layout="UI_ID_Customize_PT2_layout.UI_ID_C_ItmLst_Help_sdw_txt",default="[0]",textUnitCount=12},{type="MgoUiMenu",name="menu_weapon_edit_attachment",sizeSource="mgo_idroid_weapon_edit_list_name",hideEmpty="true",states={{type="MgoUiAnimationStateSwitch",name="stateInit",mode="enter",control="play",layout="UI_ID_Customize_PT2_layout.UI_ID_C_PT2_ItmLst_Show"},{type="MgoUiAnimationStateSwitch",name="stateShow",mode="enter",control="stop",layout="UI_ID_Customize_PT2_layout.UI_ID_C_PT2_ItmPool_Show"},{type="MgoUiAnimationStateSwitch",name="stateShow",mode="enter",control="play",layout="UI_ID_Customize_PT2_layout.UI_ID_C_PT2_ItmPool_Hide"}},widgets={GetEntryWeaponSelectAttachment(0),GetEntryWeaponSelectAttachment(1),GetEntryWeaponSelectAttachment(2),GetEntryWeaponSelectAttachment(3),GetEntryWeaponSelectAttachment(4),GetEntryWeaponSelectAttachment(5),GetEntryWeaponSelectAttachment(6)}}}}