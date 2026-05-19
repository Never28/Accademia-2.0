//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 8, 2002
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
void main()
{
    //Declare major variables
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
    effect eVis = EffectVisualEffect(VFX_IMP_FEAR_S);
    effect eFear = EffectFrightened();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    //Link the fear and mind effects
    effect eLink = EffectLinkEffects(eFear, eMind);
    eLink = EffectLinkEffects(eLink, eDur);
    object oTarget;
    float fDelay;
    //Get first target in the spell cone
    oTarget = GetFirstObjectInShape(SHAPE_CONE, 10.0, GetSpellTargetLocation(), TRUE);
    while(GetIsObjectValid(oTarget)==TRUE){
        //Make faction check
        if(oTarget != OBJECT_SELF && !GetIsReactionTypeFriendly(oTarget)){
            fDelay = GetDistanceToObject(oTarget)/20;
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_GAZE_FEAR));
            //Make a will save
            if(WillSave(oTarget, nDC, SAVING_THROW_TYPE_FEAR,OBJECT_SELF)==0)
            {
                //Apply the linked effects and the VFX impact
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDruidLv)));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
        //Get next target in the spell cone
        oTarget = GetNextObjectInShape(SHAPE_CONE, 10.0, GetSpellTargetLocation(), TRUE);
    }
}
