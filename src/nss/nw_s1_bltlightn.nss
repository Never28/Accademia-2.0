

#include "NW_I0_SPELLS"
void main()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nDamage, nDamStrike; // for level drain
    int nAge = GetHitDice(OBJECT_SELF);
    int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nDC;
    int nAppearance = GetAppearanceType(OBJECT_SELF);
    int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
    int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
    nDruidLv = nMutaLv + nDruidLv;
    nMutaLv = nDruidLv/2;
    if (nMutaLv >= 1){
        nDamage = d8(nDruidLv*2);
        nDamage = nDamage + d2(nDruidLv);
        nDC = 10 + nSag + nMutaLv;
    }
    else{
        nDamage = d8(nAge*2);
        nDamage = nDamage + d2(nAge);
        nDC = nAge+10;
    }
    float fDamage = (IntToFloat(nDamage)/100.0)*65.0;
    nDamage = FloatToInt(fDamage);
    effect eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
    effect eBolt;
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BOLT_LIGHTNING));
    //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
    //nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC,SAVING_THROW_TYPE_ACID);
    //Make a ranged touch attack
    int nTouch = TouchAttackRanged(oTarget);
    if(nTouch > 0)
    {
        //Set damage effect
        eBolt = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
        if(nDamage > 0)
        {
            //Apply the VFX impact and effects
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eBolt, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }
}
