int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oWeap = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    string sResRef = GetResRef(oWeap);
    object oItem = GetFirstItemInInventory(oPC);
    int nControll = 0;
    while(oItem!= OBJECT_INVALID){
        if(GetTag(oItem) == "crystal_neg_3"||GetTag(oItem) == "crystal_mag_3"||GetTag(oItem) == "crystal_div_3"||
        GetTag(oItem) == "crystal_pos_3")
            nControll = 1;
        oItem = GetNextItemInInventory(oPC);
    }
    if((sResRef=="weap_bas_daxe6"||sResRef=="weap_bas_dmace6"||sResRef=="weap_bas_dswo6"||sResRef=="weap_bas_alab6"||
    sResRef=="weap_bas_staff6"||sResRef=="weap_bas_scy6"||sResRef=="weap_bas_spea6"||sResRef=="weap_bas_lanbat6"||
    sResRef=="weap_bas_trid6"||sResRef=="weap_bas_gaxe6"||sResRef=="weap_bas_smaxe6"||sResRef=="weap_bas_baxe6"||
    sResRef=="weap_bas_dwaxe6"||sResRef=="weap_bas_kat6"||sResRef=="weap_bas_scim6"||sResRef=="weap_bas_rap6"||
    sResRef=="weap_bas_kama6"||sResRef=="weap_bas_whi6"||sResRef=="weap_bas_sic6"||sResRef=="weap_bas_club6"||
    sResRef=="weap_bas_dag6"||sResRef=="weap_bas_bsw6"||sResRef=="weap_bas_ssw6"||sResRef=="weap_bas_lsw6"||
    sResRef=="weap_bas_gsw6"||sResRef=="weap_bas_lham6"||sResRef=="weap_bas_sham6"||sResRef=="weap_bas_lfla6"||
    sResRef=="weap_bas_hfla6"||sResRef=="weap_bas_mace6"||sResRef=="weap_bas_kukri1_6"||sResRef=="weap_bas_lstar6"
    ||sResRef=="weap_bas_sbow6"||sResRef=="weap_bas_lbow6"||sResRef=="weap_bas_lcro6"||sResRef=="weap_bas_lsli6"
    ||sResRef=="weap_bas_axt_6"||sResRef=="weap_bas_dar_6"||sResRef=="weap_bas_shu_6")&& nControll == 4)
        return TRUE;
    return FALSE;
}
