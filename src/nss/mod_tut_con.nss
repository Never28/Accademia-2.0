int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetItemPossessedBy(oPC,"tut_arma")!=OBJECT_INVALID)
        return FALSE;
    return TRUE;
}
