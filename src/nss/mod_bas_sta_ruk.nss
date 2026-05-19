int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetItemPossessedBy(oPC,"vil_ruk") != OBJECT_INVALID)
        return TRUE;
    return FALSE;
}
