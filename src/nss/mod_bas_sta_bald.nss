int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetItemPossessedBy(oPC,"mod_simb_bald") != OBJECT_INVALID)
        return TRUE;
    return FALSE;
}
