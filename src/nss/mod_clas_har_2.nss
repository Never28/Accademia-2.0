/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 18-06-2009
*/

// Funzione della Mappa di navigazione.

#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;
    object oSpellOrigin;
    object oSpellTarget;
    object oArea;
    int nSkill;
    string sGolem;
    effect eSummon;
    string NameoArea,s3Area;
    int iSpell;
    int nResult = X2_EXECUTE_SCRIPT_END;
    int nCasterLevel;
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
            sGolem = GetLocalString(oPC,"har_gol");
            if(sGolem == "")
                sGolem = "sp_golharw";
            nCasterLevel = GetLevelByClass(CLASS_TYPE_BARD,oPC)+GetLevelByClass(CLASS_TYPE_HARPER,oPC);
            nSkill = GetSkillRank(SKILL_CRAFT_ARMOR,oPC,TRUE);
            if(nCasterLevel>=40 && nSkill>=43 && GetItemPossessedBy(oPC,"mod_clas_al") != OBJECT_INVALID)
                sGolem = sGolem+"_4";
            else if(nCasterLevel>=31 && nSkill>=34)
                sGolem = sGolem+"_3";
            else if(nCasterLevel>=21 && nSkill>=24)
                sGolem = sGolem+"_2";
            else if(nCasterLevel>=15 && nSkill>=14)
                sGolem = sGolem+"_1";
            else
                sGolem = sGolem+"_n";
            SetLocalString(oPC,"mod_cla_summon",sGolem);
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

