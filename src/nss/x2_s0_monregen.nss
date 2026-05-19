/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 07-08-2009
*/

// Funzione per Rigenerazione Mostruosa.

#include "x2_inc_spellhook"
#include "x0_i0_spells"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF)/8;
    object oTarget = GetSpellTargetObject();
    effect eRegen = EffectRegenerate(nCasterLevel, 6.0);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eRegen, eDur);
    int nMeta = GetMetaMagicFeat();
    int nLevel = (GetCasterLevel(OBJECT_SELF)/2)+1;
    if (nMeta == METAMAGIC_EXTEND)
        nLevel *= 2;
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nLevel));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
