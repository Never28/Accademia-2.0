/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 15-07-2009
*/

// Rilivellare Conversazione

int HitDiceByXP(object oPC2)
{
   int nHD=GetXP(oPC2);
   if (nHD < 1000) return 1;
   else if (nHD < 3000) return 2;
   else if (nHD < 6000) return 3;
   else if (nHD < 10000) return 4;
   else if (nHD < 15000) return 5;
   else if (nHD < 21000) return 6;
   else if (nHD < 28000) return 7;
   else if (nHD < 36000) return 8;
   else if (nHD < 45000) return 9;
   else if (nHD < 55000) return 10;
   else if (nHD < 66000) return 11;
   else if (nHD < 78000) return 12;
   else if (nHD < 91000) return 13;
   else if (nHD < 105000) return 14;
   else if (nHD < 120000) return 15;
   else if (nHD < 136000) return 16;
   else if (nHD < 153000) return 17;
   else if (nHD < 171000) return 18;
   else if (nHD < 190000) return 19;
   else if (nHD < 210000) return 20;
   else if (nHD < 231000) return 21;
   else if (nHD < 253000) return 22;
   else if (nHD < 276000) return 23;
   else if (nHD < 300000) return 24;
   else if (nHD < 325000) return 25;
   else if (nHD < 351000) return 26;
   else if (nHD < 378000) return 27;
   else if (nHD < 406000) return 28;
   else if (nHD < 435000) return 29;
   else if (nHD < 465000) return 30;
   else if (nHD < 496000) return 31;
   else if (nHD < 528000) return 32;
   else if (nHD < 561000) return 33;
   else if (nHD < 595000) return 34;
   else if (nHD < 630000) return 35;
   else if (nHD < 666000) return 36;
   else if (nHD < 703000) return 37;
   else if (nHD < 741000) return 38;
   else if (nHD < 780000) return 39;
   else return 40;
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
void main()
{
    object oPC=GetLastSpeaker();
    int iPattern=GetListenPatternNumber();
    int nDDR = GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE,oPC);
    int nLevel = HitDiceByXP(oPC);
    int nXP = GetXP(oPC);
    SpeakString("Per Rilivellare digita 'Livello X' nella chat dove X  il livello che desideri ritornare.");
    int NewXP;
    if(nLevel<=iPattern){
        SpeakString("Non puoi chiedere di Rilivellare un Livello maggiore del tuo attuale.");
    }
    else{
        if(GetItemPossessedBy(oPC,"mod_bas_tele")!=OBJECT_INVALID){
            string sTotalePC = GetLocalString(oPC,"gilda");
            string sGildaPC = GetSubString(sTotalePC,0,3);
            if(sGildaPC=="xxx"){
                if(nDDR<=1&&GetItemPossessedBy(oPC,"deletemeplease")==OBJECT_INVALID){
                    switch(iPattern){
                        case 0:
                            break;
                        case 1:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,0,nXP);
                            break;
                        case 2:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,1000,nXP);
                            break;
                        case 3:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,3000,nXP);
                            break;
                        case 4:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,6000,nXP);
                            break;
                        case 5:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,10000,nXP);
                            break;
                        case 6:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,15000,nXP);
                            break;
                        case 7:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,21000,nXP);
                            break;
                        case 8:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,28000,nXP);
                            break;
                        case 9:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,36000,nXP);
                            break;
                        case 10:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,45000,nXP);
                            break;
                        case 11:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,55000,nXP);
                            break;
                        case 12:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,66000,nXP);
                            break;
                        case 13:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,78000,nXP);
                            break;
                        case 14:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,91000,nXP);
                            break;
                        case 15:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,105000,nXP);
                            break;
                        case 16:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,120000,nXP);
                            break;
                        case 17:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,136000,nXP);
                            break;
                        case 18:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,153000,nXP);
                            break;
                        case 19:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,171000,nXP);
                            break;
                        case 20:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,190000,nXP);
                            break;
                        case 21:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,210000,nXP);
                            break;
                        case 22:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,231000,nXP);
                            break;
                        case 23:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,253000,nXP);
                            break;
                        case 24:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,276000,nXP);
                            break;
                        case 25:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,300000,nXP);
                            break;
                        case 26:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,325000,nXP);
                            break;
                        case 27:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,351000,nXP);
                            break;
                        case 28:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,378000,nXP);
                            break;
                        case 29:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,406000,nXP);
                            break;
                        case 30:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,435000,nXP);
                            break;
                        case 31:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,465000,nXP);
                            break;
                        case 32:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,496000,nXP);
                            break;
                        case 33:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,528000,nXP);
                            break;
                        case 34:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,561000,nXP);
                            break;
                        case 35:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,595000,nXP);
                            break;
                        case 36:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,630000,nXP);
                            break;
                        case 37:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,666000,nXP);
                            break;
                        case 38:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,703000,nXP);
                            break;
                        case 39:
                            DisarmoPC(oPC);
                            RelevelXP(oPC,741000,nXP);
                            break;
                    }
                }
                else{
                    SpeakString("Non puoi chiedere di Rilivellare, sei Discepolo del Drago Rosso di Livello Superiore al 1, Chiedi a un DM.");
                }
            }
            else{
                SpeakString("Non puoi chiedere di Rilivellare quando sei in una gilda, usa il Rilivellatore della tua Gilda");
            }
        }
        else{
            SpeakString("Non puoi chiedere di Rilivellare un personaggio di Trama");
        }
    }
}
