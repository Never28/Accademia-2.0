//::///////////////////////////////////////////////
//:: Cone: Cold
//:: NW_S1_ConeCold
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    A cone of damage eminated from the monster.  Does
    a set amount of damage based upon the creatures HD
    and can be halved with a Reflex Save.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 11, 2001
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
void main()
{
    //Declare major variables
    int nHD = GetHitDice(OBJECT_SELF);
    int nDamage;
    int nAge = GetHitDice(OBJECT_SELF);
    int nDice = nHD / 3;
    int nDC = 10 + (nAge);
    float fDelay;

    if(nDice == 0)
    {
        nDice = 1;
    }
    nDice *= 2;

    location lTargetLocation = GetSpellTargetLocation();
    object oTarget;
    effect eCone;
    effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);

    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 10.0, lTargetLocation, TRUE);
    //Get first target in spell area
    while(GetIsObjectValid(oTarget))
    {
        if(!GetIsReactionTypeFriendly(oTarget) && oTarget != OBJECT_SELF)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_CONE_COLD));
            //Determine effect delay
            fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
            nDamage = d4(nAge*2);
            nDamage = nDamage+d2(nAge);
            nDC = nAge+10;
            float fDamage = (IntToFloat(nDamage)/100.0)*75.0;
            nDamage = FloatToInt(fDamage);
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC,SAVING_THROW_TYPE_COLD);
            //Set damage effect
            eCone = EffectDamage(nDamage, DAMAGE_TYPE_COLD);

            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            if(nDamage > 0)
            {
                //Apply the VFX impact and effects
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eCone, oTarget));
            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 11.0, lTargetLocation, TRUE);
    }
}


