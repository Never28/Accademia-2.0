/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 07-08-2009
*/

// Funzione per Cerchio Magico dall'Allineamento Buono.

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    effect eVis = EffectVisualEffect(VFX_DUR_PROTECTION_EVIL_MINOR);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eEvil = EffectVisualEffect(VFX_IMP_EVIL_HELP);
    object oTarget = GetSpellTargetObject();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nLevel = GetCasterLevel(OBJECT_SELF);
    int nBonus = 10 + nLevel;
    effect eSR = EffectSpellResistanceIncrease(nBonus);
    eSR = VersusAlignmentEffect(eSR,ALIGNMENT_ALL, ALIGNMENT_GOOD);
    effect eLink = EffectLinkEffects(eSR,eVis);
    eLink = EffectLinkEffects(eLink, eDur);
    int nMetaMagic = GetMetaMagicFeat();
    if (nDuration < 1)
        nDuration = 1;
    if (nMetaMagic == METAMAGIC_EXTEND)
       nDuration = nDuration *2;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MAGIC_CIRCLE_AGAINST_GOOD, FALSE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eEvil, oTarget);
}
