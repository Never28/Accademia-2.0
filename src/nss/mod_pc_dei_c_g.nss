int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nAlign = GetAlignmentGoodEvil(oPC);
    if(nAlign != ALIGNMENT_EVIL)
        return TRUE;
    else
        return FALSE;
}
