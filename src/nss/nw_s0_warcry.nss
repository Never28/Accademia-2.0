/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Aura di Guerra.

#include "X2_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget;
    int nLevel = GetCasterLevel(OBJECT_SELF);
    int nBonus=1;
    if(nLevel>20)
        nBonus =2;
    int nDC = GetSpellSaveDC();
    int nClass = GetLastSpellCastClass();
    if(nClass == CLASS_TYPE_BARD)
        nDC = nDC+3;

    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    effect eAttack = EffectAttackIncrease(nBonus);
    int nDamS = nLevel/4;
    effect eDamage = EffectDamageIncrease(nBonus, DAMAGE_TYPE_SLASHING);
    effect eFear = EffectFrightened();
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_SONIC);
    effect eVisFear = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
    effect eLOS;
    if(GetGender(OBJECT_SELF) == GENDER_FEMALE)
        eLOS = EffectVisualEffect(290);
    else
        eLOS = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eAttack, eDamage);
    eLink = EffectLinkEffects(eLink, eDur2);
    effect eLink2 = EffectLinkEffects(eVisFear, eFear);
    eLink = EffectLinkEffects(eLink, eDur);
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
       nLevel *= 2;
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eLOS, OBJECT_SELF);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while (GetIsObjectValid(oTarget)){
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF){
           SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_WAR_CRY));
           if(!MyResistSpell(OBJECT_SELF, oTarget)  && !MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_FEAR))
                DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2, oTarget, RoundsToSeconds(4)));
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
    RemoveSpellEffects(GetSpellId(),OBJECT_SELF,OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nLevel)));
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_WAR_CRY, FALSE));
}
