#include "NW_I0_SPELLS"

void SoffioMorte(object oTarget, int nDC);

void SoffioMorte(object oTarget, int nDC){
    effect eDeath = EffectDeath();
    if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_POISON, OBJECT_SELF))
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDeath, oTarget,RoundsToSeconds(nDC));
}



void main()
{
    //Declare major variables
    object oTarget = GetItemActivatedTarget();
    location lTargetLocation = GetSpellTargetLocation();
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
        nDC = nAge+10;
    }
    effect eVis2 = EffectVisualEffect(VFX_DUR_AURA_POISON );
    effect eDur = EffectVisualEffect(VFX_IMP_POISON_L);
    effect eVenom = EffectAbilityDecrease(ABILITY_CONSTITUTION,6);
    effect eLink = EffectLinkEffects(eVis2,eVenom);
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 10.0, lTargetLocation, TRUE);
    while(GetIsObjectValid(oTarget))
    {
        if(!GetIsReactionTypeFriendly(oTarget) && oTarget != OBJECT_SELF)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_GOLEM_BREATH_GAS));
            //Determine effect delay
            float fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            //Apply poison effect
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_POISON, OBJECT_SELF)){
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget,RoundsToSeconds(nDC));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDur, oTarget));
                DelayCommand(12.0,SoffioMorte(oTarget,nDC));
            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 10.0, lTargetLocation, TRUE);
    }
}


