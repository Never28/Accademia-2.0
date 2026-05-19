/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 18-06-2009
*/

// Funzione per il evoca scudiero

#include "x2_inc_spellhook"
#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;
    object oSpellOrigin;
    object oSpellTarget;
    object oArea;
    string NameoArea,sSummon;
    int iSpell;
    effect eSummon;
    int nLore;
    location oTarget;
    int nResult = X2_EXECUTE_SCRIPT_END;
    int NewSummon;
    switch (nEvent){

        case X2_ITEM_EVENT_ONHITCAST:
            oItem  =  GetSpellCastItem();
            oPC = OBJECT_SELF;
            oSpellOrigin = OBJECT_SELF ;
            oSpellTarget = GetSpellTargetObject();
            break;

        case X2_ITEM_EVENT_ACTIVATE:
            oPC   = GetItemActivator();
            oItem = GetItemActivated();
            eSummon;
            nLore = GetSkillRank(SKILL_PERSUADE,OBJECT_SELF,TRUE);
            if(nLore>=43)
                sSummon = "sp_scudiero_4";
            else if(nLore>=34)
                sSummon = "sp_scudiero_3";
            else if(nLore>=24)
                sSummon = "sp_scudiero_2";
            else if(nLore>=14)
                sSummon = "sp_scudiero_1";
            else
                sSummon = "sp_scudiero_n";
            SetLocalString(oPC,"mod_cla_summon",sSummon);
            ExecuteScript("mod_cla_summon",oPC);
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


