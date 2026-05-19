/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 10-08-2009
*/

// Funzione per Ristorare Superiore.

#include "x2_inc_spellhook"

int GetIsSupernaturalCurse(effect eEff);

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);
    effect eBad = GetFirstEffect(oTarget);
    object oCaster = GetLastSpellCaster();
    int nLevel = GetCasterLevel(oCaster);
    int nAlign,nHeal;
    while(GetIsEffectValid(eBad)){
        if ((GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
            GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
            GetEffectType(eBad) == EFFECT_TYPE_CURSE ||
            GetEffectType(eBad) == EFFECT_TYPE_DISEASE ||
            GetEffectType(eBad) == EFFECT_TYPE_POISON ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_CHARMED ||
            GetEffectType(eBad) == EFFECT_TYPE_DOMINATED ||
            GetEffectType(eBad) == EFFECT_TYPE_DAZED ||
            GetEffectType(eBad) == EFFECT_TYPE_CONFUSED ||
            GetEffectType(eBad) == EFFECT_TYPE_FRIGHTENED ||
            GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_SLOW ||
            GetEffectType(eBad) == EFFECT_TYPE_STUNNED) && GetEffectSubType(eBad)!=SUBTYPE_SUPERNATURAL){
                RemoveEffect(oTarget, eBad);
        }
        eBad = GetNextEffect(oTarget);
    }
    if(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD){
        int nCure = GetSkillRank(SKILL_HEAL,OBJECT_SELF);
        nAlign = GetAlignmentGoodEvil(oTarget);
        if ((nAlign == ALIGNMENT_GOOD && GetItemPossessedBy(OBJECT_SELF,"mod_deity_latha")!=OBJECT_INVALID && GetItemPossessedBy(OBJECT_SELF,"mod_clas_gf")!=OBJECT_INVALID)
        || (nAlign == ALIGNMENT_EVIL && GetItemPossessedBy(OBJECT_SELF,"mod_deity_talos")!=OBJECT_INVALID && GetItemPossessedBy(OBJECT_SELF,"mod_clas_gf")!=OBJECT_INVALID))
            nHeal = (16* nLevel)+ nCure;
        else
            nHeal = d8(nLevel*2) + nCure;
        effect eHeal = EffectHeal(nHeal);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    }
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_RESTORATION, FALSE));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
}

int GetIsSupernaturalCurse(effect eEff)
{
    object oCreator = GetEffectCreator(eEff);
    if(GetTag(oCreator) == "q6e_ShaorisFellTemple")
        return TRUE;
    return FALSE;
}
