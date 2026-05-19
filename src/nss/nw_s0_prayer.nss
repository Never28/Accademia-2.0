/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 07-08-2009
*/

// Funzione per Preghiera.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget;
    int nDuration = GetCasterLevel(OBJECT_SELF);
    effect ePosVis = EffectVisualEffect(VFX_IMP_HOLY_AID);
    effect eNegVis = EffectVisualEffect(VFX_IMP_DOOM);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    int nBonus = 1;
    if(nDuration>20)
        nBonus = 2;
    effect eBonAttack = EffectAttackIncrease(nBonus);
    effect eBonSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, nBonus);
    effect eBonDam = EffectDamageIncrease(nBonus, DAMAGE_TYPE_SLASHING);
    effect eBonSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, nBonus);
    effect ePosDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect ePosLink = EffectLinkEffects(eBonAttack, eBonSave);
    ePosLink = EffectLinkEffects(ePosLink, eBonDam);
    ePosLink = EffectLinkEffects(ePosLink, eBonSkill);
    ePosLink = EffectLinkEffects(ePosLink, ePosDur);
    effect eNegAttack = EffectAttackDecrease(nBonus);
    effect eNegSave = EffectSavingThrowDecrease(SAVING_THROW_ALL, nBonus);
    effect eNegDam = EffectDamageDecrease(nBonus, DAMAGE_TYPE_SLASHING);
    effect eNegSkill = EffectSkillDecrease(SKILL_ALL_SKILLS, nBonus);
    effect eNegDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eNegLink = EffectLinkEffects(eNegAttack, eNegSave);
    eNegLink = EffectLinkEffects(eNegLink, eNegDam);
    eNegLink = EffectLinkEffects(eNegLink, eNegSkill);
    eNegLink = EffectLinkEffects(eNegLink, eNegDur);
    int nLevel = nDuration;
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration *2;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
        while(GetIsObjectValid(oTarget)){
            if(GetIsFriend(oTarget)){
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_PRAYER, FALSE));

                    ApplyEffectToObject(DURATION_TYPE_INSTANT, ePosVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePosLink, oTarget,RoundsToSeconds(nDuration));

            }
            else if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF)){


                    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_PRAYER));
                    if(!MyResistSpell(OBJECT_SELF, oTarget)){
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eNegVis, oTarget);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eNegLink, oTarget, RoundsToSeconds(nDuration));

                 }
                }

            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
        }
}


