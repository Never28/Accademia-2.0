//::///////////////////////////////////////////////
//:: Purple Dragon Knight - Rallying Cry
//:: x3_s2_pdk_rally.nss
//:://////////////////////////////////////////////
//:: Increase attack & movement for friends in
//:: area of spell
//:://////////////////////////////////////////////
//:: Created By: Stratovarius
//:: Created On: Sept 22, 2005
//:://////////////////////////////////////////////
/*
    Modified By : gaoneng erick
    Modified On : may 6, 2006
    added custom vfx
*/

#include "x0_i0_spells"

void main()
{
    if (GetHasEffect(EFFECT_TYPE_SILENCE,OBJECT_SELF)){
        FloatingTextStrRefOnCreature(85764,OBJECT_SELF);
        return;
    }

    int nPurple = GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,OBJECT_SELF) + GetLevelByClass(CLASS_TYPE_FIGHTER, OBJECT_SELF);
    int nDuration = nPurple*2;
    int nBonus = nPurple /8;
    effect eAttack = EffectAttackIncrease(nBonus);
    effect eSpeed = EffectMovementSpeedIncrease((nPurple/2)*10);
    effect eLink = EffectLinkEffects(eAttack, eSpeed);
    eLink = ExtraordinaryEffect(eLink);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    eLink = EffectLinkEffects(eLink, eDur);
    effect eImpact = EffectVisualEffect(VFX_IMP_PDK_GENERIC_HEAD_HIT);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PDK_RALLYING_CRY), OBJECT_SELF);
    DelayCommand(0.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PDK_GENERIC_PULSE), OBJECT_SELF));
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget)){
         if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) && !GetHasEffect(EFFECT_TYPE_DEAF,oTarget)){
            if(oTarget == OBJECT_SELF)
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(eLink), oTarget, RoundsToSeconds(nDuration));
            else if(GetIsNeutral(oTarget) || GetIsFriend(oTarget)){
                DelayCommand(0.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}
