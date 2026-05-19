/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// Funzione dei Dadi.

#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;
    object oItem,oMob;
    object oSpellOrigin;
    object oSpellTarget;
    int iSpell,nRaggirare,nOsservare;
    int nSpia;
    object oSlotMob;
    object oSlotPC;
    string sSlotMob;
    string sSlotPC;
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
            oSlotMob = GetItemInSlot(INVENTORY_SLOT_CHEST,oMob);
            oSlotPC = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
            sSlotMob = GetTag(oSlotMob);
            sSlotPC = GetTag(oSlotPC);
            if(sSlotMob != sSlotPC){
                oMob = GetItemActivatedTarget();
                nSpia = GetLocalInt(oPC,"spiacammuffamento");
                if(nSpia == 1){
                    if(GetIsEnemy(oMob,oPC)==TRUE){
                        nRaggirare = d20(1) + GetSkillRank(SKILL_BLUFF,oPC,FALSE);
                        nOsservare = d20(1) + GetSkillRank(SKILL_CONCENTRATION,oMob,FALSE);
                        if(nRaggirare>nOsservare){
                            AssignCommand(oPC,SpeakString("Ehi tu, vieni a darmi una mano, ho sentito dei rumori e deve esserci un'infiltrato!"));
                            AssignCommand(oMob,SpeakString("Cosa dici davvero? Vengo a controllare!"));
                            AssignCommand(oMob,ActionForceMoveToObject(oPC,FALSE,1.0,30.0));
                        }
                    }
                    else
                        SendMessageToPC(oPC,"Non puoi usare questa abilita' su un'amico");
                }
                else{
                    SendMessageToPC(oPC,"Non puoi usare questa abilita' se non sei in modalita spia");
                }
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

