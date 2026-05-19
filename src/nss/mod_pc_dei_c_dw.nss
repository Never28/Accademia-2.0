int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nRace = GetRacialType(oPC);
    if(nRace == RACIAL_TYPE_DWARF)
        return TRUE;
    else
        return FALSE;
}
