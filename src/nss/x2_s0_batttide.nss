/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 26-02-2011
*/

// Aura di Battaglia.

#include "x0_i0_spells"

void AuraDiBattaglia(object oPC,int nTime){
    int AuraDiBattaglia_CURRENT = GetLocalInt(oPC,"AuraDiBattaglia_CURRENT");
    if(AuraDiBattaglia_CURRENT != nTime && AuraDiBattaglia_CURRENT != 0){
        AuraDiBattaglia_CURRENT = AuraDiBattaglia_CURRENT +1;
        effect eAOE = EffectVisualEffect(VFX_DUR_AURA_FIRE);
        int nLevel = GetCasterLevel(oPC);
        int nBonus = 1;
        if(nLevel>20)
            nBonus =2;
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, oPC, 6.0);
        effect ePosVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
        effect eBonAttack = EffectAttackIncrease(nBonus);
        effect eBonSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, nBonus);
        effect eBonDam = EffectDamageIncrease(nBonus, DAMAGE_TYPE_SLASHING);
        effect eBonSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, nBonus);
        effect ePosDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect ePosLink = EffectLinkEffects(eBonAttack, eBonSave);
        ePosLink = EffectLinkEffects(ePosLink, eBonDam);
        ePosLink = EffectLinkEffects(ePosLink, eBonSkill);
        ePosLink = EffectLinkEffects(ePosLink, ePosDur);
        effect eNegVis = EffectVisualEffect(VFX_IMP_DOOM);
        effect eNegAttack = EffectAttackDecrease(nBonus);
        effect eNegSave = EffectSavingThrowDecrease(SAVING_THROW_ALL, nBonus);
        effect eNegDam = EffectDamageDecrease(nBonus, DAMAGE_TYPE_SLASHING);
        effect eNegSkill = EffectSkillDecrease(SKILL_ALL_SKILLS, nBonus);
        effect eNegDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
        effect eNegLink = EffectLinkEffects(eNegAttack, eNegSave);
        eNegLink = EffectLinkEffects(eNegLink, eNegDam);
        eNegLink = EffectLinkEffects(eNegLink, eNegSkill);
        eNegLink = EffectLinkEffects(eNegLink, eNegDur);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
        while(GetIsObjectValid(oTarget)){
            if(GetIsEnemy(oTarget, oPC) == TRUE){
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eNegVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eNegLink, oTarget,6.0);
            }
            else{
                ApplyEffectToObject(DURATION_TYPE_INSTANT, ePosVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePosLink, oTarget,6.0);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
        }
        SetLocalInt(oPC,"AuraDiBattaglia_CURRENT",AuraDiBattaglia_CURRENT);
        DelayCommand(6.0,AuraDiBattaglia(oPC,nTime));
    }
    else
        DeleteLocalInt(oPC,"AuraDiBattaglia_CURRENT");
}

void main()
{
    object oPC = OBJECT_SELF;
    int AuraDiBattaglia_CURRENT = GetLocalInt(oPC,"AuraDiBattaglia_CURRENT");
    int nTime = GetCasterLevel(oPC);
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
       nTime = nTime *2;
    if(AuraDiBattaglia_CURRENT == 0){
        effect eAOE = EffectVisualEffect(VFX_DUR_AURA_FIRE);
        effect ePosVis = EffectVisualEffect(VFX_IMP_HOLY_AID);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, ePosVis, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, OBJECT_SELF, 6.0);
        SetLocalInt(oPC,"AuraDiBattaglia_CURRENT",1);
        AuraDiBattaglia(oPC,nTime);
    }
}
