/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 10-08-2009
*/

// Funzione per Visione del Vero.

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nBonus = nCasterLevel/2;
    effect eVis = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect nListen = EffectSkillIncrease(SKILL_LISTEN,nBonus);
    effect nSpot = EffectSkillIncrease(SKILL_SPOT,nBonus);
    effect eLink = EffectLinkEffects(eVis, nSpot);
    eLink = EffectLinkEffects(eLink, eDur);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_TRUE_SEEING, FALSE));
    int nClass = GetLastSpellCastClass();
        int nDuration = GetCasterLevel(OBJECT_SELF);
        int nMetaMagic = GetMetaMagicFeat();
        if (nMetaMagic == METAMAGIC_EXTEND)
            nDuration = nDuration *2;
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, nListen, oTarget, TurnsToSeconds(nDuration));
}

