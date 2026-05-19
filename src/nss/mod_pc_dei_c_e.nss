int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nAlign = GetAlignmentGoodEvil(oPC);
    if(nAlign != ALIGNMENT_GOOD)
        return TRUE;
    else
        return FALSE;
}
