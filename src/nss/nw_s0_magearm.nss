/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Armatura Magica.

#include "nw_i0_spells"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nBonus = nDuration/10;
    if(nBonus<1)
        nBonus = 1;
    int nMetaMagic = GetMetaMagicFeat();
    effect eVis = EffectVisualEffect(VFX_IMP_AC_BONUS);
    effect eAC;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MAGE_ARMOR, FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration * 2;
    eAC = EffectACIncrease(nBonus, AC_DODGE_BONUS);
    effect eLink = EffectLinkEffects(eLink, eAC);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    eLink = EffectLinkEffects(eLink, eDur);
    RemoveEffectsFromSpell(oTarget, SPELL_MAGE_ARMOR);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
