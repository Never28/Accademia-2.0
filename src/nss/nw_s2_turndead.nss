/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 21-09-2009
*/

// Funzione per Scacciare/Dominare Non Morti.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    object oPC = OBJECT_SELF;
    int nClericLevel = GetLevelByClass(CLASS_TYPE_CLERIC,oPC);
    int nPaladinLevel = GetLevelByClass(CLASS_TYPE_PALADIN,oPC);
    int nBlackguardLevel = GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC);
    int nTotalLevel = nClericLevel + nPaladinLevel + nBlackguardLevel;
    int nRacial;
    effect eDeath = SupernaturalEffect(EffectDeath());
    effect eDamage;
    int nDC, nDamage;
    int nAlignoPC = GetAlignmentGoodEvil(oPC);
    int nAlignoTarget;
    effect eVis = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
    int nAppearance, nAppearanceoPC;
    int nCnt=1;
    float fDelay;
    nAppearanceoPC = GetAppearanceType(oPC);
    if(nAppearanceoPC == APPEARANCE_TYPE_ARIBETH || APPEARANCE_TYPE_NWN_ARIBETH_EVIL == nAppearanceoPC)
        nTotalLevel = 40;
    int nPersuade = GetSkillRank(SKILL_PERSUADE,oPC);
    if(nTotalLevel<10&&nPersuade>=15)
        nDC =15;
    else if(nTotalLevel<10&&nPersuade<15)
        nDC = 10;
    else if(nTotalLevel>=10&&nTotalLevel<15&&nPersuade>=25)
        nDC =20;
    else if(nTotalLevel>=10&&nTotalLevel<15&&nPersuade<25)
        nDC = 15;
    else if(nTotalLevel>=15&&nTotalLevel<20&&nPersuade>=30)
        nDC =25;
    else if(nTotalLevel>=15&&nTotalLevel<20&&nPersuade<30)
        nDC = 20;
    else if(nTotalLevel>=20&&nTotalLevel<25&&nPersuade>=60)
        nDC =30;
    else if(nTotalLevel>=20&&nTotalLevel<25&&nPersuade<60)
        nDC = 25;
    else if(nTotalLevel>=25&&nTotalLevel<30&&nPersuade>=70)
        nDC = 35;
    else if(nTotalLevel>=25&&nTotalLevel<30&&nPersuade<70)
        nDC = 30;
    else if(nTotalLevel>=30&&nTotalLevel<35&&nPersuade>=80)
        nDC = 40;
    else if(nTotalLevel>=30&&nTotalLevel<35&&nPersuade<80)
        nDC = 35;
    else if(nTotalLevel>=35&&nTotalLevel<40&&nPersuade>=90)
        nDC = 45;
    else if(nTotalLevel>=35&&nTotalLevel<40&&nPersuade<90)
        nDC = 40;
    else if(nTotalLevel==40&&nPersuade>=100)
        nDC = 50;
    else if(nTotalLevel==40&&nPersuade<100)
        nDC = 45;
    object oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE , oPC, nCnt,CREATURE_TYPE_PERCEPTION , PERCEPTION_SEEN);
    while(GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) <= 20.0){
        nRacial = GetRacialType(oTarget);
        nAlignoTarget = GetAlignmentGoodEvil(oTarget);
        nAppearance = GetAppearanceType(oTarget);
        fDelay = GetDistanceBetweenLocations(GetLocation(oPC), GetLocation(oTarget))/20;
        if(nRacial == RACIAL_TYPE_UNDEAD){
            if(nAlignoPC ==  ALIGNMENT_EVIL){
                if (!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_NONE, OBJECT_SELF, 1.0)){
                    effect eDominated = EffectCutsceneDominated();
                    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DOMINATED);
                    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
                    effect eLink = EffectLinkEffects(eMind, eDur);
                    eLink = EffectLinkEffects(eLink, eDominated);
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget,RoundsToSeconds(20)));
                }
            }
            else if(nAlignoPC == ALIGNMENT_GOOD){
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DEATH))
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
            }
            else{
                nDamage = d12(nTotalLevel);
                if(MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_ALL,oPC))
                    nDamage = nDamage / 2;
                eDamage = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
                DelayCommand(0.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget));
            }
        }
        else if(nRacial == 52 && (GetHasFeat(FEAT_PLANT_DOMAIN_POWER,oPC) == TRUE)){
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DEATH))
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));

        }
        else if(nRacial == RACIAL_TYPE_OUTSIDER){
            if(nAlignoPC == ALIGNMENT_GOOD && nAlignoTarget == ALIGNMENT_EVIL && GetHasFeat(FEAT_GOOD_DOMAIN_POWER,oPC)== TRUE){
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DEATH))
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
            }
            else if(nAlignoPC == ALIGNMENT_EVIL && nAlignoTarget == ALIGNMENT_GOOD && GetHasFeat(FEAT_EVIL_DOMAIN_POWER,oPC)== TRUE){
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DEATH))
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
            }
            else if(GetHasFeat(854,oPC)== TRUE){
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DEATH))
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
            }
        }
        else if(nRacial == RACIAL_TYPE_ELEMENTAL){
            if(nAppearance == APPEARANCE_TYPE_ELEMENTAL_AIR || nAppearance == APPEARANCE_TYPE_ELEMENTAL_AIR_ELDER && GetHasFeat(FEAT_AIR_DOMAIN_POWER,oPC)== TRUE)
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DEATH))
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
            else if(nAppearance == APPEARANCE_TYPE_ELEMENTAL_EARTH || nAppearance == APPEARANCE_TYPE_ELEMENTAL_EARTH_ELDER && GetHasFeat(FEAT_EARTH_DOMAIN_POWER,oPC)== TRUE)
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DEATH))
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
            else if(nAppearance == APPEARANCE_TYPE_ELEMENTAL_FIRE || nAppearance == APPEARANCE_TYPE_ELEMENTAL_FIRE_ELDER && GetHasFeat(FEAT_FIRE_DOMAIN_POWER,oPC)== TRUE)
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DEATH))
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
            else if(nAppearance == APPEARANCE_TYPE_ELEMENTAL_WATER || nAppearance == APPEARANCE_TYPE_ELEMENTAL_WATER_ELDER && GetHasFeat(FEAT_WATER_DOMAIN_POWER,oPC)== TRUE)
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DEATH))
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
        }
        else if(nRacial == RACIAL_TYPE_CONSTRUCT){
            if(GetHasFeat(FEAT_DESTRUCTION_DOMAIN_POWER,oPC)== TRUE){
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DEATH))
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
            }
        }
        nCnt++;
        oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE, oPC, nCnt,CREATURE_TYPE_PERCEPTION , PERCEPTION_SEEN);
    }

}

