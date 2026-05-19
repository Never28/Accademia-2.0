/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Favore Divino.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget;
    int nMetaMagic = GetMetaMagicFeat();
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int Bonus = 1;
    if(nDuration>20)
        Bonus = 2;
    effect eAttack = EffectAttackIncrease(Bonus);
    effect eDamage = EffectDamageIncrease(Bonus, DAMAGE_TYPE_MAGICAL);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eAttack, eDamage);
    eLink = EffectLinkEffects(eLink, eDur);
    if ( nMetaMagic == METAMAGIC_EXTEND )
        nDuration = nDuration * 2;
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
            oTarget = OBJECT_SELF;
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 414, FALSE));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
}

