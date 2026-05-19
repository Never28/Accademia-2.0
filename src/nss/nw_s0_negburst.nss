//::///////////////////////////////////////////////
//:: Negative Energy Burst
//:: NW_S0_NegBurst
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The caster releases a burst of negative energy
    at a specified point doing 1d8 + 1 / level
    negative energy damage
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 13, 2001
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "mod_bad_dice"

void main()
{

/*d
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    int nSave = SAVING_THROW_TYPE_NEGATIVE;
    int nType = DAMAGE_TYPE_NEGATIVE;
    int nBonus;
    int nElement = GetLocalInt(OBJECT_SELF,"SapienteElementale");
    switch(nElement){
        case 1:
            nType = DAMAGE_TYPE_BLUDGEONING;
            break;
        case 2:
            nType = DAMAGE_TYPE_COLD;
            break;
        case 3:
            nType = DAMAGE_TYPE_ELECTRICAL;
            break;
        case 4:
            nType = DAMAGE_TYPE_FIRE;
            break;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nAdditionalLevelDamage;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_LOS_EVIL_20); //Replace with Negative Pulse
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eVisHeal = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eDam, eHeal;
    int nStr = nCasterLvl / 4;
    if (nStr == 0)
    {
        nStr = 1;
    }

    effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, nStr);
    effect eStr_Low = EffectAbilityDecrease(ABILITY_STRENGTH, nStr);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    effect eGood = EffectLinkEffects(eStr, eDur);
    effect eBad = EffectLinkEffects(eStr_Low, eDur2);

    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    //Apply the explosion at the location captured above.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
       if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
       {
            nDamage = nNumberRandom(3,nCasterLvl*2);
            //Resolve metamagic
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                nDamage = 6*(nCasterLvl);
            }
                else if (nMetaMagic == METAMAGIC_EMPOWER)
            {
               nDamage = nDamage + (nDamage / 2);
            }
            float fDamage = (IntToFloat(nDamage)/100.0)*20.0;
            nDamage = FloatToInt(fDamage);
            if(MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, nSave, OBJECT_SELF, fDelay))
            {
                nDamage /= 2;
            }
            //Get the distance between the explosion and the target to calculate delay
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;

            // * any undead should be healed, not just Friendlies
            int nAspect = GetAppearanceType(oTarget);
            if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD || nAspect == APPEARANCE_TYPE_SKELETON_CHIEFTAIN ||
      nAspect == APPEARANCE_TYPE_ZOMBIE_WARRIOR_2 || nAspect == APPEARANCE_TYPE_MOHRG || nAspect == APPEARANCE_TYPE_MUMMY_GREATER
      || nAspect == APPEARANCE_TYPE_VAMPIRE_MALE || nAspect == APPEARANCE_TYPE_VAMPIRE_FEMALE || nAspect == APPEARANCE_TYPE_LICH
      || nAspect == APPEARANCE_TYPE_MINDFLAYER_ALHOON || nAspect == APPEARANCE_TYPE_DEMI_LICH || nAspect== APPEARANCE_TYPE_GOLEM_BONE
      || nAspect == APPEARANCE_TYPE_DRACOLICH)
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_NEGATIVE_ENERGY_BURST, FALSE));
                //Set the heal effect
                eHeal = EffectHeal(nDamage);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
                //This visual effect is applied to the target object not the location as above.  This visual effect
                //represents the flame that erupts on the target not on the ground.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGood, oTarget));
            }
            else{
                if(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
                {
                    if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                    {
                        //Fire cast spell at event for the specified target
                        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_NEGATIVE_ENERGY_BURST));
                        //Set the damage effect
                        eDam = EffectDamage(nDamage, nType);
                        // Apply effects to the currently selected target.
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                        //This visual effect is applied to the target object not the location as above.  This visual effect
                        //represents the flame that erupts on the target not on the ground.
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBad, oTarget));
                    }
                }
            }
        }

       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget);
    }
}
