/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 01/10/2010
*/

// Funzione per lo scalcare

#include "x2_inc_switches"
#include "mod_bas_sca_per"

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
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;
    object oSpellOrigin;
    object oSpellTarget;
    object oTarget;
    float fDistance;
    string sTagTarget,sResTarget;
    int nScalc,nScalcPC;
    int iSpell;
    string sTag,sRef;
    int nStack;
    int nResult = X2_EXECUTE_SCRIPT_END;

    switch (nEvent)
    {
        case X2_ITEM_EVENT_ONHITCAST:
            oItem  =  GetSpellCastItem();
            oPC = OBJECT_SELF;
            oSpellOrigin = OBJECT_SELF ;
            oSpellTarget = GetSpellTargetObject();
            break;

        case X2_ITEM_EVENT_ACTIVATE:
            oPC   = GetItemActivator();
            oItem = GetItemActivated();
            oTarget = GetItemActivatedTarget();
            sRef = GetStringLeft(GetResRef(oTarget),6);
            if(sRef=="set_01"||sRef=="set_02"||sRef=="set_03"||sRef=="set_04"||sRef=="set_05"||
                sRef=="set_06"||sRef=="set_07"||sRef=="set_08"||sRef=="set_09"||sRef=="set_10"||
                sRef=="set_11"||sRef=="set_12"||sRef=="set_13"||sRef=="set_14"||sRef=="set_15"||
                sRef=="set_16"||sRef=="set_17"||sRef=="set_18"||sRef=="set_20"||sRef=="set_21"||
                sRef=="set_22"||sRef=="set_23"||sRef=="set_24"||sRef=="set_25"||sRef=="set_26"||
                sRef=="set_27"||sRef=="set_28"||sRef=="set_29"||sRef=="set_30"||sRef=="set_31"||
                sRef=="set_32"||sRef=="set_33"||sRef=="set_34"||sRef=="set_35"||sRef=="set_36"||
                sRef=="set_37"||sRef=="set_38"||sRef=="set_39"||sRef=="set_40"||sRef=="set_41"||
                sRef=="set_42"||sRef=="set_43"||sRef=="set_44"||sRef=="set_45"||sRef=="set_46"||
                sRef=="set_47"||sRef=="set_48"||sRef=="set_49"||sRef=="set_50"||sRef=="set_51"||
                sRef=="set_52"||sRef=="set_53"||sRef=="set_54"||sRef=="set_55"||sRef=="set_56"||
                sRef=="set_57"||sRef=="set_58"||sRef=="set_59"||sRef=="set_60"||sRef=="set_61"||
                sRef=="set_62"||sRef=="set_63"||sRef=="set_64"||sRef=="set_65"||sRef=="set_66"||
                sRef=="set_67"||sRef=="set_68"||sRef=="set_69"||sRef=="set_70"||sRef=="set_71"||
                sRef=="set_72"||sRef=="set_73"||sRef=="set_74"||sRef=="set_75"||sRef=="set_76"||
                sRef=="set_77"||sRef=="set_78"||sRef=="set_79"||sRef=="set_80"||sRef=="set_81"){
                SetLocalObject(oPC,"scambio_item",oTarget);
                AssignCommand(oPC,SpeakString(GetName(oPC)+" vuole scambiare "+GetName(oTarget), TALKVOLUME_TALK));
            }
            sRef = GetStringLeft(GetResRef(oTarget),10);
            if(sRef=="set_19_bos"){
                SetLocalObject(oPC,"scambio_item",oTarget);
                AssignCommand(oPC,SpeakString(GetName(oPC)+" vuole scambiare "+GetName(oTarget), TALKVOLUME_TALK));
            }
            sRef = GetStringLeft(GetResRef(oTarget),12);
            if(sRef=="craft_19_bos"){
                SetLocalObject(oPC,"scambio_item",oTarget);
                AssignCommand(oPC,SpeakString(GetName(oPC)+" vuole scambiare "+GetName(oTarget), TALKVOLUME_TALK));
            }
            sRef = GetStringLeft(GetResRef(oTarget),8);
            if(sRef=="craft_1_"||sRef=="craft_2_"||sRef=="craft_3_"||sRef=="craft_4_"||sRef=="craft_5_"||
                sRef=="craft_6_"||sRef=="craft_7_"||sRef=="craft_8_"||sRef=="craft_9_"||sRef=="craft_10"||
                sRef=="craft_11"||sRef=="craft_12"||sRef=="craft_13"||sRef=="craft_14"||sRef=="craft_15"||
                sRef=="craft_16"||sRef=="craft_17"||sRef=="craft_18"||sRef=="craft_20"||sRef=="craft_21"||
                sRef=="craft_22"||sRef=="craft_23"||sRef=="craft_24"||sRef=="craft_25"||sRef=="craft_26"||
                sRef=="craft_27"||sRef=="craft_28"||sRef=="craft_29"||sRef=="craft_31"||sRef=="craft_32"||
                sRef=="craft_34"||sRef=="craft_35"||sRef=="craft_37"||sRef=="craft_38"||sRef=="craft_40"||
                sRef=="craft_41"||sRef=="craft_43"||sRef=="craft_44"||sRef=="craft_46"||sRef=="craft_47"||
                sRef=="craft_49"||sRef=="craft_50"||sRef=="craft_61"||sRef=="craft_73"||sRef=="craft_76"){
                SetLocalObject(oPC,"scambio_item",oTarget);
                nStack = GetItemStackSize(oTarget);
                AssignCommand(oPC,SpeakString(GetName(oPC)+" vuole scambiare "+IntToString(nStack)+" "+GetName(oTarget), TALKVOLUME_TALK));
            }
            break;

        case X2_ITEM_EVENT_EQUIP:

            oPC = GetPCItemLastEquippedBy();
            oItem = GetPCItemLastEquipped();
            break;

        case X2_ITEM_EVENT_UNEQUIP:
            oPC    = GetPCItemLastUnequippedBy();
            oItem  = GetPCItemLastUnequipped();
            break;

        case X2_ITEM_EVENT_ACQUIRE:
            oPC = GetModuleItemAcquiredBy();
            oItem  = GetModuleItemAcquired();
            break;

        case X2_ITEM_EVENT_UNACQUIRE:
            oPC = GetModuleItemLostBy();
            oItem  = GetModuleItemLost();
            break;

       case X2_ITEM_EVENT_SPELLCAST_AT:
            oPC = OBJECT_SELF;
            oItem  = GetSpellTargetObject();
            iSpell = GetSpellId();
            nResult = X2_EXECUTE_SCRIPT_CONTINUE;
            break;
    }
    SetExecutedScriptReturnValue(nResult);
}

