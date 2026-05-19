//::///////////////////////////////////////////////
//:: Purple Dragon Knight - Inspire Courage
//:: x3_s2_pdk_inspir.nss
//:://////////////////////////////////////////////
//:: Increase attack, damage, saving throws to
//:: friends in area of spell
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
    int nBonus = nPurple/8;
    if(nPurple<1)
        nPurple = 1;
    effect eAttack = EffectAttackIncrease(nBonus);
    int nDam = nPurple/2;
    if(nDam == 1)
        nDam = DAMAGE_BONUS_1;
    else if(nDam == 2)
        nDam = DAMAGE_BONUS_2;
    else if(nDam == 3)
        nDam = DAMAGE_BONUS_3;
    else if(nDam == 4)
        nDam = DAMAGE_BONUS_4;
    else if(nDam == 5)
        nDam = DAMAGE_BONUS_5;
    else if(nDam == 6)
        nDam = DAMAGE_BONUS_6;
    else if(nDam == 7)
        nDam = DAMAGE_BONUS_7;
    else if(nDam == 8)
        nDam = DAMAGE_BONUS_8;
    else if(nDam == 9)
        nDam = DAMAGE_BONUS_9;
    else if(nDam == 10)
        nDam = DAMAGE_BONUS_10;
    else if(nDam == 11)
        nDam = DAMAGE_BONUS_11;
    else if(nDam == 12)
        nDam = DAMAGE_BONUS_12;
    else if(nDam == 13)
        nDam = DAMAGE_BONUS_13;
    else if(nDam == 14)
        nDam = DAMAGE_BONUS_14;
    else if(nDam == 15)
        nDam = DAMAGE_BONUS_15;
    else if(nDam == 16)
        nDam = DAMAGE_BONUS_16;
    else if(nDam == 17)
        nDam = DAMAGE_BONUS_17;
    else if(nDam == 18)
        nDam = DAMAGE_BONUS_18;
    else if(nDam == 19)
        nDam = DAMAGE_BONUS_19;
    else if(nDam == 20)
        nDam = DAMAGE_BONUS_20;
    effect eDamage = EffectDamageIncrease(nDam, DAMAGE_TYPE_BLUDGEONING);// Increased damage effect
    effect eLink = EffectLinkEffects(eAttack, eDamage);// link effects

    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_WILL, nBonus, SAVING_THROW_TYPE_MIND_SPELLS);// Saving throw increase
    eLink = EffectLinkEffects(eLink, eSave);// link in saving throw
    eLink = ExtraordinaryEffect(eLink);// make effects ExtraOrdinary

    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);// Get VFX
    eLink = EffectLinkEffects(eLink, eDur);// link VFXs

    effect eImpact = EffectVisualEffect(VFX_IMP_PDK_GENERIC_HEAD_HIT);// Get VFX

    // Apply effect at location
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PDK_INSPIRE_COURAGE), OBJECT_SELF);
    DelayCommand(0.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PDK_GENERIC_PULSE), OBJECT_SELF));

    // Get first target
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));

    // Keep processing while oTarget is valid
    while(GetIsObjectValid(oTarget))
    {
         // * GZ Oct 2003: If we are silenced, we can not benefit from bard song
         if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) && !GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
         {
            if(oTarget == OBJECT_SELF)
            {
                // oTarget is caster, apply effects
                DelayCommand(0.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(eLink), oTarget, RoundsToSeconds(nDuration));

            }
            else if(GetIsNeutral(oTarget) || GetIsFriend(oTarget))
            {
                // oTarget is a friend, apply effects
                DelayCommand(0.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
            }
        }

        // Get next object in the sphere
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}
