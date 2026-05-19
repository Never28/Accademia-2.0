/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Bilancia della Natura.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    effect eHeal;
    effect eVis = EffectVisualEffect(VFX_IMP_HEALING_L);
    effect eSR;
    effect eVis2 = EffectVisualEffect(VFX_IMP_BREACH);
    effect eNature = EffectVisualEffect(VFX_FNF_NATURES_BALANCE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    int nRand, nNumDice;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    int nDuration = nCasterLevel/3;
    int nMetaMagic = GetMetaMagicFeat();
    float fDelay;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eNature, GetLocation(OBJECT_SELF));
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration *2;
    nNumDice = nCasterLevel / 5;
    if(nNumDice == 0)
        nNumDice = 1;
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(OBJECT_SELF), FALSE);
    while(GetIsObjectValid(oTarget)){
        fDelay = GetRandomDelay();
        if(GetIsFriend(oTarget)){
              SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_NATURES_BALANCE, FALSE));
                int nCure = GetSkillRank(FEAT_EPIC_SKILL_FOCUS_HEAL,OBJECT_SELF);
                nRand = d8(nCasterLevel*2) + (nCure);
                float fDamage = (IntToFloat(nRand)/100.0)*75.0;
                nRand = FloatToInt(fDamage);
              if (nMetaMagic == METAMAGIC_EMPOWER)
                 nRand = nRand + nRand/2;
              eHeal = EffectHeal(nRand);
              DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
              DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        }
        else if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF)){
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_NATURES_BALANCE));
            if(!GetIsReactionTypeFriendly(oTarget)){
                if (!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC)){
                      nRand = nCasterLevel/2;
                      if (nMetaMagic == METAMAGIC_EMPOWER)
                         nRand = nRand + (nRand/2);
                      eSR = EffectSpellResistanceDecrease(nRand);
                      effect eLink = EffectLinkEffects(eSR, eDur);
                      DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
                      DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(OBJECT_SELF), FALSE);
    }
}

