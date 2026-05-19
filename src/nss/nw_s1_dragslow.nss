/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 29-06-2009
*/

// Soffio Lentezza Drago.

#include "NW_I0_SPELLS"

void main()
{
    int nFor = GetAbilityModifier(ABILITY_STRENGTH,OBJECT_SELF);
    int nDrak = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,OBJECT_SELF);
    int nAge = GetHitDice(OBJECT_SELF);
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
        if(nDrak>=1){
            if(nDrak<10)
                nDC = 10 +nDrak;
            else if(nDrak<20)
                nDC = 15 + nDrak;
            else if(nDrak<=30)
                nDC = 20 + nDrak;
        }
        else
            nDC = nAge+10;
    }
    float fDelay;
    object oTarget;

    int nCount = d6(2);
    effect eBreath = EffectSlow();
    effect eVis = EffectVisualEffect(VFX_IMP_SLOW);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eBreath, eDur);

    PlayDragonBattleCry();
    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 14.0, GetSpellTargetLocation(), TRUE);
    while(GetIsObjectValid(oTarget))
    {
        if(oTarget != OBJECT_SELF && !GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_DRAGON_BREATH_SLOW));
            //Determine the effect delay time
            fDelay = GetDistanceBetween(oTarget, OBJECT_SELF)/20;
            //Make a saving throw check
            if(!/*ReflexSave*/MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC, SAVING_THROW_TYPE_NONE, OBJECT_SELF, fDelay))
            {
                //Apply the VFX impact and effects
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nCount)));
            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 14.0, GetSpellTargetLocation(), TRUE);
    }
}


