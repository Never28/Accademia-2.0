//::///////////////////////////////////////////////
//:: Bolt: Death
//:: NW_S1_BltDeath
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creature must make a ranged touch attack to hit
    the intended target.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 11 , 2001
//:: Updated On: July 15, 2003 Georg Zoeller - Removed saving throws
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
void main()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
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
    effect eMind;
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
    effect eBolt = EffectDeath();
    if(nAppearance == APPEARANCE_TYPE_GOLEM_BONE){
        eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
        eVis = EffectVisualEffect(VFX_IMP_FEAR_S);
        eBolt = EffectFrightened();
        eBolt = EffectLinkEffects(eBolt, eMind);
    }
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BOLT_DEATH));
    //Make a saving throw check
    if(TouchAttackRanged(oTarget))
    {
            if(nAppearance == APPEARANCE_TYPE_GOLEM_BONE){
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_FEAR, OBJECT_SELF))
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBolt, oTarget,60.0);

                }
            }
            else{
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DEATH, OBJECT_SELF))
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eBolt, oTarget);
                }
            }
           //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }
}

