int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oWeap = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
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
    if((sResRef=="loot_mo_16_br1")
    &&(GetItemPossessedBy(oPC,"crystal_pos_2")!=OBJECT_INVALID)&& GetGold(oPC)>=32000)
        return TRUE;
    return FALSE;
}
