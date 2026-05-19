/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 10-08-2009
*/

// Funzione per Sfera Invisibilita' OnEnter.

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nLevel = GetCasterLevel(GetAreaOfEffectCreator());
    int nBonus = nLevel/4;
    if(nBonus<1)
        nBonus=1;
    object oTarget = GetEnteringObject();
    effect eVis = EffectVisualEffect(VFX_DUR_INVISIBILITY);
    effect nMove = EffectSkillIncrease(SKILL_MOVE_SILENTLY,nBonus);
    effect nHide = EffectSkillIncrease(SKILL_HIDE,nBonus);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(nMove, eDur);
    eLink = EffectLinkEffects(eLink, eVis);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_INVISIBILITY, FALSE));
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration *2;
    if(GetIsFriend(oTarget, GetAreaOfEffectCreator()))
    if (GetIsDead(oTarget) == FALSE){
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_INVISIBILITY_SPHERE, FALSE));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, nHide, oTarget, TurnsToSeconds(nDuration));
    }

}

