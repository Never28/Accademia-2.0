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
    if((sResRef=="weap_bas_axt_1"||sResRef=="weap_bas_dar_1"||sResRef=="weap_bas_shu_1")&&
    (GetItemPossessedBy(oPC,"crystal_mag_1")!=OBJECT_INVALID)&& GetGold(oPC)>=2000)
        return TRUE;
    return FALSE;
}
