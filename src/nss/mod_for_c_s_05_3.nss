int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetFirstItemInInventory(oPC);
    string sTag;
    int nPelAni=0,nCuoZom=0,nOssMuc=0,nGold;
    nGold = GetGold(oPC);
    while(oItem!=OBJECT_INVALID){
        sTag = GetTag(oItem);
        if(sTag=="craft_5_orm")
            nOssMuc = nOssMuc + GetItemStackSize(oItem);
        else if(sTag=="craft_5_gos")
            nPelAni = nPelAni + GetItemStackSize(oItem);
        else if(sTag=="craft_5_goa")
            nCuoZom = nCuoZom + GetItemStackSize(oItem);
        oItem = GetNextItemInInventory(oPC);
    }
    if(nOssMuc>=6&&nPelAni>=6&&nCuoZom>=4&&nGold>=2000){
        return TRUE;
    }
    return FALSE;
}
