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
    object oItem;
    object oSpellOrigin;
    object oSpellTarget;
    int iSpell;
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
            ExecuteScript("mod_clas_si_1",oPC);
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

