/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Confusione.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget;
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
    int nClass = GetLastSpellCastClass();
    if(nClass == CLASS_TYPE_BARD){
        int nBard = GetLevelByClass(CLASS_TYPE_BARD,OBJECT_SELF);
        if(nBard >=21)
            nDC = nDC +5;
        else if(nBard >=15)
            nDC = nDC +3;
        else if(nBard >=10)
            nDC = nDC +2;
        else if(nBard >=5)
            nDC = nDC +1;
    }
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
    effect eVis = EffectVisualEffect(VFX_IMP_CONFUSION_S);
    effect eConfuse = EffectConfused();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    float fDelay;
    effect eLink = EffectLinkEffects(eMind, eConfuse);
    eLink = EffectLinkEffects(eLink, eDur);
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration * 2;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget)){
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF)){
           SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CONFUSION));
           fDelay = GetRandomDelay();
           if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay)){
                if (!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF, fDelay)){
                   nDuration = GetScaledDuration(GetCasterLevel(OBJECT_SELF), oTarget);
                   DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
                   DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    }
}

