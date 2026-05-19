int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetItemPossessedBy(oPC,"mod_simb_dagge") != OBJECT_INVALID)
        return TRUE;
    return FALSE;
}
