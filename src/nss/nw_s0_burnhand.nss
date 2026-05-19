//::///////////////////////////////////////////////
//:: Burning Hands
//:: NW_S0_BurnHand
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// A thin sheet of searing flame shoots from your
// outspread fingertips. You must hold your hands
// with your thumbs touching and your fingers spread
// The sheet of flame is about as thick as your thumbs.
// Any creature in the area of the flames suffers
// 1d4 points of fire damage per your caster level
// (maximum 5d4).
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 5, 2001
//:://////////////////////////////////////////////
//:: Last Updated On: April 5th, 2001
//:: VFX Pass By: Preston W, On: June 20, 2001
//:: Update Pass By: Preston W, On: July 23, 2001

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "mod_bad_dice"

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
    float fDist;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    object oTarget;
    nCasterLevel = nCasterLevel;
    if(nCasterLevel<1)
        nCasterLevel = 1;
    effect eFire;
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    //Declare and assign personal impact visual effect.
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    //Limit Maximum caster level to keep damage to spell specifications.
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 10.0, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);

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
            nBonus = 20;
            break;
    }

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Signal spell cast at event to fire.
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_BURNING_HANDS));
            //Calculate the delay time on the application of effects based on the distance
            //between the caster and the target
            fDist = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            //Make SR check, and appropriate saving throw.
            if(!MyResistSpell(OBJECT_SELF, oTarget, fDist) && oTarget != OBJECT_SELF)
            {
                nDamage = nNumberRandom(3,nCasterLevel);
                //Enter Metamagic conditions
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                     nDamage = 3 * nCasterLevel;//Damage is at max
                }
                else if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
                }
                nDamage = nDamage + nBonus;
                float fDamage = (IntToFloat(nDamage)/100.0)*75.0;
                nDamage = FloatToInt(fDamage);
                //Run the damage through the various reflex save and evasion feats
                nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, nSave);
                eFire = EffectDamage(nDamage, nType);
                if(nDamage > 0)
                {
                    // Apply effects to the currently selected target.
                    DelayCommand(fDist, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                    DelayCommand(fDist, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 10.0, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}
