//::///////////////////////////////////////////////
//:: Divine Wrath
//:: x2_s2_DivWrath
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Divine Champion is able to channel a portion
    of their gods power once per day giving them a +3
    bonus on attack rolls, damage, and saving throws
    for a number of rounds equal to their Charisma
    bonus. They also gain damage reduction of +1/5.
    At 10th level, an additional +2 is granted to
    attack rolls and saving throws.

    Epic Progression
    Every five levels past 10 an additional +2
    on attack rolls, damage and saving throws is added. As well the damage
    reduction increases by 5 and the damage power required to penetrate
    damage reduction raises by +1 (to a maximum of /+5).
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Feb 05, 2003
//:: Updated On: Jul 21, 2003 Georg Zoeller -
//                            Epic Level progession
//:://////////////////////////////////////////////

#include "nw_i0_spells"

void main()
{
    object oTarget = OBJECT_SELF;
    int nDuration = 25 + GetAbilityModifier(ABILITY_CHARISMA, OBJECT_SELF)+ GetLevelByClass(CLASS_TYPE_DIVINECHAMPION,oTarget) ;
    if(nDuration <= 0){
        FloatingTextStrRefOnCreature(100967,OBJECT_SELF);
        return;
    }
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    eVis = EffectLinkEffects(EffectVisualEffect(VFX_FNF_LOS_HOLY_30),eVis);
    effect eVis2 = SupernaturalEffect(EffectVisualEffect(VFX_DUR_AURA_YELLOW_LIGHT));
    effect eAttack, eDamage, eSaving, eReduction;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 621, FALSE));
    int nAttackB;
    int nDam = DAMAGE_BONUS_1;
    int nDamageB;
    int nSaveB;
    int nLevel = GetLevelByClass(CLASS_TYPE_DIVINECHAMPION,oTarget) ;
            if(nLevel==1||nLevel==2)
                nDam = DAMAGE_BONUS_1;
            else if(nLevel==3||nLevel==4)
                nDam = DAMAGE_BONUS_2;
            else if(nLevel==5||nLevel==6)
                nDam = DAMAGE_BONUS_3;
            else if(nLevel==7||nLevel==8)
                nDam = DAMAGE_BONUS_4;
            else if(nLevel==9||nLevel==10)
                nDam = DAMAGE_BONUS_5;
            else if(nLevel==11||nLevel==12)
                nDam = DAMAGE_BONUS_6;
            else if(nLevel==13||nLevel==14)
                nDam = DAMAGE_BONUS_7;
            else if(nLevel==15||nLevel==16)
                nDam = DAMAGE_BONUS_8;
            else if(nLevel==17||nLevel==18)
                nDam = DAMAGE_BONUS_9;
            else if(nLevel==19||nLevel==20)
                nDam = DAMAGE_BONUS_10;
            else if(nLevel==21||nLevel==22)
                nDam = DAMAGE_BONUS_11;
            else if(nLevel==23||nLevel==24)
                nDam = DAMAGE_BONUS_12;
            else if(nLevel==25||nLevel==26)
                nDam = DAMAGE_BONUS_13;
            else if(nLevel==27||nLevel==28)
                nDam = DAMAGE_BONUS_14;
            else if(nLevel==29||nLevel==30)
                nDam = DAMAGE_BONUS_15;
    int nLevelB = (nLevel / 3);
    eAttack = EffectAttackIncrease(nLevelB,ATTACK_BONUS_MISC);
    eDamage = EffectDamageIncrease(nDam, DAMAGE_TYPE_POSITIVE);
    eSaving = EffectSavingThrowIncrease(SAVING_THROW_ALL,nLevelB, SAVING_THROW_TYPE_ALL);
    eReduction = EffectDamageReduction(nLevelB, DAMAGE_POWER_PLUS_TWENTY);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eAttack, eDamage);
    eLink = EffectLinkEffects(eSaving,eLink);
    eLink = EffectLinkEffects(eReduction,eLink);
    eLink = EffectLinkEffects(eDur,eLink);
    eLink = SupernaturalEffect(eLink);
    if(GetLocalInt(oTarget,"nWrath")<1)
        IncrementRemainingFeatUses(oTarget,FEAT_DIVINE_WRATH);
    SetLocalInt(oTarget,"nWrath",GetLocalInt(oTarget,"nWrath")+1);
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oTarget, RoundsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

}
