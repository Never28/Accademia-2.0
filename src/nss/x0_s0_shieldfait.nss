/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 07-08-2009
*/

// Funzione per Scudo del Fato.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_AC_BONUS);
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nValue = 1;
    if(nCasterLvl>20)
        nValue = 2;
    effect eAC = EffectACIncrease(nValue, AC_DODGE_BONUS);
    effect eDur = EffectVisualEffect(VFX_DUR_PROTECTION_GOOD_MINOR);
    effect eLink = EffectLinkEffects(eAC, eDur);
    int nDuration = GetCasterLevel(OBJECT_SELF);
     if (nMetaMagic == METAMAGIC_EXTEND)
         nDuration = nDuration * 2;
    RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 421, FALSE));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));

}
