int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetItemPossessedBy(oPC,"vil_kha") != OBJECT_INVALID)
        return TRUE;
    return FALSE;
}
