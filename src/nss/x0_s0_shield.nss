/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 07-08-2009
*/

// Funzione per Scudo.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nValue = 1;
    if(nCasterLvl>20)
        nValue = 2;
    object oTarget = GetSpellTargetObject();
    effect eArmor = EffectACIncrease(nValue, AC_DEFLECTION_BONUS);
    effect eSpell = EffectSpellImmunity(SPELL_MAGIC_MISSILE);
    effect eDur = EffectVisualEffect(VFX_DUR_GLOBE_MINOR);
    effect eVis = EffectVisualEffect(VFX_IMP_AC_BONUS);
    int nMetaMagic = GetMetaMagicFeat();
    effect eLink = EffectLinkEffects(eArmor, eDur);
    eLink = EffectLinkEffects(eLink, eSpell);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    if (nMetaMagic == METAMAGIC_EXTEND)
         nDuration = nDuration * 2;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 417, FALSE));
    RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));

}

