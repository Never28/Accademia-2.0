int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oWeap = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    string sResRef = GetResRef(oWeap);
    object oItem = GetFirstItemInInventory(oPC);
    itemproperty ip_Item = GetFirstItemProperty(oWeap);
    while(GetIsItemPropertyValid(ip_Item)){
        int nType = GetItemPropertyType(ip_Item);
        if(nType == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER||
        nType == ITEM_PROPERTY_ADDITIONAL||
        nType == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N||
        nType == ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL){
            return FALSE;
        }
        ip_Item = GetNextItemProperty(oWeap);
    }
    if((sResRef=="weap_bas_lcro1"||sResRef=="weap_bas_lbow1"||sResRef=="weap_bas_sbow1"||sResRef=="weap_bas_sli1")
    &&(GetItemPossessedBy(oPC,"crystal_mag_1")!=OBJECT_INVALID)&& GetGold(oPC)>=8000)
        return TRUE;
    return FALSE;
}
