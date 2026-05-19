int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetFirstItemInInventory(oPC);
    string sTag;
    int nItem1=0,nItem2=0,nGold;
    nGold = GetGold(oPC);
    while(oItem!=OBJECT_INVALID){
        sTag = GetTag(oItem);
        if(sTag=="craft_27_oba")
            nItem1 = nItem1 + GetItemStackSize(oItem);
        else if(sTag=="craft_26_bos1")
            nItem2 = nItem2 + GetItemStackSize(oItem);
        oItem = GetNextItemInInventory(oPC);
    }
    if(nItem1>=4&&nItem2>=1&&nGold>=8000){
        return TRUE;
    }
    return FALSE;
}
