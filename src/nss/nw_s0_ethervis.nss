/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Volto Etereo.

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    effect eDam;
    int nOccult = 25;
    int nAmount = nCasterLevel*2;
    eDam = EffectDamageReduction(20, DAMAGE_POWER_PLUS_TWENTY,nAmount);
    effect eVis = EffectVisualEffect(VFX_DUR_ETHEREAL_VISAGE);
    effect eSpell = EffectSpellLevelAbsorption(2);
    effect eConceal = EffectConcealment(nOccult);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eDam, eVis);
    eLink = EffectLinkEffects(eLink, eSpell);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eConceal);
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ETHEREAL_VISAGE, FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration *2;
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
}

