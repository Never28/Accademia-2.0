//::///////////////////////////////////////////////
//:: Name x2_s1_hurlrock
//::
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Impact script for tossed boulders

    Non magical attack, so no spell resistance
    applies
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner, Georg Zoeller
//:: Created On: Sept 9/10
//:://////////////////////////////////////////////

void RockDamage(location lImpact);

#include "x2_inc_shifter"
#include "x0_i0_spells"

void main()
{
    //Do damage here...//354 for impact
    effect eImpact = EffectVisualEffect(354);
    effect eImpac1 = EffectVisualEffect(460);
    int nDamage;
    location lImpact = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lImpact);
    DelayCommand(0.2f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpac1, lImpact));
    RockDamage(lImpact);
}

void RockDamage(location lImpact)
{
    float fDelay;
    int nDamage;
    effect eDam;
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_SMALL, lImpact, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    int nAge = GetHitDice(OBJECT_SELF);
    int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nDC;
    int nAppearance = GetAppearanceType(OBJECT_SELF);
    int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
    int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
    nDruidLv = nMutaLv + nDruidLv;
    nMutaLv = nDruidLv/2;

    int nDamageAdjustment = GetAbilityModifier (ABILITY_STRENGTH,OBJECT_SELF);
    while (GetIsObjectValid(oTarget))
    {

        if (spellsIsTarget(oTarget,SPELL_TARGET_SELECTIVEHOSTILE,OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = GetDistanceBetweenLocations(lImpact, GetLocation(oTarget))/20;
            //Roll damage for each target, but doors are always killed

                if (nMutaLv >= 1){
                    nDamage = d6(nDruidLv*2);
                    nDamage = nDamage+d2(nDruidLv);
                    nDC = 10 + nSag + nMutaLv;
                }
                else{
                    nDamage = d6(nAge*2);
                    nDamage = nDamage+d2(nAge);
                    nDC = nAge+10;
                }
                float fDamage = (IntToFloat(nDamage)/100.0)*50.0;
                nDamage = FloatToInt(fDamage);
            //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_NONE);
            //Set the damage effect
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING);
            if(GetAppearanceType(OBJECT_SELF)==APPEARANCE_TYPE_GIANT_FROST||GetAppearanceType(OBJECT_SELF)==APPEARANCE_TYPE_GIANT_FROST_FEMALE)
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_COLD);
            if(nDamage > 0)
            {
                // Apply effects to the currently selected target.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                //This visual effect is applied to the target object not the location as above.  This visual effect
                //represents the flame that erupts on the target not on the ground.
                //DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lImpact, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}
