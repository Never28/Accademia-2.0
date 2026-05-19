/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 07-08-2009
*/

// Funzione per Saggezza del gufo.

#include "x2_inc_spellhook"
#include "nw_i0_spells"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    effect eStr;
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nModify = d4(1);
    float fDuration = HoursToSeconds(nCasterLvl);
    int nMetaMagic = GetMetaMagicFeat();
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_OWLS_WISDOM, FALSE));
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
        nModify = 4;
    if (nMetaMagic == METAMAGIC_EMPOWER)
        nModify = nModify + (nModify/2);
    if (nMetaMagic == METAMAGIC_EXTEND)
        fDuration = fDuration * 2.0;
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        eStr = EffectAbilityIncrease(ABILITY_WISDOM,nModify);
        effect eLink = EffectLinkEffects(eStr, eDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
}
