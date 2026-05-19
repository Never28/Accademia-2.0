int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetItemPossessedBy(oPC,"vil_ara") != OBJECT_INVALID)
        return TRUE;
    return FALSE;
}
