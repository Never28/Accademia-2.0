/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Resistenza.

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    effect eSave;
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nLevel = GetCasterLevel(OBJECT_SELF);
    int nBonus = nLevel/8;
    if(nBonus<1)
        nBonus = 1;
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = 2;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RESISTANCE, FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration * 2;
    eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, nBonus);
    effect eLink = EffectLinkEffects(eSave, eDur);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
}
