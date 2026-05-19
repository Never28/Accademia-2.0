/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 18-06-2009
*/

// Funzione per il Risucchio di Massa.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    float fDelay;
    int nDC;
    object oPC = OBJECT_SELF;
    location lTarget = GetLocalLocation(oPC,"Arcimago");
    object oTarget;
    effect eVis2 = EffectVisualEffect(VFX_FNF_LOS_EVIL_30);
    ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eVis2, GetItemActivatedTargetLocation());
    int nDuration = 43;
    effect eDrain = SupernaturalEffect(EffectNegativeLevel(20));
    effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
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
        if(GetIsFriend(oTarget)==FALSE&& GetObjectType(oTarget) == OBJECT_TYPE_CREATURE){
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_NEGATIVE)){
                DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDrain, oTarget));
                DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}
