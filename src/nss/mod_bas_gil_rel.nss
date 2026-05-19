int HitDiceByXP(object oPC2)
{
   int nHD=GetXP(oPC2);
   if (nHD < 3000) return 0;
   else if (nHD < 6000) return 1000;
   else if (nHD < 10000) return 3000;
   else if (nHD < 15000) return 6000;
   else if (nHD < 21000) return 10000;
   else if (nHD < 28000) return 15000;
   else if (nHD < 36000) return 21000;
   else if (nHD < 45000) return 28000;
   else if (nHD < 55000) return 36000;
   else if (nHD < 66000) return 45000;
   else if (nHD < 78000) return 55000;
   else if (nHD < 91000) return 66000;
   else if (nHD < 105000) return 78000;
   else if (nHD < 120000) return 91000;
   else if (nHD < 136000) return 105000;
   else if (nHD < 153000) return 120000;
   else if (nHD < 171000) return 136000;
   else if (nHD < 190000) return 153000;
   else if (nHD < 210000) return 171000;
   else if (nHD < 231000) return 190000;
   else if (nHD < 253000) return 210000;
   else if (nHD < 276000) return 231000;
   else if (nHD < 300000) return 253000;
   else if (nHD < 325000) return 276000;
   else if (nHD < 351000) return 300000;
   else if (nHD < 378000) return 325000;
   else if (nHD < 406000) return 351000;
   else if (nHD < 435000) return 378000;
   else if (nHD < 465000) return 406000;
   else if (nHD < 496000) return 435000;
   else if (nHD < 528000) return 465000;
   else if (nHD < 561000) return 496000;
   else if (nHD < 595000) return 528000;
   else if (nHD < 630000) return 561000;
   else if (nHD < 666000) return 595000;
   else if (nHD < 703000) return 630000;
   else if (nHD < 741000) return 666000;
   else if (nHD < 780000) return 741000;
   else return 780000;
}

void RelevelXP(object oPC,int OldXP,int XP)
{
    int NewXP = XP-OldXP;
    DelayCommand(0.0,SetXP(oPC,OldXP));
    DelayCommand(0.5,GiveXPToCreature(oPC,NewXP));
    effect eLoop=GetFirstEffect(oPC);
    while (GetIsEffectValid(eLoop)){
        RemoveEffect(oPC, eLoop);
        eLoop=GetNextEffect(oPC);
    }
    ExecuteScript("mod_clas_poly_de",oPC);
    object oSkinOld = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,oPC);
    if(oSkinOld!=OBJECT_INVALID)
        DestroyObject(oSkinOld,0.0);
    DelayCommand(1.0,ExecuteScript("mod_bas_relev_cl",oPC));
    DelayCommand(1.0,ExecuteScript("mod_bas_relev_ch",oPC));
}

void DisarmoPC(object oPC){
    object oItem1 = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
    AssignCommand(oPC,ActionUnequipItem(oItem1));
    object oItem2 = GetItemInSlot(INVENTORY_SLOT_BELT,oPC);
    AssignCommand(oPC,ActionUnequipItem(oItem2));
    object oItem3 = GetItemInSlot(INVENTORY_SLOT_BOLTS,oPC);
    AssignCommand(oPC,ActionUnequipItem(oItem3));
    object oItem4 = GetItemInSlot(INVENTORY_SLOT_BULLETS,oPC);
    AssignCommand(oPC,ActionUnequipItem(oItem4));
    object oItem5 = GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC);
    AssignCommand(oPC,ActionUnequipItem(oItem5));
    object oItem6 = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
    AssignCommand(oPC,ActionUnequipItem(oItem6));
    object oItem7 = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
    AssignCommand(oPC,ActionUnequipItem(oItem7));
    object oItem8 = GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC);
    AssignCommand(oPC,ActionUnequipItem(oItem8));
    object oItem9 = GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC);
    AssignCommand(oPC,ActionUnequipItem(oItem9));
    object oItem10 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
    AssignCommand(oPC,ActionUnequipItem(oItem10));
    object oItem11 = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC);
    AssignCommand(oPC,ActionUnequipItem(oItem11));
    object oItem12 = GetItemInSlot(INVENTORY_SLOT_NECK,oPC);
    AssignCommand(oPC,ActionUnequipItem(oItem12));
    object oItem13 = GetItemInSlot(INVENTORY_SLOT_ARROWS,oPC);
    AssignCommand(oPC,ActionUnequipItem(oItem13));
    object oItem14 = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    AssignCommand(oPC,ActionUnequipItem(oItem14));
}

