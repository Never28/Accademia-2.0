/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Amplificare.

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nBonus = nCasterLevel/2;
    if(nBonus<1)
        nBonus = 1;
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    int nMetaMagic = GetMetaMagicFeat();
    effect eHide = EffectSkillIncrease(SKILL_LISTEN, nBonus);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eHide, eDur);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    if (nMetaMagic == METAMAGIC_EXTEND)
         nDuration = nDuration * 2;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_AMPLIFY, FALSE));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
}







