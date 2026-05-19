/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 29-06-2009
*/

// Soffio Drago Ombra.

#include "NW_I0_SPELLS"

void main()
{
    //Declare major variables
    int nAge = GetHitDice(OBJECT_SELF);
    int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nDamage, nDamStrike; // for level drain
    int nDamage2, nDamStrike2; // for negative energy
    int nDC;
    int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
    int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
    nMutaLv = (nMutaLv+nDruidLv)/2;
    nDruidLv = nMutaLv + nDruidLv;

    float fDelay;
    object oTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    PlayDragonBattleCry();
    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 14.0, GetSpellTargetLocation(), TRUE);
    while(GetIsObjectValid(oTarget))
    {
        if(oTarget != OBJECT_SELF && !GetIsReactionTypeFriendly(oTarget))
        {
            if (nMutaLv >= 1){
                nDamage2 = d8(nDruidLv*2);
                nDamage2 = nDamage2 + d2(nDruidLv);
                nDC = nDruidLv+10;
                nDamage = nDruidLv/4;
            }
            else{
                nDamage2 = d8(nAge*2);
                nDamage2 = nDamage2 + d2(nAge);
                nDC = nAge+10;
                nDamage = nAge/4;
            }
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_DRAGON_BREATH_NEGATIVE));

            nDamStrike2 = GetReflexAdjustedDamage(nDamage2,oTarget,nDC,SAVING_THROW_TYPE_NEGATIVE,OBJECT_SELF);

            if (nDamStrike2 > 0)
            {
                //Set Damage and VFX
                effect eBreath = EffectNegativeLevel(nDamage);
                effect eBreath2 = EffectDamage(nDamStrike2, DAMAGE_TYPE_NEGATIVE);
                fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
                //Apply the VFX impact and effects
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBreath, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBreath2, oTarget));
             }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 14.0, GetSpellTargetLocation(), TRUE);
    }
}


