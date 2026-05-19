int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetItemPossessedBy(oPC,"mod_simb_loc") != OBJECT_INVALID)
        return TRUE;
    return FALSE;
}
