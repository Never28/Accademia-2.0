// * Is the PCSpeaker
// * the Henchman's master?
int StartingConditional()
{
    int iResult;
        int nLevel;
        string sTag = GetTag(OBJECT_SELF);
        if(sTag == "png_xzar")
            nLevel = 1;
        else if(sTag == "png_imoen")
            nLevel = 1;
        else if(sTag == "png_montaron")
            nLevel = 1;
        else if(sTag == "png_xan")
            nLevel = 11;
        else if(sTag == "png_minsc")
            nLevel = 11;
        else if(sTag == "png_branwen")
            nLevel = 11;
        else if(sTag == "png_kagain")
            nLevel = 16;
        else if(sTag == "png_sharteel")
            nLevel = 16;
        else if(sTag == "png_garrick")
            nLevel = 16;
        else if(sTag == "png_jaheira")
            nLevel = 21;
        else if(sTag == "png_khalid")
            nLevel = 21;
        else if(sTag == "png_kivan")
            nLevel = 21;
        else if(sTag == "png_alora")
            nLevel = 26;
        else if(sTag == "png_quayle")
            nLevel = 26;
        else if(sTag == "png_ayantis")
            nLevel = 26;
        else if(sTag == "png_eldoth")
            nLevel = 31;
        else if(sTag == "png_tiax")
            nLevel = 31;
        else if(sTag == "png_yeslick")
            nLevel = 31;
    if(GetHenchman(GetPCSpeaker())!=OBJECT_INVALID && GetHitDice(GetPCSpeaker())>=nLevel)
        return TRUE;
    return FALSE;
}
