

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
                    nDamage = d6(nDruidLv*2);
                    nDamage = nDamage + d2(nDruidLv);
                    nDC = 10 + nSag + nMutaLv;
                }
                else{
                    nDamage = d6(nAge*2);
                    nDamage = nDamage + d2(nAge);
                    nDC = 10 + nAge;
    }
    float fDamage = (IntToFloat(nDamage)/100.0)*60.0;
    nDamage = FloatToInt(fDamage);
    effect eBolt;
    effect eVis = EffectBeam(VFX_BEAM_EVIL, OBJECT_SELF, BODY_NODE_CHEST);
    effect eDur = EffectVisualEffect(VFX_IMP_DESTRUCTION);

    int nTouch = TouchAttackRanged(oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget,1.0);
    if(nTouch > 0)
    {
        //Set damage effect
        eBolt = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
            effect eLink = EffectLinkEffects(eBolt,eDur);
        if(nDamage > 0)
        {
            //Apply the VFX impact and effects
            DelayCommand(1.1,ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget));

        }
   }
}
