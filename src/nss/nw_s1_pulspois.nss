
#include "NW_I0_SPELLS"
void main()
{
    object oTarget = GetSpellTargetObject();
    int nAge = GetHitDice(OBJECT_SELF);
    int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nDC;
    int nAppearance = GetAppearanceType(OBJECT_SELF);
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
    int nModify = (nDC-10)/10;
    if(nModify == 0)
        nModify = 1;
    nModify = 3*nModify;
    effect eStunned = EffectStunned();
    effect eVis = EffectVisualEffect(VFX_IMP_PULSE_NATURE);
    effect eVis2 = EffectVisualEffect(VFX_DUR_AURA_POISON );
    effect eVis3 = EffectVisualEffect(VFX_IMP_STUN);
    effect eVenom = EffectAbilityDecrease(ABILITY_CONSTITUTION,nModify);
    effect eLink = EffectLinkEffects(eVis2,eVenom);
    effect eLink2 = EffectLinkEffects(eVis3,eStunned);
    int nTouch = 1;
    if(GetIsEnemy(oTarget,OBJECT_SELF) == TRUE && oTarget != OBJECT_SELF){
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_PULSE_POISON));
        if (nTouch > 0){
                if (!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_POISON) && GetIsImmune(oTarget,IMMUNITY_TYPE_POISON)==FALSE){
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink2, oTarget,IntToFloat(nModify));
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    DelayCommand(10.0,AssignCommand(OBJECT_SELF,ActionCastSpellAtObject(SPELL_POISON, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
                }
        }
    }
}


