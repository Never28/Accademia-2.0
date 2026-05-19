

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
    effect eBolt= EffectCharmed();
    effect eVis = EffectBeam(VFX_BEAM_MIND, OBJECT_SELF, BODY_NODE_CHEST);
    effect eDur = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DOMINATED );
    effect eLink = EffectLinkEffects(eBolt,eDur);
    int nTouch = TouchAttackRanged(oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget,1.0);
    if(nTouch > 0)
    {
            if(!/*WillSave*/MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF))
            {
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget,RoundsToSeconds(nDC));

            }
    }
}
