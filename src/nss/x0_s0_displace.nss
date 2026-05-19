/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Distorsione.

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    effect eDisplace;
    effect eVis = EffectVisualEffect(VFX_IMP_AC_BONUS);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nMetaMagic = GetMetaMagicFeat();
    int nRaise = GetCasterLevel(OBJECT_SELF) / 2;
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nBonus = nDuration/4;
    if (nBonus<1)
        nBonus = 1;
    nBonus = 50;
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration *2;
    eDisplace = EffectConcealment(nBonus);
    if (GetEffectType(eDisplace) != EFFECT_TYPE_INVALIDEFFECT){
        effect eLink = EffectLinkEffects(eDisplace, eDur);
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DISPLACEMENT, FALSE));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }

}




