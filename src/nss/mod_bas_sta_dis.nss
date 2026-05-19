int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetItemPossessedBy(oPC,"vil_dis") != OBJECT_INVALID)
        return TRUE;
    return FALSE;
}
