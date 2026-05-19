/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 07-08-2009
*/

// Funzione per Resistenza agli Incantesimi.

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nLevel = GetCasterLevel(OBJECT_SELF);
    int nBonus = 10 + nLevel;
    effect eSR = EffectSpellResistanceIncrease(nBonus);
    effect eVis = EffectVisualEffect(VFX_IMP_MAGIC_PROTECTION);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eDur2 = EffectVisualEffect(249);
    effect eLink = EffectLinkEffects(eSR, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SPELL_RESISTANCE, FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
        nLevel = nLevel *2;
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nLevel));
}
