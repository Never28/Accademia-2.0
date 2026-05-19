/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 10-08-2009
*/

// Funzione per Conoscenza delle Leggende.

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nLevel = GetCasterLevel(oTarget);
    int nBonus = 10 + (nLevel / 2);
    effect eLore = EffectSkillIncrease(SKILL_LORE, nBonus);
    effect eVis = EffectVisualEffect(VFX_IMP_MAGICAL_VISION);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eLore, eDur);
    int nMetaMagic = GetMetaMagicFeat();
    if(nMetaMagic == METAMAGIC_EXTEND)
        nLevel *= 2;
    if(!GetHasSpellEffect(SPELL_LEGEND_LORE, oTarget)){
         SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LEGEND_LORE, FALSE));
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nLevel));
         ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }
}

