/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 10-08-2009
*/

// Funzione per Ritirata Rapida.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    if (GetHasSpellEffect(SPELL_HASTE, oTarget) == TRUE)
        return ;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eFast = EffectMovementSpeedIncrease(99);    effect eLink = EffectLinkEffects(eFast, eDur);
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration *2;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 455, FALSE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
}
