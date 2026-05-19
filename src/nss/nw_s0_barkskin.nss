/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Pelle Coriacea.

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    float fDuration = HoursToSeconds(nCasterLevel);
    effect eVis = EffectVisualEffect(VFX_DUR_PROT_BARKSKIN);
    effect eHead = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eAC;
    int nBonus = 2;
    int nAmount = GetCasterLevel(OBJECT_SELF);
    if (nAmount >20)
        nBonus=4;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_BARKSKIN, FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
        fDuration = HoursToSeconds(nCasterLevel * 2);
    eAC = EffectACIncrease(nBonus, AC_DODGE_BONUS);
    effect eLink = EffectLinkEffects(eVis, eAC);
    eLink = EffectLinkEffects(eLink, eDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHead, oTarget);
}
