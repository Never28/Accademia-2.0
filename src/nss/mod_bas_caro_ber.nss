int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nMoney = GetGold(oPC);
    if(nMoney>=5000)
        return TRUE;
    return FALSE;
}
