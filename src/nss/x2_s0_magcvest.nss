/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Veste magica.

#include "nw_i0_spells"
#include "x2_i0_spells"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    effect eVis = EffectVisualEffect(VFX_IMP_GLOBE_USE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nDuration  = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nBonus = 1;
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    int nAmount = GetCasterLevel(OBJECT_SELF);
    if (nAmount >20)
        nBonus=2;
    effect eLink = EffectACIncrease(nBonus,AC_DODGE_BONUS,AC_VS_DAMAGE_TYPE_ALL);
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    if ( nMetaMagic == METAMAGIC_EXTEND )
        nDuration = nDuration * 2;
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
            object oTarget = OBJECT_SELF;
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 414, FALSE));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));

}
