/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Devastazione.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_DOOM);
    int nLevel = GetCasterLevel(OBJECT_SELF);
    int Malus = nLevel/8;
    if(Malus == 0)
        Malus = 1;
    effect eAttMalus = EffectAttackDecrease(Malus);
    effect eSkillMalus = EffectSkillDecrease(SKILL_ALL_SKILLS,Malus);
    effect eTSMalus = EffectSavingThrowDecrease(SAVING_THROW_ALL,Malus,SAVING_THROW_TYPE_ALL);
    effect eLink = EffectLinkEffects(eAttMalus,eSkillMalus);
    eLink = EffectLinkEffects(eLink, eTSMalus);
    int nMetaMagic = GetMetaMagicFeat();
    if(nMetaMagic == METAMAGIC_EXTEND)
        nLevel *= 2;
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
        if(!GetIsReactionTypeFriendly(oTarget)){
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DOOM));
            int nResult = WillSave(oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS);
            if (nResult == 2){
                if (GetIsPC(OBJECT_SELF))
                    FloatingTextStrRefOnCreature(84525, oTarget,FALSE);
                return;
            }
            nResult = (nResult || MyResistSpell(OBJECT_SELF, oTarget));
            if (!nResult){
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink , oTarget, TurnsToSeconds(nLevel));
            }
        }
}

