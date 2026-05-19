//::///////////////////////////////////////////////
//:: Bolt: Web
//:: NW_S1_BltWeb
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Glues a single target to the ground with
    sticky strands of webbing.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 28, 2002
//:: Updated On: July 15, 2003 Georg Zoeller - Removed saving throws
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "x2_inc_switches"
void main()
{
    object oTarget = GetSpellTargetObject();
    int nHD = GetHitDice(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_DUR_WEB);
    effect eStick = EffectEntangle();
    effect eLink = EffectLinkEffects(eVis, eStick);
    int nAge = GetHitDice(OBJECT_SELF);
    int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nDC;
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

    int nCount = (nDC) / 2;

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BOLT_WEB));
    //Make a saving throw check
    if (TouchAttackRanged(oTarget))
    {
       if( !GetHasFeat(FEAT_WOODLAND_STRIDE, oTarget) && GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_IS_INCORPOREAL) != TRUE )
       {
            if(MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC) == FALSE)
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nCount));
        }
    }
}
