int StartingConditional()
{
    object oPC = GetPCSpeaker();
    string sRace = GetSubRace(oPC);
    if(sRace == "Duergar")
        return TRUE;
    else
        return FALSE;
}
