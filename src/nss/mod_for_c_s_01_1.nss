int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetFirstItemInInventory(oPC);
    string sTag;
    int nOssRat=0,nCuoZom=0,nFasMum=0,nGold;
    nGold = GetGold(oPC);
    while(oItem!=OBJECT_INVALID){
        sTag = GetTag(oItem);
        if(sTag=="craft_1_zom")
            nCuoZom = nCuoZom + GetItemStackSize(oItem);
        else if(sTag=="craft_1_rat_bos3")
            nOssRat = nOssRat + GetItemStackSize(oItem);
        else if(sTag=="craft_1_mum")
            nFasMum = nFasMum + GetItemStackSize(oItem);
        oItem = GetNextItemInInventory(oPC);
    }
    if(nCuoZom>=2&&nFasMum>=2&&nOssRat>=6&&nGold>=2000){
        return TRUE;
    }
    return FALSE;
}
