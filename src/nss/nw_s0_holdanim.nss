/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 13-07-2009
*/

// Funzione per Blocca Animali.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nLevel = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
    int nClass = GetLastSpellCastClass();
    if(nClass == CLASS_TYPE_RANGER){
        int nRang = GetLevelByClass(CLASS_TYPE_RANGER,OBJECT_SELF);
        if(nRang >=21)
            nDC = nDC +7;
        else if(nRang >=17)
            nDC = nDC +5;
        else if(nRang >=14)
            nDC = nDC +4;
        else if(nRang >=11)
            nDC = nDC +3;
        else if(nRang >=8)
            nDC = nDC +2;
        else
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
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nMeta = GetMetaMagicFeat();
    int nDuration = nCasterLvl;
    effect eParal = EffectParalyze();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eDur3 = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
    effect eLink = EffectLinkEffects(eDur2, eDur);
    eLink = EffectLinkEffects(eLink, eParal);
    eLink = EffectLinkEffects(eLink, eDur3);
    if(!GetIsReactionTypeFriendly(oTarget)){
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HOLD_ANIMAL));
        if (GetRacialType(oTarget) == RACIAL_TYPE_ANIMAL){
            if (!MyResistSpell(OBJECT_SELF, oTarget)){
                if (!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC)){
                    if (nMeta == METAMAGIC_EXTEND)
                        nDuration = nDuration * 2;
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                }
            }
        }
    }
}
