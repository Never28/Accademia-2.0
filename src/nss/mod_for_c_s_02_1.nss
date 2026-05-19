int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetFirstItemInInventory(oPC);
    string sTag;
    int nItem1=0,nItem2=0,nItem3=0,nGold;
    nGold = GetGold(oPC);
    while(oItem!=OBJECT_INVALID){
        sTag = GetTag(oItem);
        if(sTag=="craft_2_mor")
            nItem1 = nItem1 + GetItemStackSize(oItem);
        else if(sTag=="craft_2_lgu")
            nItem2 = nItem2 + GetItemStackSize(oItem);
        else if(sTag=="craft_2_lra")
            nItem3 = nItem3 + GetItemStackSize(oItem);
        oItem = GetNextItemInInventory(oPC);
    }
    if(nItem1>=6&&nItem2>=6&&nItem3>=2&&nGold>=2000){
        return TRUE;
    }
    return FALSE;
}
