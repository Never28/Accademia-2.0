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
    int nCasterLevel;
    int nDuration;
    object oSum;
    effect eSummon;
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    string sSummon;
    int nLore;
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
            nCasterLevel = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oPC);
            nDuration = 40;
            nLore = GetSkillRank(SKILL_LORE,oPC,TRUE);
            if(nLore>=43&&nCasterLevel==30)
                sSummon = "drake_ev_4";
            else if(nLore>=34&&nCasterLevel==30)
                sSummon = "drake_ev_3";
            else if(nLore>=24&&nCasterLevel>=20)
                sSummon = "drake_ev_2";
            else if(nLore>=14&&nCasterLevel>=10)
                sSummon = "drake_ev_1";
            else
                sSummon = "drake_ev_n";
            SendMessageToPC(oPC,"Quest'evocazione prosciuga la tua energia magica");
            SetLocalString(oPC,"mod_cla_summon",sSummon);
            ExecuteScript("mod_cla_summon",oPC);
            DelayCommand(1.0,ExecuteScript("mod_clas_kob_win",oPC));
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

