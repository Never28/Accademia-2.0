//::///////////////////////////////////////////////
//:: Howl of Doom
//:: NW_S1_HowlDoom
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All those that fail the save are struck with the
    doom effect
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 8, 2002
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"

void main()
{
    int nAge = GetHitDice(OBJECT_SELF);
    int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nDamage, nDamStrike; // for level drain
    int nDC;
    int nDuration;
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
    effect eLink = CreateDoomEffectsLink();
    effect eVis = EffectVisualEffect(VFX_IMP_DOOM);
    effect eImpact = EffectVisualEffect(VFX_FNF_HOWL_ODD);
    float fDelay;
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, OBJECT_SELF);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    //Get first target in spell area
    while(GetIsObjectValid(oTarget))
    {
        if(!GetIsReactionTypeFriendly(oTarget) && !GetIsFriend(oTarget) && oTarget != OBJECT_SELF)
        {
            fDelay = GetDistanceToObject(oTarget)/10;
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_HOWL_DOOM));
            if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC))
            {
                //Apply the VFX impact and effects
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}
