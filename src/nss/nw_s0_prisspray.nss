//::///////////////////////////////////////////////
//:: Prismatic Spray
//:: [NW_S0_PrisSpray.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Sends out a prismatic cone that has a random
//:: effect for each target struck.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Dec 19, 2000
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
//:: Last Updated By: Aidan Scanlan On: April 11, 2001
//:: Last Updated By: Preston Watamaniuk, On: June 11, 2001

int ApplyPrismaticEffect(int nEffect, object oTarget);

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
    object oTarget;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    int nMetaMagic = GetMetaMagicFeat();
    int nRandom;
    int nHD;
    int nVisual;
    effect eVisual;
    int bTwoEffects;
    //Set the delay to apply to effects based on the distance to the target
    float fDelay = 0.5 + GetDistanceBetween(OBJECT_SELF, oTarget)/20;
    //Get first target in the spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 11.0, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_PRISMATIC_SPRAY));
            //Make an SR check
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay) && (oTarget != OBJECT_SELF))
            {
                //Blind the target if they are less than 9 HD
                nHD = GetHitDice(oTarget);
                if (nHD <= 8)
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBlindness(), oTarget, RoundsToSeconds(nCasterLevel));
                }
                //Determine if 1 or 2 effects are going to be applied
                nRandom = d8();
                if(nRandom == 8)
                {
                    //Get the visual effect
                    nVisual = ApplyPrismaticEffect(Random(7) + 1, oTarget);
                    nVisual = ApplyPrismaticEffect(Random(7) + 1, oTarget);
                }
                else
                {
                    //Get the visual effect
                    nVisual = ApplyPrismaticEffect(nRandom, oTarget);
                }
                //Set the visual effect
                if(nVisual != 0)
                {
                    eVisual = EffectVisualEffect(nVisual);
                    //Apply the visual effect
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget));
                }
            }
        }
        //Get next target in the spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 11.0, GetSpellTargetLocation());
    }
}

///////////////////////////////////////////////////////////////////////////////
//  ApplyPrismaticEffect
///////////////////////////////////////////////////////////////////////////////
/*  Given a reference integer and a target, this function will apply the effect
    of corresponding prismatic cone to the target.  To have any effect the
    reference integer (nEffect) must be from 1 to 7.*/
///////////////////////////////////////////////////////////////////////////////
//  Created By: Aidan Scanlan On: April 11, 2001
///////////////////////////////////////////////////////////////////////////////

int ApplyPrismaticEffect(int nEffect, object oTarget)
{
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
    if(nCasterLevel>20)
        nDC = nDC +5;
    nCasterLevel=nCasterLevel;
    int nDamage;
    effect ePrism;
    effect eVis;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink;
    int nVis;
    float fDamage;
    float fDelay = 0.5 + GetDistanceBetween(OBJECT_SELF, oTarget)/20;
    //Based on the random number passed in, apply the appropriate effect and set the visual to
    //the correct constant
    nDamage = nNumberRandom(7,nCasterLevel*2);
    fDamage = (IntToFloat(nDamage)/100.0)*75.0;
    nDamage = FloatToInt(fDamage);
    switch(nEffect)
    {
        case 1://fire
            nVis = VFX_IMP_FLAME_S;
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC,SAVING_THROW_TYPE_FIRE);
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
        break;
        case 2: //Acid
            nVis = VFX_IMP_ACID_L;
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC,SAVING_THROW_TYPE_ACID);
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
        break;
        case 3: //Electricity
            nVis = VFX_IMP_LIGHTNING_S;
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC,SAVING_THROW_TYPE_ELECTRICITY);
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
        break;
        case 4: //Poison
            nVis = VFX_IMP_SONIC;
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC,SAVING_THROW_TYPE_SONIC);
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
        break;
        case 5: //Paralyze
            {
                effect eDur2 = EffectVisualEffect(VFX_DUR_PARALYZED);
                if (MySavingThrow(SAVING_THROW_FORT, oTarget, nDC) == 0)
                {
                    ePrism = EffectParalyze();
                    eLink = EffectLinkEffects(eDur, ePrism);
                    eLink = EffectLinkEffects(eLink, eDur2);
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(10)));
                }
            }
        break;
        case 6: //Confusion
            nVis = VFX_IMP_FROST_S;
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC,SAVING_THROW_TYPE_COLD);
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
        break;
        case 7: //Death
            {
                if (!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_DEATH, OBJECT_SELF, fDelay))
                {
                    //nVis = VFX_IMP_DEATH;
                    ePrism = EffectDeath();
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
                }
            }
        break;
    }
    return nVis;
}

