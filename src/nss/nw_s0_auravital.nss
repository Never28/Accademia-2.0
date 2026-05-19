/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Aura di Vitalita.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget;
    int nLevel = GetCasterLevel(OBJECT_SELF);
    effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH,nLevel/5);
    effect eDex = EffectAbilityIncrease(ABILITY_DEXTERITY,nLevel/5);
    effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION,nLevel/5);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eStr, eDex);
    eLink = EffectLinkEffects(eLink, eCon);
    eLink = EffectLinkEffects(eLink, eDur);
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    float fDelay;
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration *= 2;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget)){
        if(GetFactionEqual(oTarget) || GetIsReactionTypeFriendly(oTarget)){
            fDelay = GetRandomDelay(0.4, 1.1);
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_AURA_OF_VITALITY, FALSE));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}
