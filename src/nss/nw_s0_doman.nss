/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Dominare Animali.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    effect eDom = EffectCutsceneDominated();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DOMINATED);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eMind, eDom);
    eLink = EffectLinkEffects(eLink, eDur);
    effect eVis = EffectVisualEffect(VFX_IMP_DOMINATE_S);
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
    int nClass = GetLastSpellCastClass();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    int nDuration = 3 + nCasterLevel;
    int nRacial = GetRacialType(oTarget);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DOMINATE_ANIMAL, FALSE));
    if(!GetIsReactionTypeFriendly(oTarget)){
        if  ((nRacial == RACIAL_TYPE_ANIMAL)){
           if (!MyResistSpell(OBJECT_SELF, oTarget)){
                if(GetIsImmune(oTarget,IMMUNITY_TYPE_MIND_SPELLS,OBJECT_SELF)==FALSE){
                    if (!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS)){
                        nDuration= 20;
                        if (nMetaMagic == METAMAGIC_EXTEND)
                            nDuration = nDuration +10;
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget,RoundsToSeconds(nDuration));
                    }
                }
            }
        }
    }
}
