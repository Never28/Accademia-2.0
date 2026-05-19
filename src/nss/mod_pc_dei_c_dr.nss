int StartingConditional()
{
    object oPC = GetPCSpeaker();
    string sRace = GetSubRace(oPC);
    if(sRace == "Drow")
        return TRUE;
    else
        return FALSE;
}
