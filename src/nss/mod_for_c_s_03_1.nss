int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetFirstItemInInventory(oPC);
    string sTag;
    int nItem1=0,nItem2=0,nGold;
    nGold = GetGold(oPC);
    while(oItem!=OBJECT_INVALID){
        sTag = GetTag(oItem);
        if(sTag=="craft_3_bos3")
            nItem1 = nItem1 + GetItemStackSize(oItem);
        else if(sTag=="craft_2_mor")
            nItem2 = nItem2 + GetItemStackSize(oItem);
        oItem = GetNextItemInInventory(oPC);
    }
    if(nItem1>=6&&nItem2>=6&&nGold>=2000){
        return TRUE;
    }
    return FALSE;
}
