/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 29-06-2009
*/

// Eludere nelle Ombre del Drago d'Ombra.

#include "x2_inc_switches"
void main()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eBlend = EffectConcealment(75);
    effect eLink = EffectLinkEffects(eVis, eBlend);
    eLink = EffectLinkEffects(eLink, eDur);
    int nDuration = 10; // 10 rounds

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    //Apply the VFX impact and effects
    if(!GetHasSpellEffect(GetSpellId(),OBJECT_SELF))
    {
             // if we are under effect of continual flame, this does not work
        if(!GetHasSpellEffect(SPELL_CONTINUAL_FLAME,OBJECT_SELF))
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
        }
     }



}
