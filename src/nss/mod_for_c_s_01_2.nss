int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetFirstItemInInventory(oPC);
    string sTag;
    int nDenRat=0,nCiuRat=0,nPelAni=0,nGold;
    nGold = GetGold(oPC);
    while(oItem!=OBJECT_INVALID){
        sTag = GetTag(oItem);
        if(sTag=="craft_1_g_m")
            nPelAni = nPelAni + GetItemStackSize(oItem);
        else if(sTag=="craft_1_rat")
            nCiuRat = nCiuRat + GetItemStackSize(oItem);
        else if(sTag=="craft_1_rat_bos3")
            nDenRat = nDenRat + GetItemStackSize(oItem);
        oItem = GetNextItemInInventory(oPC);
    }
    if(nPelAni>=4&&nCiuRat>=4&&nDenRat>=1&&nGold>=2000){
        return TRUE;
    }
    return FALSE;
}
