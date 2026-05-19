/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 29-06-2009
*/

// Soffio Pietrificazione Drago.

#include "x0_i0_spells"

void main()
{
    //Declare major variables
    int nAge = GetLevelByClass(CLASS_TYPE_DRAGON,OBJECT_SELF);
    int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nDamage, nDamStrike; // for level drain
    int nDC;
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
    object oTarget = GetSpellTargetObject();
    int nHitDice = GetHitDice(OBJECT_SELF);


    location lTargetLocation = GetSpellTargetLocation();

    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 11.0, lTargetLocation, TRUE);
    while(GetIsObjectValid(oTarget))
    {
        float fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
        int nSpellID = GetSpellId();
        object oSelf = OBJECT_SELF;
        DelayCommand(fDelay, DoPetrification(OBJECT_SELF, oTarget, nSpellID, nDC));
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 11.0, lTargetLocation, TRUE);
    }
}



