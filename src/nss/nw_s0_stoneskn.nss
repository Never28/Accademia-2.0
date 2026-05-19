/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Pelle di Pietra.

#include "nw_i0_spells"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    effect eStone;
    effect eVis = EffectVisualEffect(VFX_DUR_PROT_STONESKIN);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink, eDam;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nAmount = nCasterLevel*2;
    object oTarget = GetSpellTargetObject();
    eDam = EffectDamageReduction(20, DAMAGE_POWER_PLUS_TWENTY,nAmount);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_STONESKIN, FALSE));
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
        nDuration *= 2;
    eStone = eDam;
    eLink = EffectLinkEffects(eStone, eVis);
    eLink = EffectLinkEffects(eLink, eDur);
    RemoveEffectsFromSpell(oTarget, SPELL_STONESKIN);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
}
