int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetItemPossessedBy(oPC,"vil_aha") != OBJECT_INVALID)
        return TRUE;
    return FALSE;
}
