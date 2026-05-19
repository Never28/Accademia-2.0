//::///////////////////////////////////////////////
//:: Terrifying Rage Script
//:: x2_s2_terrage_a.nss
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*

    Upon entering the aura of the creature the player
    must make a will save or be struck with fear because
    of the creatures presence.
                                   gggggggg
    - Save DC is a Intimidate check result of the raging character

    - If the creature has less HitDice than the barbarian they freeze in terror 1d3 rounds

    - if the creature has less HD than the BarbarianHD*2, they are shaken (-2 to attack, -2 to saves)

    - if the creature has more than double HD than the Barb, they are immune to the effect

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-10
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"
#include "x2_i0_spells"

void main()
{
    //Declare major variables
    object oTarget = GetEnteringObject();
    effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    effect eDur = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink;
    object oBarb = GetAreaOfEffectCreator();
    int nDuration = 6 + (GetAbilityModifier(ABILITY_CONSTITUTION)*2);
    int nDC;
    int nBarb = GetLevelByClass(CLASS_TYPE_BARBARIAN,oBarb);
    int nIntimidate = GetSkillRank(SKILL_INTIMIDATE,oBarb);
    if(nBarb>=20&&nBarb<25&&nIntimidate>=60)
        nDC =30;
    else if(nBarb>=20&&nBarb<25&&nIntimidate<60)
        nDC = 25;
    else if(nBarb>=25&&nBarb<30&&nIntimidate>=70)
        nDC = 35;
    else if(nBarb>=25&&nBarb<30&&nIntimidate<70)
        nDC = 30;
    else if(nBarb>=30&&nBarb<35&&nIntimidate>=80)
        nDC = 40;
    else if(nBarb>=30&&nBarb<35&&nIntimidate<80)
        nDC = 35;
    else if(nBarb>=35&&nBarb<40&&nIntimidate>=90)
        nDC = 45;
    else if(nBarb>=35&&nBarb<40&&nIntimidate<90)
        nDC = 40;
    else if(nBarb==40&&nIntimidate>=100)
        nDC = 50;
    else if(nBarb==40&&nIntimidate<100)
        nDC = 45;
    if(GetIsEnemy(oTarget, oBarb)){
        SignalEvent(oTarget, EventSpellCastAt(oBarb, GetSpellId()));
          if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_FEAR)){
                if (GetItemPossessedBy(oBarb,"mod_clas_cl")!=OBJECT_INVALID){
                    effect eFear = EffectFrightened();
                    eLink = EffectLinkEffects(eFear, eDur);
                    eLink = EffectLinkEffects(eLink, eDur2);
                    eLink = ExtraordinaryEffect(eLink);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    PlayVoiceChat(VOICE_CHAT_HELP,oTarget);
                }
                else{
                    int nControll = GetHasEffect(EFFECT_TYPE_SAVING_THROW_DECREASE,oTarget);
                    if(nControll==FALSE){
                        effect eShake1 = EffectSavingThrowDecrease(SAVING_THROW_ALL,5);
                        eLink = EffectLinkEffects(eLink, eShake1);
                    }
                    nControll = GetHasEffect(EFFECT_TYPE_ATTACK_DECREASE,oTarget);
                    if(nControll==FALSE){
                        effect eShake2 = EffectAttackDecrease(5);
                        eLink = EffectLinkEffects(eLink, eShake2);
                    }
                    nControll = GetHasEffect(EFFECT_TYPE_AC_DECREASE,oTarget);
                    if(nControll==FALSE){
                        effect eShake3 = EffectACDecrease(5);
                        eLink = EffectLinkEffects(eLink, eShake3);
                    }
                    eLink = EffectLinkEffects(eLink, eDur2);
                    eLink = ExtraordinaryEffect(eLink);
                    FloatingTextStrRefOnCreature(83583,oTarget);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                 }
          }
      }

}
