/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 18-06-2009
*/

// Funzione per Clonazione.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"


void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;
    int iSpell;
    object oItem;
    object oSpellOrigin;
    object oSpellTarget;
    string sName;
    object oModule;
    int nResult = X2_EXECUTE_SCRIPT_END;
    switch (nEvent){

        case X2_ITEM_EVENT_ONHITCAST:
            oItem  =  GetSpellCastItem();
            oPC = OBJECT_SELF;
            oSpellOrigin = OBJECT_SELF ;
            oSpellTarget = GetSpellTargetObject();
            break;

        case X2_ITEM_EVENT_ACTIVATE:
            oPC   = GetItemActivator();
            sName = GetName(oPC)+"2";
            oModule = GetModule();
            if(GetLocalInt(oModule,sName)==0){
                ExecuteScript("mod_clas_ma4_1",oPC);
            }
            else
                SendMessageToPC(OBJECT_SELF,"Questa magia e' lanciabile solo una volta ogni 60 secondi");
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

