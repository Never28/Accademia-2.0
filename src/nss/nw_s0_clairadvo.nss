/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Chiaroveggenza/Chiaroudenza.

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nLevel = GetCasterLevel(OBJECT_SELF);
    int nBonus = nLevel/4;
    if(nBonus<1)
        nBonus = 1;
    effect eSpot = EffectSkillIncrease(SKILL_SPOT, nBonus);
    effect eListen = EffectSkillIncrease(SKILL_LISTEN, nBonus);
    effect eVis = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eSpot, eListen);
    eLink = EffectLinkEffects(eLink, eVis);
    eLink = EffectLinkEffects(eLink, eDur);
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    if(nMetaMagic == METAMAGIC_EXTEND)
        nLevel *= 2;
    if(!GetHasSpellEffect(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE, oTarget)){
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE, FALSE));
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nLevel));
    }
}

