//::///////////////////////////////////////////////////
//:: X0_S1_MANTSPIKE
//:: Handles the damage effects of the manticore spikes.
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 11/15/2002
//::///////////////////////////////////////////////////
#include "x0_i0_spells"

void main()
{

    int nAge = GetHitDice(OBJECT_SELF);
    int nCap,nTot,nDamage;
    int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nAppearance = GetAppearanceType(OBJECT_SELF);
    int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
    int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
    nDruidLv = nMutaLv + nDruidLv;
    nMutaLv = nDruidLv/2;
    if (nMutaLv >= 1){
        nTot = nDruidLv;
    }
    else{
        nTot = nAge;
    }
    int nMetaMagic = GetMetaMagicFeat();
    effect eMissile = EffectVisualEffect(359);
    effect eVis = EffectVisualEffect(VFX_COM_BLOOD_SPARK_SMALL);
    float fDist = 0.0;
    float fDelay = 0.0;
    float fDelay2, fTime;
    location lTarget = GetSpellTargetLocation();
    int nMissile=0;
    object oTarget;
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget)){
        if ((GetIsEnemy(oTarget)) && (oTarget != OBJECT_SELF)){
            fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
            fDelay = fDist/(3.0 * log(fDist) + 2.0);
            int i = 0;
            nDamage = d6(nTot*2);
            float fDamage = (IntToFloat(nDamage)/100.0)*50.0;
            nDamage = FloatToInt(fDamage);
            int nResult = TouchAttackRanged(oTarget, TRUE);
            DelayCommand(fDelay2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget));
            DelayCommand(fDelay2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget));
            DelayCommand(fDelay2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget));
            if (nResult > 0){
                if (nResult == 2)
                    nDamage = nDamage*2;
                fTime = fDelay;
                fDelay2 += 0.1;
                fTime += fDelay2;
                effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING);
                DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));
                DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fTime, PlaySound("cb_ht_dart1"));
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
}
