int StartingConditional()
{
    object oPC = GetPCSpeaker();
    string sRace = GetSubRace(oPC);
    if(sRace == "Svirfneblin")
        return TRUE;
    else
        return FALSE;
}
