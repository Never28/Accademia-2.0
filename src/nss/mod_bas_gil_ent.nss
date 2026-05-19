int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetItemPossessedBy(oPC,"mod_bas_teke")==OBJECT_INVALID){
        string sGilda = GetLocalString(OBJECT_SELF,"gilda");
        string sTotalePC = GetLocalString(oPC,"gilda");
        string sGildaPC = GetSubString(sTotalePC,0,3);

        int nArc = GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER,oPC);
        int nAss = GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC);
        int nBar = GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC);
        int nBad = GetLevelByClass(CLASS_TYPE_BARD,oPC);
        int nBlk = GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC);
        int nCle = GetLevelByClass(CLASS_TYPE_CLERIC,oPC);
        int nDiv = GetLevelByClass(CLASS_TYPE_DIVINE_CHAMPION,oPC);
        int nDdr = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oPC);
        int nDru = GetLevelByClass(CLASS_TYPE_DRUID,oPC);
        int nDwa = GetLevelByClass(CLASS_TYPE_DWARVEN_DEFENDER,oPC);
        int nFig = GetLevelByClass(CLASS_TYPE_FIGHTER,oPC);
        int nHar = GetLevelByClass(CLASS_TYPE_HARPER,oPC);
        int nMon = GetLevelByClass(CLASS_TYPE_MONK,oPC);
        int nPal = GetLevelByClass(CLASS_TYPE_PALADIN,oPC);
        int nPam = GetLevelByClass(CLASS_TYPE_PALE_MASTER,oPC);
        int nPur = GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,oPC);
        int nRan = GetLevelByClass(CLASS_TYPE_RANGER,oPC);
        int nRog = GetLevelByClass(CLASS_TYPE_ROGUE,oPC);
        int nSha = GetLevelByClass(CLASS_TYPE_SHADOWDANCER,oPC);
        int nShi = GetLevelByClass(CLASS_TYPE_SHIFTER,oPC);
        int nSor = GetLevelByClass(CLASS_TYPE_SORCERER,oPC);
        int nWea = GetLevelByClass(CLASS_TYPE_WEAPON_MASTER,oPC);
        int nWiz = GetLevelByClass(CLASS_TYPE_WIZARD,oPC);

        if(GetAlignmentGoodEvil(oPC)==ALIGNMENT_NEUTRAL||GetAlignmentGoodEvil(oPC)==ALIGNMENT_GOOD){
            if(((nDru >= 10 && GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID) || (nShi >= 10 && GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID) || nRan >= 10) && sGilda == "gb1" && sGildaPC != "gb1")
                return TRUE;
            else if((nBad >= 10 || nHar >= 5 || nArc >= 10) && sGilda == "gb2" && sGildaPC != "gb2")
                return TRUE;
            else if((nPal >= 10 || nDiv >= 10 || nDwa >= 10) && sGilda == "gb3" && sGildaPC != "gb3")
                return TRUE;
            else if(nCle >= 10 && sGilda == "gb4" && sGildaPC != "gb4")
                return TRUE;
            else if(nMon >= 10 && sGilda == "gb5" && sGildaPC != "gb5")
                return TRUE;
            else if((nDdr >= 10 && (GetItemPossessedBy(oPC,"mod_clas_drarg")!=OBJECT_INVALID ||
            GetItemPossessedBy(oPC,"mod_clas_drram")!=OBJECT_INVALID ||
            GetItemPossessedBy(oPC,"mod_clas_drott")!=OBJECT_INVALID ||
            GetItemPossessedBy(oPC,"mod_clas_droro")!=OBJECT_INVALID ||
            GetItemPossessedBy(oPC,"mod_clas_drbro")!=OBJECT_INVALID )) && sGilda == "gb6" && sGildaPC != "gb6")
                return TRUE;
            else if((nWiz >= 10 || nSor >= 10) && sGilda == "gb7" && sGildaPC != "gb7")
                return TRUE;
            else if((nRog >= 10 || nSha >= 10) && sGilda == "gb8" && sGildaPC != "gb8")
                return TRUE;
            else if((nFig >= 10 || nPur >= 5 || nBar >= 10 || nWea >= 10) && sGilda == "gb9" && sGildaPC != "gb9")
                return TRUE;
        }
        if(GetAlignmentGoodEvil(oPC)==ALIGNMENT_NEUTRAL||GetAlignmentGoodEvil(oPC)==ALIGNMENT_EVIL){
            if(((nDru >= 10 && GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID) || (nShi >= 10 && GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID) || nRan >= 10) && sGilda == "gm1" && sGildaPC != "gm1")
                return TRUE;
            else if((nBad >= 10 || nWea >= 10 || nArc >= 10) && sGilda == "gm2" && sGildaPC != "gm2")
                return TRUE;
            else if((nFig >= 10 || nBlk >= 10 || nDwa >= 10) && sGilda == "gm3" && sGildaPC != "gm3")
                return TRUE;
            else if(nCle >= 10 && sGilda == "gm4" && sGildaPC != "gm4")
                return TRUE;
            else if(nMon >= 10 && sGilda == "gm5" && sGildaPC != "gm5")
                return TRUE;
            else if((nDdr >= 10 && (GetItemPossessedBy(oPC,"mod_clas_drbla")!=OBJECT_INVALID ||
            GetItemPossessedBy(oPC,"mod_clas_drred")!=OBJECT_INVALID ||
            GetItemPossessedBy(oPC,"mod_clas_drgre")!=OBJECT_INVALID ||
            GetItemPossessedBy(oPC,"mod_clas_drblu")!=OBJECT_INVALID ||
            GetItemPossessedBy(oPC,"mod_clas_drwhi")!=OBJECT_INVALID )) && sGilda == "gm6" && sGildaPC != "gm6")
                return TRUE;
            else if((nWiz >= 10 || nSor >= 10) && sGilda == "gm7" && sGildaPC != "gm7")
                return TRUE;
            else if((nRog >= 10 || nSha >= 10 || nAss >= 10) && sGilda == "gm8" && sGildaPC != "gm8")
                return TRUE;
            else if((nPam >= 10 || nBar >= 10) && sGilda == "gm9" && sGildaPC != "gm9")
                return TRUE;
        }
    }
    return FALSE;
}
