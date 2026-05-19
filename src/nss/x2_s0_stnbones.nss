/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 07-08-2009
*/

// Funzione per Ossa di Pietra.

#include "nw_i0_spells"

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nBonus = nCasterLvl/8;
    if(nBonus == 0)
        nBonus =1;
    int nDuration  = nCasterLvl * 10;
    int nMetaMagic = GetMetaMagicFeat();
    int nRacial = GetRacialType(oTarget);
    effect eVis = EffectVisualEffect(VFX_IMP_AC_BONUS);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
         nDuration = nDuration * 2;
    effect eAC1 = EffectACIncrease(nBonus, AC_DODGE_BONUS);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eAC1, eDur);
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    if(nRacial == RACIAL_TYPE_UNDEAD){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }
    else
        FloatingTextStrRefOnCreature(85390,OBJECT_SELF);
}
