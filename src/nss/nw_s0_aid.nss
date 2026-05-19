/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 07-08-2009
*/

// Funzione per Aiuto.

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int Bonus = 1;
    if(nDuration>20)
        Bonus = 2;
    int nBonusLife = d8(GetCasterLevel(OBJECT_SELF)/8);
    int nMetaMagic = GetMetaMagicFeat();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
        nBonusLife = 40;
    else if (nMetaMagic == METAMAGIC_EMPOWER)
        nBonusLife = nBonusLife + (nBonusLife/2);
    else if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration *2;
    effect eAttack = EffectAttackIncrease(Bonus);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, Bonus, SAVING_THROW_TYPE_ALL);
    effect eHP = EffectTemporaryHitpoints(nBonusLife);
    effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID);
    object oTarget = GetSpellTargetObject();
    effect eLink = EffectLinkEffects(eAttack, eSave);
    eLink = EffectLinkEffects(eLink, eDur);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_AID, FALSE));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, TurnsToSeconds(nDuration));
}

