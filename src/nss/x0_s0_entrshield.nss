/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Scudo Entropico.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = OBJECT_SELF;
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int Bonus = nDuration/8;
    if(Bonus<1)
        Bonus = 1;
    Bonus = Bonus*10;
    int nMetaMagic = GetMetaMagicFeat();
    effect eVis = EffectVisualEffect(VFX_IMP_AC_BONUS);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
         nDuration = nDuration * 2;
    effect eShield =  EffectConcealment(Bonus, MISS_CHANCE_TYPE_VS_RANGED);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eShield, eDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}

