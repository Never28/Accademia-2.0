int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetFirstItemInInventory(oPC);
    string sTag;
    int nPelAni=0,nCuoZom=0,nOssMuc=0,nOssGob=0,nGold;
    nGold = GetGold(oPC);
    while(oItem!=OBJECT_INVALID){
        sTag = GetTag(oItem);
        if(sTag=="craft_5_gos")
            nOssMuc = nOssMuc + GetItemStackSize(oItem);
        else if(sTag=="craft_5_orm")
            nPelAni = nPelAni + GetItemStackSize(oItem);
        else if(sTag=="craft_5_goc")
            nCuoZom = nCuoZom + GetItemStackSize(oItem);
        else if(sTag=="craft_5_orv")
            nOssGob = nOssGob + GetItemStackSize(oItem);
        oItem = GetNextItemInInventory(oPC);
    }
    if(nOssMuc>=3&&nPelAni>=3&&nCuoZom>=3&&nOssGob>=3&&nGold>=2000){
        return TRUE;
    }
    return FALSE;
}
