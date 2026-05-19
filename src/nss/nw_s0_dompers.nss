/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Dominare Persone.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nDiceTarget = GetHitDice(oTarget);
    int nTargetCap;
    if(nDiceTarget>30)
        nTargetCap = 4;
    else if(nDiceTarget>20)
        nTargetCap = 2;
    else
        nTargetCap = 1;
    effect eDom = EffectCutsceneDominated();
    eDom = GetScaledEffect(eDom, oTarget);
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DOMINATED);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eMind, eDom);
    eLink = EffectLinkEffects(eLink, eDur);
    effect eVis = EffectVisualEffect(VFX_IMP_DOMINATE_S);
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
    int nDuration = GetCasterLevel(OBJECT_SELF);
    nDuration = GetCasterLevel(OBJECT_SELF);
    int nRacial = GetRacialType(oTarget);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DOMINATE_PERSON, FALSE));
    if(!GetIsReactionTypeFriendly(oTarget)){
        if  ((nRacial == RACIAL_TYPE_DWARF) ||
            (nRacial == RACIAL_TYPE_ELF) ||
            (nRacial == RACIAL_TYPE_GNOME) ||
            (nRacial == RACIAL_TYPE_HALFLING) ||
            (nRacial == RACIAL_TYPE_HUMAN) ||
            (nRacial == RACIAL_TYPE_HALFELF) ||
            (nRacial == RACIAL_TYPE_HALFORC)){
           if (!MyResistSpell(OBJECT_SELF, oTarget)){
                if(GetIsImmune(oTarget,IMMUNITY_TYPE_MIND_SPELLS,OBJECT_SELF)==FALSE){
                    if (!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF, 1.0)){
                        nDuration= 20;
                        if (nMetaMagic == METAMAGIC_EXTEND)
                            nDuration = nDuration +10;
                        DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    }
                }
            }
        }
    }
}