void main()
{
    object oPC = GetLastUsedBy();

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
    int nMXP = HitDiceByXP(oPC);
    int nXP = GetXP(oPC);

        if((nDru >= 11 || nShi >= 11 || nRan >= 11) && sGilda == "gb1" && sGildaPC != "gb1"){
            DisarmoPC(oPC);
            RelevelXP(oPC,nMXP,nXP);
        }
        else if((nBad >= 11 || nArc >= 11) && sGilda == "gb2" && sGildaPC != "gb2"){
            DisarmoPC(oPC);
            RelevelXP(oPC,nMXP,nXP);
        }
        else if((nPal >= 11 || nDiv >= 11 || nDwa >= 11) && sGilda == "gb3" && sGildaPC != "gb3"){
            DisarmoPC(oPC);
            RelevelXP(oPC,nMXP,nXP);
        }
        else if(nCle >= 11 && sGilda == "gb4" && sGildaPC != "gb4"){
            DisarmoPC(oPC);
            RelevelXP(oPC,nMXP,nXP);
        }
        else if(nMon >= 11 && sGilda == "gb5" && sGildaPC != "gb5"){
            DisarmoPC(oPC);
            RelevelXP(oPC,nMXP,nXP);
        }
        else if(nDdr >= 11 && sGilda == "gb6" && sGildaPC != "gb6"){
            DisarmoPC(oPC);
            RelevelXP(oPC,nMXP,nXP);
        }
        else if((nWiz >= 11 || nSor >= 11) && sGilda == "gb7" && sGildaPC != "gb7"){
            DisarmoPC(oPC);
            RelevelXP(oPC,nMXP,nXP);
        }
        else if((nRog >= 11 || nSha >= 11) && sGilda == "gb8" && sGildaPC != "gb8"){
            DisarmoPC(oPC);
            RelevelXP(oPC,nMXP,nXP);
        }
        else if((nFig >= 11 || nBar >= 11 || nWea >= 11) && sGilda == "gb9" && sGildaPC != "gb9"){
            DisarmoPC(oPC);
            RelevelXP(oPC,nMXP,nXP);
        }
        else if((nDru >= 11 || nShi >= 11 || nRan >= 11) && sGilda == "gm1" && sGildaPC != "gm1"){
            DisarmoPC(oPC);
            RelevelXP(oPC,nMXP,nXP);
        }
        else if((nBad >= 11 || nWea >= 11 || nArc >= 11) && sGilda == "gm2" && sGildaPC != "gm2"){
            DisarmoPC(oPC);
            RelevelXP(oPC,nMXP,nXP);
        }
        else if((nFig >= 11 || nBlk >= 11 || nDwa >= 11) && sGilda == "gm3" && sGildaPC != "gm3"){
            DisarmoPC(oPC);
            RelevelXP(oPC,nMXP,nXP);
        }
        else if(nCle >= 11 && sGilda == "gm4" && sGildaPC != "gm4"){
            DisarmoPC(oPC);
            RelevelXP(oPC,nMXP,nXP);
        }
        else if(nMon >= 11 && sGilda == "gm5" && sGildaPC != "gm5"){
            DisarmoPC(oPC);
            RelevelXP(oPC,nMXP,nXP);
        }
        else if(nDdr >= 11 && sGilda == "gm6" && sGildaPC != "gm6"){
            DisarmoPC(oPC);
            RelevelXP(oPC,nMXP,nXP);
        }
        else if((nWiz >= 11 || nSor >= 11) && sGilda == "gm7" && sGildaPC != "gm7"){
            DisarmoPC(oPC);
            RelevelXP(oPC,nMXP,nXP);
        }
        else if((nRog >= 11 || nSha >= 11 || nAss >= 11) && sGilda == "gm8" && sGildaPC != "gm8"){
            DisarmoPC(oPC);
            RelevelXP(oPC,nMXP,nXP);
        }
        else if((nPam >= 11 || nBar >= 11) && sGilda == "gm9" && sGildaPC != "gm9"){
            DisarmoPC(oPC);
            RelevelXP(oPC,nMXP,nXP);
        }
        else{
            SendMessageToPC(oPC,"Non puoi rilivellare a questo livello, perderesti la gilda di cui fai parte");
        }
}
