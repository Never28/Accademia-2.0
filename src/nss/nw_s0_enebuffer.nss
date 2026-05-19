/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Respingere Energia.

#include "nw_i0_spells"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nAmount = nDuration/8;
    if(nAmount<1)
        nAmount =1;
    nAmount = nAmount *3;
    int nResistance = nDuration/8;
    if(nResistance<1)
        nResistance =1;
    nResistance = nResistance *20;
    int nMetaMagic = GetMetaMagicFeat();
    effect eCold = EffectDamageResistance(DAMAGE_TYPE_COLD, nResistance, nAmount);
    effect eFire = EffectDamageResistance(DAMAGE_TYPE_FIRE, nResistance, nAmount);
    effect eAcid = EffectDamageResistance(DAMAGE_TYPE_ACID, nResistance, nAmount);
    effect eSonic = EffectDamageResistance(DAMAGE_TYPE_SONIC, nResistance, nAmount);
    effect eElec = EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL, nResistance, nAmount);
    effect eDur = EffectVisualEffect(VFX_DUR_PROTECTION_ELEMENTS);
    effect eVis = EffectVisualEffect(VFX_IMP_ELEMENTAL_PROTECTION);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ENERGY_BUFFER, FALSE));
    effect eLink = EffectLinkEffects(eCold, eFire);
    eLink = EffectLinkEffects(eLink, eAcid);
    eLink = EffectLinkEffects(eLink, eSonic);
    eLink = EffectLinkEffects(eLink, eElec);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration *2;
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
