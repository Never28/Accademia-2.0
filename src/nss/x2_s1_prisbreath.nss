/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 29-06-2009
*/

// Soffio Prismatico Drago.

#include "X0_I0_SPELLS"

int ApplyPrismaticEffect(int nEffect, object oTarget);

void main()
{
    //Declare major variables
    int nAge = GetLevelByClass(CLASS_TYPE_DRAGON,OBJECT_SELF);
    int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nDamage, nDamStrike; // for level drain
    int nDC;
    int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
    int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
    if(nDruidLv>=30)
        nDruidLv = 30;
    if(nDruidLv>=nMutaLv)
        nMutaLv = nDruidLv;
    if (nMutaLv >= 20){
        nDamage = d10(nMutaLv);
        nDC = nSag + nMutaLv;
    }
    else{
        nDamage = d10(nAge);
        nDC = nAge+10;
    }

    int nRandom;
    int nHD;
    int nVisual;
    effect eVisual;
    int bTwoEffects;
    object oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 20.0, GetSpellTargetLocation());
    float fDelay = 0.5 + GetDistanceBetween(OBJECT_SELF, oTarget)/20;

    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                nRandom = d8();
                nVisual = ApplyPrismaticEffect(nRandom, oTarget);
                //Set the visual effect
                if(nVisual != 0)
                {
                    eVisual = EffectVisualEffect(nVisual);
                    //Apply the visual effect
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget));
                }
        }
        //Get next target in the spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 20.0, GetSpellTargetLocation());
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
    int nAge = GetLevelByClass(CLASS_TYPE_DRAGON,OBJECT_SELF);
    int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nDamage, nDamStrike; // for level drain
    int nDC;
    int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
    int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
    if(nDruidLv>=30)
        nDruidLv = 30;
    if(nDruidLv>=nMutaLv)
        nMutaLv = nDruidLv;
    if (nMutaLv >= 20){
        nDamage = d10(nMutaLv);
        nDC = nSag + nMutaLv;
    }
    else{
        nDamage = d10(nAge);
        nDC = nAge+10;
    }
    effect ePrism;
    effect eVis;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink;
    int nVis;
    float fDelay = 0.5 + GetDistanceBetween(OBJECT_SELF, oTarget)/20;
    switch(nEffect)
    {
        case 1://fire
            nDamage = 200;
            nVis = VFX_IMP_FLAME_S;
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC,SAVING_THROW_TYPE_FIRE);
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
        break;
        case 2: //Acid
            nDamage = 200;
            nVis = VFX_IMP_ACID_L;
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC,SAVING_THROW_TYPE_ACID);
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
        break;
        case 3: //Electricity
            nDamage = 200;
            nVis = VFX_IMP_LIGHTNING_S;
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC,SAVING_THROW_TYPE_ELECTRICITY);
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
        break;
        case 4: //Cold
            nDamage = 200;
            nVis = VFX_IMP_FROST_L;
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC,SAVING_THROW_TYPE_COLD);
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_COLD);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
        break;
        case 5:
            nDamage = 200;
            nVis = VFX_IMP_SONIC;
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC,SAVING_THROW_TYPE_SONIC);
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
        break;
        case 6: //Paralyze
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
        case 7: //Confusion
            {
                effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
                ePrism = EffectConfused();
                eLink = EffectLinkEffects(eMind, ePrism);
                eLink = EffectLinkEffects(eLink, eDur);

                if (!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF, fDelay))
                {
                    nVis = VFX_IMP_CONFUSION_S;
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(10)));
                }
            }
        break;
        case 8: //Death
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

