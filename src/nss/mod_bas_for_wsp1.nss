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
    if((sResRef=="weap_bas_daxe1"||sResRef=="weap_bas_dmace1"||sResRef=="weap_bas_dswo1"||sResRef=="weap_bas_alab1"||
    sResRef=="weap_bas_staff1"||sResRef=="weap_bas_scy1"||sResRef=="weap_bas_spea1"||sResRef=="weap_bas_lanbat1"||
    sResRef=="weap_bas_trid1"||sResRef=="weap_bas_gaxe1"||sResRef=="weap_bas_smaxe1"||sResRef=="weap_bas_baxe1"||
    sResRef=="weap_bas_dwaxe1"||sResRef=="weap_bas_kat1"||sResRef=="weap_bas_scim1"||sResRef=="weap_bas_rap1"||
    sResRef=="weap_bas_kama1"||sResRef=="weap_bas_whi1"||sResRef=="weap_bas_sic1"||sResRef=="weap_bas_club1"||
    sResRef=="weap_bas_dag1"||sResRef=="weap_bas_bsw1"||sResRef=="weap_bas_ssw1"||sResRef=="weap_bas_lsw1"||
    sResRef=="weap_bas_gsw1"||sResRef=="weap_bas_lham1"||sResRef=="weap_bas_sham1"||sResRef=="weap_bas_lfla1"||
    sResRef=="weap_bas_hfla1"||sResRef=="weap_bas_mace1"||sResRef=="weap_bas_kukr1_1"||sResRef=="weap_bas_lsta1")&&
    (GetItemPossessedBy(oPC,"crystal_pos_1")!=OBJECT_INVALID)&& GetGold(oPC)>=2000)
        return TRUE;
    return FALSE;
}
