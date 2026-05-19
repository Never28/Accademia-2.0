/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Volto Fantasma.

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nLevel = GetCasterLevel(OBJECT_SELF);
    nLevel = (nLevel /8);
    if(nLevel<1)
        nLevel =1;
    nLevel = nLevel*5;
    effect eVis = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
    effect eSpell = EffectSpellLevelAbsorption(1);
    effect eConceal = EffectConcealment(nLevel);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eVis, eSpell);
    eLink = EffectLinkEffects(eLink, eConceal);
    eLink = EffectLinkEffects(eLink, eDur);
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GHOSTLY_VISAGE, FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration *2;
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
}

