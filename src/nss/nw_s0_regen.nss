/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 07-08-2009
*/

// Funzione per Rigenerazione.

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF)/4;
    effect eRegen = EffectRegenerate(nCasterLevel, 6.0);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eRegen, eDur);
    int nMeta = GetMetaMagicFeat();
    int nLevel = GetCasterLevel(OBJECT_SELF);
    if (nMeta == METAMAGIC_EXTEND)
        nLevel *= 2;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_REGENERATE, FALSE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nLevel));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

}
