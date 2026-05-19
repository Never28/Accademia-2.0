/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 07-08-2009
*/

// Funzione per Aura di gloria.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = OBJECT_SELF;
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nModify = nCasterLvl/10;
    int TsBonus = nCasterLvl/4;
    if(TsBonus<1)
        TsBonus =1;
    if(nModify < 1)
        nModify = 1;
    nModify = 4*(nModify);
    int nMetaMagic = GetMetaMagicFeat();
    effect eChar = EffectAbilityIncrease(ABILITY_CHARISMA, nModify);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eChar, eDur);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    if (nMetaMagic == METAMAGIC_EXTEND)
         nDuration = nDuration * 2;
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    float fDelay = 0.0;
    eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    effect eFear = EffectSavingThrowIncrease(SAVING_THROW_ALL, TsBonus, SAVING_THROW_TYPE_FEAR);
    effect eHeal = EffectHeal(MaximizeOrEmpower(4,1, nMetaMagic));
    eLink = EffectLinkEffects(eFear, eHeal);
    eLink = EffectLinkEffects(eLink, eDur);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget)){
        if(GetIsReactionTypeFriendly(oTarget) || GetFactionEqual(oTarget)){
            fDelay = GetRandomDelay(0.4, 1.1);
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration)));
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }

}







