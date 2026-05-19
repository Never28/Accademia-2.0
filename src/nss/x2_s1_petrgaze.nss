//::///////////////////////////////////////////////////
//:: X0_S1_PETRGAZE
//:: Petrification gaze monster ability.
//:: Fortitude save (DC 15) or be turned to stone permanently.
//:: This will be changed to a temporary effect.
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 11/14/2002
//::///////////////////////////////////////////////////
//:: Used by Basilisk


#include "x0_i0_spells"

void main()
{
    object oTarget = GetSpellTargetObject();
    int nAge = GetHitDice(OBJECT_SELF);
    int nDC;
    int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
    int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
    nDruidLv = nMutaLv + nDruidLv;
    nMutaLv = nDruidLv/2;
    if (nMutaLv >= 1){
        nDC = 10 + nSag + nMutaLv;
    }
    else{
        nDC = nAge+10;
    }


    location lTargetLocation = GetSpellTargetLocation();

    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 10.0, lTargetLocation, TRUE);
    while(GetIsObjectValid(oTarget))
    {
        float fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
        int nSpellID = GetSpellId();
        object oSelf = OBJECT_SELF;

        DelayCommand(fDelay,  DoPetrification(oSelf, oTarget, nSpellID, nDC));
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 10.0, lTargetLocation, TRUE);
    }



}

