int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nRace = GetRacialType(oPC);
    if(nRace == RACIAL_TYPE_GNOME)
        return TRUE;
    else
        return FALSE;
}
