int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetItemPossessedBy(oPC,"mod_bas_teke")==OBJECT_INVALID){
        string sGilda = GetLocalString(OBJECT_SELF,"gilda");
        string sTotalePC = GetLocalString(oPC,"gilda");
        string sGildaPC = GetSubString(sTotalePC,0,3);
        if(sGilda == sGildaPC)
            return TRUE;
    }
    return FALSE;
}
