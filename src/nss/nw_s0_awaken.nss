/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Risveglio.

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nLevel = GetCasterLevel(OBJECT_SELF);
    int nBonus = 1;
    if(nLevel > 20)
        nBonus =2;
    effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, nLevel/5);
    effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION, nLevel/5);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eInt;
    effect eAttack = EffectAttackIncrease(nBonus);
    effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID);
    int nDuration = 24;
    int nMetaMagic = GetMetaMagicFeat();
    int nInt = d10(nLevel/8);
    if(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION) == oTarget){
        if(!GetHasSpellEffect(SPELL_AWAKEN)){
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_AWAKEN, FALSE));
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
                nInt=50;
            else if (nMetaMagic == METAMAGIC_EMPOWER)
                nInt = nInt + (nInt/2);
            else if (nMetaMagic == METAMAGIC_EXTEND)
                nDuration = nDuration *2;
            eInt = EffectAbilityIncrease(ABILITY_WISDOM, nInt);
            effect eLink = EffectLinkEffects(eStr, eCon);
            eLink = EffectLinkEffects(eLink, eAttack);
            eLink = EffectLinkEffects(eLink, eInt);
            eLink = EffectLinkEffects(eLink, eDur);
            eLink = SupernaturalEffect(eLink);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
        }
    }
}
