/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Sussurri Mortali.

#include "x2_inc_spellhook"
#include "x0_i0_spells"
void main()
{
    if (!X2PreSpellCastCode())
        return;
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nBonus = nDuration/2;
    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = OBJECT_SELF;
    effect eShield = EffectDamageShield(nBonus, 0, DAMAGE_TYPE_SONIC);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eShield, eDur);
    eLink = EffectLinkEffects(eLink, eVis);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 441, FALSE));
    if (GetHasSpellEffect(GetSpellId()))
        RemoveSpellEffects(GetSpellId(),OBJECT_SELF,OBJECT_SELF);
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration *2;
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
}
