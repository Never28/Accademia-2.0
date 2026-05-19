/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Virtu'.

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = GetSpellTargetObject();
    if (GetHasSpellEffect(GetSpellId(),oTarget))
         RemoveSpellEffects(GetSpellId(), OBJECT_SELF, oTarget);
    effect eHP;
    effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID);
    if(GetLastSpellCastClass() == CLASS_TYPE_CLERIC||GetLastSpellCastClass() == CLASS_TYPE_DRUID){
        int Bonus = nDuration/2;
        if(Bonus<1)
            Bonus = 1;
        eHP = EffectTemporaryHitpoints(Bonus);
    }
    else
        eHP = EffectTemporaryHitpoints(nDuration);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eHP, eDur);
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration *2;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_VIRTUE, FALSE));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
}
