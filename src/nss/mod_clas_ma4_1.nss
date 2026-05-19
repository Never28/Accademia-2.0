/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 18-06-2009
*/

// Funzione per Clonazione.

void SafeDestroyObject(object oObject, float fDelay)
{
    SetIsDestroyable(TRUE);
    if(GetPlotFlag(oObject)) { DelayCommand(0.0,SetPlotFlag(oObject, FALSE)); }
    if(GetImmortal(oObject)) { DelayCommand(0.0,SetImmortal(oObject, FALSE)); }
    if(!GetDroppableFlag(oObject)) { DelayCommand(0.0,SetDroppableFlag(oObject, TRUE)); }
    DestroyObject(oObject, fDelay);
}

void main()
{
    object oPC = OBJECT_SELF;
    object oItem1,oItem2,oItem3,oItem4,oItem5,oItem6,oItem7,oItem8,oItem9,oItem10,oItem11;
    object ocItem1,ocItem2,ocItem3,ocItem4,ocItem5,ocItem6,ocItem7,ocItem8,ocItem9,ocItem10,ocItem11;
    object oClone;
    effect eClone,eVis;
    string sName;
    int nRFoot,nLFoot,nRShin,nLShin,nRThing,nLThing,nPelvis,nTorso;
    int nBelt,nNeck,nRForearm,nLForearm,nRBicep,nLBicep,nRShoulder;
    int nLShoulder,nRHand,nLHand,nHead;
    int nPhenotype;
    int nRace;
    location loPC,lTarget;
    loPC = GetItemActivatedTargetLocation();
    effect eVis2 = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2);
    ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eVis2, loPC);
    float fDelay;
    int nGender = GetGender(oPC);
    if(nGender==GENDER_MALE){
        oClone = CreateObject(OBJECT_TYPE_CREATURE,"mob_clone",loPC,FALSE);
    }
    else{
        oClone = CreateObject(OBJECT_TYPE_CREATURE,"mob_clone_f",loPC,FALSE);
    }
                sName = GetName(oPC);
                SetName(oClone,sName);
                nRace = GetAppearanceType(oPC);
                nPhenotype = GetPhenoType(oPC);
                SetCreatureAppearanceType(oClone,nRace);
                SetPhenoType(nPhenotype,oClone);

                nRFoot = GetCreatureBodyPart(CREATURE_PART_RIGHT_FOOT,oPC);
                nLFoot = GetCreatureBodyPart(CREATURE_PART_LEFT_FOOT,oPC);
                nRShin = GetCreatureBodyPart(CREATURE_PART_RIGHT_SHIN,oPC);
                nLShin = GetCreatureBodyPart(CREATURE_PART_LEFT_SHIN,oPC);
                nRThing = GetCreatureBodyPart(CREATURE_PART_RIGHT_THIGH,oPC);
                nLThing = GetCreatureBodyPart(CREATURE_PART_LEFT_THIGH,oPC);
                nPelvis = GetCreatureBodyPart(CREATURE_PART_PELVIS,oPC);
                nTorso = GetCreatureBodyPart(CREATURE_PART_TORSO,oPC);
                nBelt = GetCreatureBodyPart(CREATURE_PART_BELT,oPC);
                nNeck = GetCreatureBodyPart(CREATURE_PART_NECK,oPC);
                nRForearm = GetCreatureBodyPart(CREATURE_PART_RIGHT_FOREARM,oPC);
                nLForearm = GetCreatureBodyPart(CREATURE_PART_LEFT_FOREARM,oPC);
                nRBicep = GetCreatureBodyPart(CREATURE_PART_RIGHT_BICEP,oPC);
                nLBicep = GetCreatureBodyPart(CREATURE_PART_LEFT_BICEP,oPC);
                nRShoulder = GetCreatureBodyPart(CREATURE_PART_RIGHT_SHOULDER,oPC);
                nLShoulder = GetCreatureBodyPart(CREATURE_PART_LEFT_SHOULDER,oPC);
                nRHand = GetCreatureBodyPart(CREATURE_PART_RIGHT_HAND,oPC);
                nLHand = GetCreatureBodyPart(CREATURE_PART_LEFT_HAND,oPC);
                nHead = GetCreatureBodyPart(CREATURE_PART_HEAD,oPC);
                SetCreatureBodyPart(CREATURE_PART_RIGHT_FOOT,nRFoot,oClone);
                SetCreatureBodyPart(CREATURE_PART_LEFT_FOOT,nLFoot,oClone);
                SetCreatureBodyPart(CREATURE_PART_RIGHT_SHIN,nRShin,oClone);
                SetCreatureBodyPart(CREATURE_PART_LEFT_SHIN,nLShin,oClone);
                SetCreatureBodyPart(CREATURE_PART_RIGHT_THIGH,nRThing,oClone);
                SetCreatureBodyPart(CREATURE_PART_LEFT_THIGH,nLThing,oClone);
                SetCreatureBodyPart(CREATURE_PART_PELVIS,nPelvis,oClone);
                SetCreatureBodyPart(CREATURE_PART_TORSO,nTorso,oClone);
                SetCreatureBodyPart(CREATURE_PART_BELT,nBelt,oClone);
                SetCreatureBodyPart(CREATURE_PART_NECK,nNeck,oClone);
                SetCreatureBodyPart(CREATURE_PART_RIGHT_FOREARM,nRForearm,oClone);
                SetCreatureBodyPart(CREATURE_PART_LEFT_FOREARM,nLForearm,oClone);
                SetCreatureBodyPart(CREATURE_PART_RIGHT_BICEP,nRBicep,oClone);
                SetCreatureBodyPart(CREATURE_PART_LEFT_BICEP,nLBicep,oClone);
                SetCreatureBodyPart(CREATURE_PART_RIGHT_SHOULDER,nRShoulder,oClone);
                SetCreatureBodyPart(CREATURE_PART_LEFT_SHOULDER,nLShoulder,oClone);
                SetCreatureBodyPart(CREATURE_PART_RIGHT_HAND,nRHand,oClone);
                SetCreatureBodyPart(CREATURE_PART_LEFT_HAND,nLHand,oClone);
                SetCreatureBodyPart(CREATURE_PART_HEAD,nHead,oClone);
                string sName1 = GetName(oPC)+"2";
                object oModule = GetModule();
                oItem1 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
                oItem2 = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
                oItem3 = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
                oItem4 = GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC);
                oItem5 = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
                oItem6 = GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC);
                oItem7 = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC);
                oItem8 = GetItemInSlot(INVENTORY_SLOT_BELT,oPC);
                oItem9 = GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC);
                oItem10 = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
                oItem11 = GetItemInSlot(INVENTORY_SLOT_NECK,oPC);
                ocItem1 = CopyItem(oItem1,oClone);
                ocItem2 = CopyItem(oItem2,oClone);
                ocItem3 = CopyItem(oItem3,oClone);
                ocItem4 = CopyItem(oItem4,oClone);
                ocItem5 = CopyItem(oItem5,oClone);
                ocItem6 = CopyItem(oItem6,oClone);
                ocItem7 = CopyItem(oItem7,oClone);
                ocItem8 = CopyItem(oItem8,oClone);
                ocItem9 = CopyItem(oItem9,oClone);
                ocItem10 = CopyItem(oItem10,oClone);
                ocItem11 = CopyItem(oItem11,oClone);
                DelayCommand(1.0,AssignCommand(oClone,ActionEquipItem(ocItem1,INVENTORY_SLOT_LEFTHAND)));
                DelayCommand(1.0,AssignCommand(oClone,ActionEquipItem(ocItem2,INVENTORY_SLOT_RIGHTHAND)));
                DelayCommand(1.0,AssignCommand(oClone,ActionEquipItem(ocItem3,INVENTORY_SLOT_HEAD)));
                DelayCommand(1.0,AssignCommand(oClone,ActionEquipItem(ocItem4,INVENTORY_SLOT_CLOAK)));
                DelayCommand(1.0,AssignCommand(oClone,ActionEquipItem(ocItem5,INVENTORY_SLOT_CHEST)));
                DelayCommand(1.0,AssignCommand(oClone,ActionEquipItem(ocItem6,INVENTORY_SLOT_LEFTRING)));
                DelayCommand(1.0,AssignCommand(oClone,ActionEquipItem(ocItem7,INVENTORY_SLOT_RIGHTRING)));
                DelayCommand(1.0,AssignCommand(oClone,ActionEquipItem(ocItem8,INVENTORY_SLOT_BELT)));
                DelayCommand(1.0,AssignCommand(oClone,ActionEquipItem(ocItem9,INVENTORY_SLOT_BOLTS)));
                DelayCommand(1.0,AssignCommand(oClone,ActionEquipItem(ocItem10,INVENTORY_SLOT_ARMS)));
                DelayCommand(1.0,AssignCommand(oClone,ActionEquipItem(ocItem11,INVENTORY_SLOT_NECK)));
                SetDroppableFlag(ocItem1,FALSE);
                SetDroppableFlag(ocItem2,FALSE);
                SetDroppableFlag(ocItem3,FALSE);
                SetDroppableFlag(ocItem4,FALSE);
                SetDroppableFlag(ocItem5,FALSE);
                SetDroppableFlag(ocItem6,FALSE);
                SetDroppableFlag(ocItem7,FALSE);
                SetDroppableFlag(ocItem8,FALSE);
                SetDroppableFlag(ocItem9,FALSE);
                SetDroppableFlag(ocItem10,FALSE);
                SetDroppableFlag(ocItem11,FALSE);
                DelayCommand(60.0, SetLocalInt(oModule,sName1,0));
                DelayCommand(60.0, SafeDestroyObject(oClone,0.0));
                DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneDominated(),oClone));
}
