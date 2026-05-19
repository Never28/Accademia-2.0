//::///////////////////////////////////////////////
//:: Pulse: Negative
//:: NW_S1_PulsDeath
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    A wave of energy emanates from the creature which affects
    all within 10ft.  Damage can be reduced by half for all
    damaging variants.  Undead are healed.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 14, 2000
//:://////////////////////////////////////////////

void main()
{
    //Declare major variables
    int nDamage;
    float fDelay;
    effect eVis = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eVis2 = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eHowl;
    int nAge = GetHitDice(OBJECT_SELF);
    int nDC;
    int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nAppearance = GetAppearanceType(OBJECT_SELF);
    int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
    int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
    nDruidLv = nMutaLv + nDruidLv;
    nMutaLv = nDruidLv/2;
            if (nMutaLv >= 1){
                    nDamage = d8(nDruidLv*2);
                    nDamage = nDamage + d2(nDruidLv);
                    nDC = 10 + nSag + nMutaLv;
                }
                else{
                    nDamage = d8(nAge*2);
                    nDamage = nDamage + d2(nAge);
                nDC = nAge+10;
            }
            float fDamage = (IntToFloat(nDamage)/100.0)*75.0;
            nDamage = FloatToInt(fDamage);
    effect eImpact = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, OBJECT_SELF);
    //Get first target in spell area
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if(oTarget != OBJECT_SELF)
        {
            //Determine effect delay
            fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            //Roll the amount to heal or damage
            //If the target is undead
            if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
            {
                //Make a faction check
                if(GetIsFriend(oTarget))
                {
                    //Fire cast spell at event for the specified target
                    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_PULSE_HOLY, FALSE));
                    //Set heal effect
                    eHowl = EffectHeal(nDamage);
                    //Apply the VFX impact and effects
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHowl, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
            }
            else
            {
                int nAspect = GetAppearanceType(oTarget);
                if(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD && nAspect != APPEARANCE_TYPE_SKELETON_CHIEFTAIN &&
      nAspect != APPEARANCE_TYPE_ZOMBIE_WARRIOR_2 && nAspect != APPEARANCE_TYPE_MOHRG && nAspect != APPEARANCE_TYPE_MUMMY_GREATER
      && nAspect != APPEARANCE_TYPE_VAMPIRE_MALE && nAspect != APPEARANCE_TYPE_VAMPIRE_FEMALE && nAspect != APPEARANCE_TYPE_LICH
      && nAspect != APPEARANCE_TYPE_MINDFLAYER_ALHOON && nAspect != APPEARANCE_TYPE_DEMI_LICH && nAspect!= APPEARANCE_TYPE_GOLEM_BONE
      && nAspect != APPEARANCE_TYPE_DRACOLICH)
                {
                    //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
                    nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_NEGATIVE);
                    //Set damage effect
                    eHowl = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                    if(nDamage > 0)
                    {
                        //Fire cast spell at event for the specified target
                        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_PULSE_HOLY));
                        //Apply the VFX impact and effects
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHowl, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                    }
                }
            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(OBJECT_SELF));
    }
}
