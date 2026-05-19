int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oWeap = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    string sResRef = GetResRef(oWeap);
    object oItem = GetFirstItemInInventory(oPC);
    int nControll = 0;
    while(oItem!= OBJECT_INVALID){
        if(GetTag(oItem) == "crystal_neg_2"||GetTag(oItem) == "crystal_mag_2"||GetTag(oItem) == "crystal_div_2"||
        GetTag(oItem) == "crystal_pos_2")
            nControll = 1;
        oItem = GetNextItemInInventory(oPC);
    }
    if((sResRef=="weap_bas_daxe4"||sResRef=="weap_bas_dmace4"||sResRef=="weap_bas_dswo4"||sResRef=="weap_bas_alab4"||
    sResRef=="weap_bas_staff4"||sResRef=="weap_bas_scy4"||sResRef=="weap_bas_spea4"||sResRef=="weap_bas_lanbat4"||
    sResRef=="weap_bas_trid4"||sResRef=="weap_bas_gaxe4"||sResRef=="weap_bas_smaxe4"||sResRef=="weap_bas_baxe4"||
    sResRef=="weap_bas_dwaxe4"||sResRef=="weap_bas_kat4"||sResRef=="weap_bas_scim4"||sResRef=="weap_bas_rap4"||
    sResRef=="weap_bas_kama4"||sResRef=="weap_bas_whi4"||sResRef=="weap_bas_sic4"||sResRef=="weap_bas_club4"||
    sResRef=="weap_bas_dag4"||sResRef=="weap_bas_bsw4"||sResRef=="weap_bas_ssw4"||sResRef=="weap_bas_lsw4"||
    sResRef=="weap_bas_gsw4"||sResRef=="weap_bas_lham4"||sResRef=="weap_bas_sham4"||sResRef=="weap_bas_lfla4"||
    sResRef=="weap_bas_hfla4"||sResRef=="weap_bas_mace4"||sResRef=="weap_bas_kukri1_4"||sResRef=="weap_bas_lstar4"
    ||sResRef=="weap_bas_sbow4"||sResRef=="weap_bas_lbow4"||sResRef=="weap_bas_lcro4"||sResRef=="weap_bas_lsli4"
    ||sResRef=="weap_bas_axt_4"||sResRef=="weap_bas_dar_4"||sResRef=="weap_bas_shu_4")&& nControll == 4)
        return TRUE;
    return FALSE;
}
