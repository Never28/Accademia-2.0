/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 13-07-2009
*/

// Funzione per Paura.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = d4();
    effect eScare = EffectFrightened();
    effect eSave = EffectSavingThrowDecrease(SAVING_THROW_WILL, 2, SAVING_THROW_TYPE_MIND_SPELLS);
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
   effect eDamagePenalty = EffectDamageDecrease(2);
   effect eAttackPenalty = EffectAttackDecrease(2);
   effect eLink = EffectLinkEffects(eMind, eScare);
   effect eLink2 = EffectLinkEffects(eSave, eDur);
   eLink2 = EffectLinkEffects(eLink2, eDamagePenalty);
   eLink2 = EffectLinkEffects(eLink2, eAttackPenalty);
       if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE){
            if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF) == TRUE){
               SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SCARE));
               if(!MyResistSpell(OBJECT_SELF, oTarget)){
                    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_FEAR)){
                       if (nMetaMagic == METAMAGIC_EXTEND)
                           nDuration = nDuration * 2;
                       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2, oTarget, RoundsToSeconds(nDuration));
                    }
                }
            }
        }
}
