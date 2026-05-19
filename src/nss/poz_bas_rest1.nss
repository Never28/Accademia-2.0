/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// Funzione dei Dadi.

#include "x2_inc_switches"

int GetIsSupernaturalCurse(effect eEff)
{
    object oCreator = GetEffectCreator(eEff);
    if(GetTag(oCreator) == "q6e_ShaorisFellTemple")
        return TRUE;
    return FALSE;
}

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;
    object oSpellOrigin;
    object oSpellTarget;
    int iSpell;
    effect eBad;
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
            eBad = GetFirstEffect(oPC);
            while(GetIsEffectValid(eBad))
            {
                if ((GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
                    GetEffectType(eBad) == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE ||
                    GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
                    GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
                    GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
                    GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
                    GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
                    GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
                    GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
                    GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
                    GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
                    GetEffectType(eBad) == EFFECT_TYPE_POISON ||
                    GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
                    GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL ||
                    GetEffectType(eBad) == EFFECT_TYPE_CURSE ||
                    GetEffectType(eBad) == EFFECT_TYPE_DISEASE) && GetEffectSubType(eBad)!=SUBTYPE_SUPERNATURAL){
                            RemoveEffect(oPC, eBad);
                    }
                eBad = GetNextEffect(oPC);
            }
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_RESTORATION), oPC);
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

