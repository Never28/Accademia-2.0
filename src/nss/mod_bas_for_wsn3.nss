int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oWeap = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    string sResRef = GetResRef(oWeap);
    object oItem = GetFirstItemInInventory(oPC);
    itemproperty ip_Item = GetFirstItemProperty(oWeap);
    while(GetIsItemPropertyValid(ip_Item)){
        int nType = GetItemPropertyType(ip_Item);
        if(nType == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER){
            return FALSE;
        }
        ip_Item = GetNextItemProperty(oWeap);
    }
    if((sResRef=="weap_bas_daxe6"||sResRef=="weap_bas_dmace6"||sResRef=="weap_bas_dswo6"||sResRef=="weap_bas_alab6"||
    sResRef=="weap_bas_staff6"||sResRef=="weap_bas_scy6"||sResRef=="weap_bas_spea6"||sResRef=="weap_bas_lanbat6"||
    sResRef=="weap_bas_trid6"||sResRef=="weap_bas_gaxe6"||sResRef=="weap_bas_smaxe6"||sResRef=="weap_bas_baxe6"||
    sResRef=="weap_bas_dwaxe6"||sResRef=="weap_bas_kat6"||sResRef=="weap_bas_scim6"||sResRef=="weap_bas_rap6"||
    sResRef=="weap_bas_kama6"||sResRef=="weap_bas_whi6"||sResRef=="weap_bas_sic6"||sResRef=="weap_bas_club6"||
    sResRef=="weap_bas_dag6"||sResRef=="weap_bas_bsw6"||sResRef=="weap_bas_ssw6"||sResRef=="weap_bas_lsw6"||
    sResRef=="weap_bas_gsw6"||sResRef=="weap_bas_lham6"||sResRef=="weap_bas_sham6"||sResRef=="weap_bas_lfla6"||
    sResRef=="weap_bas_hfla6"||sResRef=="weap_bas_mace6"||sResRef=="weap_bas_kukr1_6"||sResRef=="weap_bas_lstar6")&&
    (GetItemPossessedBy(oPC,"crystal_neg_3")!=OBJECT_INVALID)&& GetGold(oPC)>=128000)
        return TRUE;
    return FALSE;
}
