/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 13-07-2009
*/

// Funzione per Tutt'uno Con la Terra.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = OBJECT_SELF;
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nLevel = nDuration / 8;
    if(nLevel<1)
        nLevel = 1;
    effect eSkillAnimal = EffectSkillIncrease(SKILL_ANIMAL_EMPATHY, nLevel);
    effect eHide = EffectSkillIncrease(SKILL_HIDE, nLevel);
    effect eMove = EffectSkillIncrease(SKILL_MOVE_SILENTLY, nLevel);
    effect eSearch = EffectSkillIncrease(SKILL_SET_TRAP, nLevel);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eSkillAnimal, eMove);
    eLink = EffectLinkEffects(eLink, eHide);
    eLink = EffectLinkEffects(eLink, eSearch);
    eLink = EffectLinkEffects(eLink, eDur);
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration * 2;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 420, FALSE));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));

}





