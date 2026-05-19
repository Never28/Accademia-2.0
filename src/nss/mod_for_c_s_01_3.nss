int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetFirstItemInInventory(oPC);
    string sTag;
    int nManRat=0,nSpiAll=0,nSpiOmb=0,nGold;
    nGold = GetGold(oPC);
    while(oItem!=OBJECT_INVALID){
        sTag = GetTag(oItem);
        if(sTag=="craft_1_omb")
            nSpiOmb = nSpiOmb + GetItemStackSize(oItem);
        else if(sTag=="craft_1_rat_bos2")
            nManRat = nManRat + GetItemStackSize(oItem);
        else if(sTag=="craft_1_all")
            nSpiAll = nSpiAll + GetItemStackSize(oItem);
        oItem = GetNextItemInInventory(oPC);
    }
    if(nSpiOmb>=2&&nSpiAll>=2&&nManRat>=4&&nGold>=2000){
        return TRUE;
    }
    return FALSE;
}
