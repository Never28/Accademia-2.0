#include "NW_I0_SPELLS"
void main()
{
    //Declare major variables
    object oTarget = GetItemActivatedTarget();
    int nAge = GetHitDice(OBJECT_SELF);
    int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nDamage, nDamStrike; // for level drain
    int nDC,nDuration;
    int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
    int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
    nDruidLv = nMutaLv + nDruidLv;
    nMutaLv = nDruidLv/2;
    if (nMutaLv >= 1){
        nDamage = d8(nDruidLv*2);
        nDC = 10 + nSag + nMutaLv;
        nDuration = nDruidLv;
    }
    else{
        nDamage = d8(nAge*2);
        nDC = nAge+10;
        nDuration = nAge;
    }
    float fDamage = (IntToFloat(nDamage)/100.0)*20.0;
    nDamage = FloatToInt(fDamage);
    effect eParal = EffectParalyze();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eDur3 = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
    effect eLink = EffectLinkEffects(eDur2, eDur);
    eLink = EffectLinkEffects(eLink, eParal);
    eLink = EffectLinkEffects(eLink, eDur3);
    effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eRay = EffectBeam(VFX_BEAM_HOLY, OBJECT_SELF, BODY_NODE_HAND);
    if(!GetIsReactionTypeFriendly(oTarget)){
        if (!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC)){
            effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
            if(nDamage > 0){
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
            }
        }
        else{
            effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
            if(nDamage > 0){
                DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
            }
        }
    }
}

