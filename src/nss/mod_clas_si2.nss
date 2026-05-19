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
    int nAC,nForza,nDex,nAB,nTxC;
    int iSpell,nRaggirare,nOsservare;
    int nSpia,i;
    location lMob;
    object oSlotMob;
    object oSlotPC,oMob2;
    string sSlotMob;
    string sSlotPC,sRefVeste;
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
            oMob = GetItemActivatedTarget();
            oSlotMob = GetItemInSlot(INVENTORY_SLOT_CHEST,oMob);
            oSlotPC = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
            sSlotMob = GetTag(oSlotMob);
            sSlotPC = GetTag(oSlotPC);
            lMob = GetLocation(oMob);
            oMob2 = GetFirstObjectInShape(SHAPE_SPHERE,30.0,lMob,FALSE,OBJECT_TYPE_CREATURE);
            while(oMob2!=OBJECT_INVALID){
                if(oMob2!=oMob)
                    i = 1;
                oMob2 = GetNextObjectInShape(SHAPE_SPHERE,30.0,lMob,FALSE,OBJECT_TYPE_CREATURE);
            }
            if(i ==0){
                if(sSlotMob != sSlotPC){
                    oMob = GetItemActivatedTarget();
                    nSpia = GetLocalInt(oPC,"spiacammuffamento");
                    if(nSpia == 1){
                        if(GetIsEnemy(oMob,oPC)==TRUE){
                            nAC = GetAC(oMob);
                            nAB = GetAC(oPC);
                            nForza = GetAbilityScore(oPC,ABILITY_STRENGTH);
                            nDex = GetAbilityScore(oPC,ABILITY_DEXTERITY);
                            if(nForza<nDex)
                                nForza = nDex;
                            nTxC = d20(1) + nForza + nAB + 5;
                            if(nTxC >= nAC)
                                ExecuteScript("mod_clas_si2_1",oPC);
                            else{
                                SendMessageToPC(oPC,"Colpo Mortale Fallito, sei stato scoperto!");
                                sRefVeste = GetResRef(oSlotPC);
                                if(sRefVeste == "loot_spia"){
                                    DestroyObject(oSlotPC,0.0);
                                    SetLocalInt(oPC,"spiacammuffamento",0);
                                }
                            }
                        }
                        else
                            SendMessageToPC(oPC,"Non puoi usare questa abilita' su un'amico");
                    }
                    else
                        SendMessageToPC(oPC,"Non puoi usare questa abilita' se non sei in modalita spia");
                }
            }
            else
                SendMessageToPC(oPC,"Non puoi stordire una persona con altre vicine");
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

