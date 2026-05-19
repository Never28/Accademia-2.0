//::///////////////////////////////////////////////
//:: Howl: Fear
//:: NW_S1_HowlFear
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    A howl emanates from the creature which affects
    all within 10ft unless they make a save.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 14, 2000
//:://////////////////////////////////////////////
//:: Updated By: Andrew Nobbs
//:: Updated On: FEb 26, 2003
//:: Note: Changed the faction check to GetIsEnemy
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
void main()
{
    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_IMP_FEAR_S);
    effect eHowl = EffectFrightened();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
    effect eImpact = EffectVisualEffect(VFX_FNF_HOWL_MIND);

    effect eLink = EffectLinkEffects(eHowl, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);

    float fDelay;
    int nAge = GetHitDice(OBJECT_SELF);
    int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nDamage, nDamStrike; // for level drain
    int nDuration;
    int nDC;
    int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
    int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
    nDruidLv = nMutaLv + nDruidLv;
    nMutaLv = nDruidLv/2;
    if (nMutaLv >= 1){
        nDC = 10 + nSag + nMutaLv;
        nDuration = nDruidLv;
    }
    else{
        nDC = nAge+10;
        nDuration = nAge;
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, OBJECT_SELF);
    //Get first target in spell area
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget) && oTarget != OBJECT_SELF)
        {
            fDelay = GetDistanceToObject(oTarget)/10;

            //Make a saving throw check
            if(WillSave(oTarget, nDC, SAVING_THROW_TYPE_FEAR,OBJECT_SELF)==0)
            {
                //Apply the linked effects and the VFX impact
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDruidLv)));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}

