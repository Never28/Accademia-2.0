

#include "NW_I0_SPELLS"
void main()
{
    //Declare major variables
    object oTarget = GetItemActivatedTarget();
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
    effect eSleep =  EffectSleep();
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);
    effect eLink = EffectLinkEffects(eSleep, eMind);
    eLink = EffectLinkEffects(eLink, eDur);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    int nTouch = TouchAttackRanged(oTarget);
    if(nTouch > 0)
    {
            if(!/*WillSave*/MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF))
            {
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget,RoundsToSeconds(nDC));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
    }
}
