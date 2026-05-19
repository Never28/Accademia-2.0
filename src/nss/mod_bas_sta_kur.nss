int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetItemPossessedBy(oPC,"vil_kur") != OBJECT_INVALID)
        return TRUE;
    return FALSE;
}
