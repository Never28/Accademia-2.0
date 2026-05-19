/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 10-08-2009
*/

// Funzione per Furia Sanguinaria.

#include "x2_inc_spellhook"

void main()
{

    if (!X2PreSpellCastCode())
        return;
    if(!GetHasSpellEffect(422)){
        int nDuration = GetCasterLevel(OBJECT_SELF);
        int nIncrease;
        int nSave;
        int nModify = nDuration/10;
        if(nModify == 0)
            nModify = 1;
        nModify = 2*(nModify);
        int nMetaMagic = GetMetaMagicFeat();
        if (nMetaMagic == METAMAGIC_EXTEND)
            nDuration = nDuration * 2;
        PlayVoiceChat(VOICE_CHAT_BATTLECRY1);
        effect eStr = EffectAbilityIncrease(ABILITY_CONSTITUTION, nModify);
        effect eCon = EffectAbilityIncrease(ABILITY_STRENGTH, nModify);
        effect eSave = EffectSavingThrowIncrease(SAVING_THROW_WILL, nModify);
        effect eAC = EffectACDecrease(1, AC_DODGE_BONUS);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eLink = EffectLinkEffects(eCon, eStr);
        eLink = EffectLinkEffects(eLink, eSave);
        eLink = EffectLinkEffects(eLink, eAC);
        eLink = EffectLinkEffects(eLink, eDur);
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, 422, FALSE));
        eLink = MagicalEffect(eLink);
        effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nDuration));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF) ;
    }
}
