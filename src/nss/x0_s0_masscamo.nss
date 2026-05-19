/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Mimetismo di Massa.

#include "X0_I0_SPELLS"

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    location lTarget = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget);
    while(GetIsObjectValid(oTarget)){
        if(GetIsReactionTypeFriendly(oTarget) || GetFactionEqual(oTarget))
            DoCamoflage(oTarget);
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget);
    }
}









