/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Nemico Eterno della Non Morte.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void GrantProtection(object oTarget)
{
    effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID);
    effect eNeg = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, 100);
    effect eLevel = EffectImmunity(IMMUNITY_TYPE_NEGATIVE_LEVEL);
    effect eAbil = EffectImmunity(IMMUNITY_TYPE_ABILITY_DECREASE);
    effect ePoison = EffectImmunity(IMMUNITY_TYPE_POISON);
    effect eDisease = EffectImmunity(IMMUNITY_TYPE_DISEASE);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    nDuration = nDuration *2;
    effect eLink = EffectLinkEffects(eNeg, eLevel);
    eLink = EffectLinkEffects(eLink, eAbil);
    eLink = EffectLinkEffects(eLink, ePoison);
    eLink = EffectLinkEffects(eLink, eDisease);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
}



void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    float fDelay;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
    while(GetIsObjectValid(oTarget)){
        if(GetIsReactionTypeFriendly(oTarget) || GetFactionEqual(oTarget)){
            fDelay = GetRandomDelay(0.4, 1.1);
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 444, FALSE));
            GrantProtection(oTarget);
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
    }
}



