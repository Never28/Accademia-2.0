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
    if((sResRef=="weap_bas_lcros4"||sResRef=="weap_bas_lbow4"||sResRef=="weap_bas_sbow4"||sResRef=="weap_bas_sli4")
    &&(GetItemPossessedBy(oPC,"crystal_div_2")!=OBJECT_INVALID)&& GetGold(oPC)>=32000)
        return TRUE;
    return FALSE;
}
