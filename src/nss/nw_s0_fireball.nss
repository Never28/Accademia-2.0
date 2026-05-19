//::///////////////////////////////////////////////
//:: Fireball
//:: NW_S0_Fireball
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// A fireball is a burst of flame that detonates with
// a low roar and inflicts 1d6 points of damage per
// caster level (maximum of 10d6) to all creatures
// within the area. Unattended objects also take
// damage. The explosion creates almost no pressure.
*/
//:://////////////////////////////////////////////
//:: Created By: Noel Borstad
//:: Created On: Oct 18 , 2000
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 6, 2001
//:: Last Updated By: AidanScanlan, On: April 11, 2001
//:: Last Updated By: Preston Watamaniuk, On: May 25, 2001
#include "mod_bad_dice"
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

/*
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
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_FIREBALL);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eDam;
    int nSave = SAVING_THROW_TYPE_FIRE;
    int nType = DAMAGE_TYPE_FIRE;
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
            nBonus = 40;
            break;
    }
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    //Limit Caster level for the purposes of damage
        nCasterLvl = nCasterLvl;
    //Apply the fireball explosion at the location captured above.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            if((GetSpellId() == 341) || GetSpellId() == 58)
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FIREBALL));
                //Get the distance between the explosion and the target to calculate delay
                fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
                if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                    //Roll damage for each target
                    nDamage = nNumberRandom(3,nCasterLvl*2);
                    //Resolve metamagic
                    if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    {
                        nDamage = 6 * nCasterLvl;
                    }
                    else if (nMetaMagic == METAMAGIC_EMPOWER)
                    {
                       nDamage = nDamage + nDamage / 2;
                    }
                    nDamage = nDamage + nBonus;
                    float fDamage = (IntToFloat(nDamage)/100.0)*75.0;
                    nDamage = FloatToInt(fDamage);
                    //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
                    nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, nSave);
                    //Set the damage effect
                    eDam = EffectDamage(nDamage, nType);
                    if(nDamage > 0)
                    {
                        // Apply effects to the currently selected target.
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                        //This visual effect is applied to the target object not the location as above.  This visual effect
                        //represents the flame that erupts on the target not on the ground.
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    }
                 }
             }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}

