//::///////////////////////////////////////////////
//:: Pulse Drown
//:: NW_S1_PulsDrwn
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    CHANGED JANUARY 2003
     - does an actual 'drown spell' on each target
     in the area of effect.
     - Each use of this spells consumes 50% of the
     elementals hit points.

*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watmaniuk
//:: Created On: April 15, 2002
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
void Drown(object oTarget, int nDC)
{
    object oArea = GetArea(OBJECT_SELF);
    string sArea = GetStringLeft(GetTag(oArea),7);
    if(sArea!="dun_che"){
        int nDamage = GetCurrentHitPoints(OBJECT_SELF);
        nDamage = FloatToInt(nDamage * 0.9);
        effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDam, OBJECT_SELF);
    }
    effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);
    // * certain racial types are immune
    if ((GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT)
     &&(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
     &&(GetRacialType(oTarget) != RACIAL_TYPE_ELEMENTAL))
    {
        //Make a fortitude save
        if(MySavingThrow(SAVING_THROW_FORT, oTarget, nDC) == FALSE)
        {
            //Apply the VFX impact and damage effect
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            //Set damage effect to kill the target
            int nDamage2 = GetCurrentHitPoints(oTarget);
            nDamage2 = FloatToInt(nDamage2 * 0.9);
            effect eDam2 = EffectDamage(nDamage2, DAMAGE_TYPE_MAGICAL);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDam2, oTarget);

         }
    }
}
void main ()
{
    //Declare major variables
    object oTarget;
    int bSave = FALSE;
    int nIdx;
    int nAge = GetHitDice(OBJECT_SELF);
    int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nDC;
    int nAppearance = GetAppearanceType(OBJECT_SELF);
    int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
    int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
    nDruidLv = nMutaLv + nDruidLv;
    nMutaLv = nDruidLv/2;
    if (nMutaLv >= 1){
        nDC = 10 + nSag + nMutaLv;
    }
    else{
        nDC = nAge+10;
    }

    effect eImpact = EffectVisualEffect(VFX_IMP_PULSE_WATER);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, OBJECT_SELF);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget) == TRUE)
    {
        if(!GetIsReactionTypeFriendly(oTarget) && oTarget != OBJECT_SELF)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_PULSE_DROWN));
            Drown(oTarget,nDC);
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(OBJECT_SELF));
    }
}


