/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 07-08-2009
*/

// Funzione per Protezione dall'Allineamento Buono.

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nAlign = ALIGNMENT_GOOD;
    object oTarget = GetSpellTargetObject();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nBonus = 1;
    if(nDuration>20)
        nBonus = 2;
    int nMetaMagic = GetMetaMagicFeat();
    effect eAC = EffectACIncrease(nBonus, AC_DODGE_BONUS);
    eAC = VersusAlignmentEffect(eAC, ALIGNMENT_ALL, nAlign);
    effect eDur = EffectVisualEffect(VFX_DUR_PROTECTION_EVIL_MINOR);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink;
    eLink = EffectLinkEffects(eLink, eAC);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);
    if (nMetaMagic == METAMAGIC_EXTEND)
       nDuration = nDuration *2;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_PROTECTION_FROM_GOOD, FALSE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
}

