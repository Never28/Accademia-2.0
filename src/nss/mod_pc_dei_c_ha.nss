int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nRace = GetRacialType(oPC);
    if(nRace == RACIAL_TYPE_HALFLING)
        return TRUE;
    else
        return FALSE;
}
