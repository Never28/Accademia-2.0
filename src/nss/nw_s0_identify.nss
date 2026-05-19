/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 10-08-2009
*/

// Funzione per Identificare.


#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nLevel = GetCasterLevel(OBJECT_SELF);
    int nBonus = nLevel/2;
    if(nBonus<1)
        nBonus = 1;
    effect eLore = EffectSkillIncrease(SKILL_LORE, nBonus);
    effect eVis = EffectVisualEffect(VFX_IMP_MAGICAL_VISION);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eVis, eDur);
    eLink = EffectLinkEffects(eLink, eLore);
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = 2;
    if(nMetaMagic == METAMAGIC_EXTEND)
        nDuration = 4;
    if(!GetHasSpellEffect(SPELL_IDENTIFY, OBJECT_SELF)){
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_IDENTIFY, FALSE));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nDuration));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    }
}

