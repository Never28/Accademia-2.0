int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nRace = GetRacialType(oPC);
    if(nRace == RACIAL_TYPE_ELF||nRace == RACIAL_TYPE_HALFELF)
        return TRUE;
    else
        return FALSE;
}
