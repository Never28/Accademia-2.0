/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 10-08-2009
*/

// Funzione per Invisibilita'.

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nBonus = nCasterLevel/4;
    if(nBonus<1)
        nBonus=1;
    object oTarget = GetSpellTargetObject();
    effect nMove = EffectSkillIncrease(SKILL_MOVE_SILENTLY,nBonus);
    effect nHide = EffectSkillIncrease(SKILL_HIDE,nBonus);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(nMove, eDur);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_INVISIBILITY, FALSE));
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration *2;
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, nHide, oTarget, TurnsToSeconds(nDuration));
}

