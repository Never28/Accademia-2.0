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
    if((sResRef == "tut_arma")&&(GetItemPossessedBy(oPC,"crystal_tut") != OBJECT_INVALID))
        return TRUE;
    return FALSE;
}
