//::///////////////////////////////////////////////
//:: Undead Graft
//:: X2_S2_UndGraft1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Pale Master may use their undead arm to paralyze
    foes for 1d6+2 rounds on a successful melee touch attack

    Save is 14 + pale master level/2


    Elves immune to this effect
    TaB pg 66;
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Feb 05, 2003
//:: Updated On: 2003-07-24, Georg Zoeller (added elf immunity, touch attack check, fixed duration)
//:://////////////////////////////////////////////


#include "NW_I0_SPELLS"

void main()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    //object oCaster = GetCurrentHitPoints(OBJECT_SELF);
    object oPC = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nPale = GetLevelByClass(CLASS_TYPE_PALEMASTER,OBJECT_SELF);
    int nRounds = nPale;
    int nUseDaze = nPale/2;
    if(nUseDaze < 1)
        nUseDaze = 1;
    //Declare effects
    effect ePara = EffectParalyze();
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_ICESKIN);
    effect eDur3 = EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);
    int nDC;
    if(nPale<10)
        nDC = 10 +nPale;
    else if(nPale<20)
        nDC = 15 + nPale;
    else if(nPale<=30)
        nDC = 20 + nPale;
    eDur = EffectLinkEffects(eDur2,eDur);
    eDur = EffectLinkEffects(eDur3,eDur);

    //Link effects
    effect eLink = EffectLinkEffects(ePara, eDur);
    if (TouchAttackMelee(oTarget,TRUE)>0)
    {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            //Saving Throw
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_NEGATIVE))
            {
                //Apply effects to target and caster
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nRounds));
            }

    }
    if(GetLocalInt(oPC,"nTouch")<nUseDaze)IncrementRemainingFeatUses(oPC,FEAT_UNDEAD_GRAFT_1);
    SetLocalInt(oPC,"nTouch",GetLocalInt(oPC,"nTouch")+1);
}
