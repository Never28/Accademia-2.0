/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 18-06-2009
*/

// Funzione per il Pietrificare di Massa.

#include "X0_I0_SPELLS"
#include "x2_i0_spells"
#include "x2_inc_spellhook"

void main()
{
    float fDelay;
    int nDC;
    object oPC = OBJECT_SELF;
    location lTarget = GetLocalLocation(oPC,"Arcimago");
    object oTarget;
    effect ePetrify = EffectPetrify();
    effect eVis = EffectVisualEffect(VFX_DUR_PETRIFY);
    effect eVis2 = EffectVisualEffect(VFX_FNF_HORRID_WILTING);
    ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eVis2, GetItemActivatedTargetLocation());
    nDC = 24;
    if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_NECROMANCY,oPC))
        nDC = nDC +6;
    else if(GetHasFeat(FEAT_SPELL_FOCUS_NECROMANCY,oPC))
        nDC = nDC + 2;
    else if(GetHasFeat(FEAT_GREATER_SPELL_FOCUS_NECROMANCY,oPC))
        nDC = nDC + 4;
    nDC = nDC + GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget)){
        if(GetIsFriend(oTarget)==FALSE && GetObjectType(oTarget) == OBJECT_TYPE_CREATURE){
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_NEGATIVE)){
                DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePetrify, oTarget));
                DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oTarget));
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}
