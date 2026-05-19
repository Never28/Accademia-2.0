/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Premonizione.

#include "nw_i0_spells"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    effect eStone;
    effect eVis = EffectVisualEffect(VFX_DUR_PROT_PREMONITION);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink, eDam;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nAmount = nCasterLevel*4;
    object oTarget = GetSpellTargetObject();
    eDam = EffectDamageReduction(40, DAMAGE_POWER_PLUS_TWENTY,nAmount);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_PREMONITION, FALSE));
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
        nDuration *= 2;
    eStone = eDam;
    eLink = EffectLinkEffects(eStone, eVis);
    eLink = EffectLinkEffects(eLink, eDur);
    RemoveEffectsFromSpell(oTarget, SPELL_PREMONITION);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
}
