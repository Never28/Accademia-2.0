int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetItemPossessedBy(oPC,"vil_kho") != OBJECT_INVALID)
        return TRUE;
    return FALSE;
}
