int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetItemPossessedBy(oPC,"vil_dro") != OBJECT_INVALID)
        return TRUE;
    return FALSE;
}
