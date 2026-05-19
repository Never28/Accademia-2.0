/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Corazza Mortale.

#include "x2_inc_spellhook"
#include "x0_i0_spells"
void main()
{
    if (!X2PreSpellCastCode())
        return;
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nBonus = nDuration;
    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = OBJECT_SELF;

    int nSave = SAVING_THROW_TYPE_NEGATIVE;
    int nType = DAMAGE_TYPE_NEGATIVE;
    int nElement = GetLocalInt(OBJECT_SELF,"SapienteElementale");
    switch(nElement){
        case 1:
            nType = DAMAGE_TYPE_BLUDGEONING;
            break;
        case 2:
            nType = DAMAGE_TYPE_COLD;
            break;
        case 3:
            nType = DAMAGE_TYPE_ELECTRICAL;
            break;
        case 4:
            nType = DAMAGE_TYPE_FIRE;
            break;
    }
    effect eShield = EffectDamageShield(nBonus, 0, nType);
    effect eDur = EffectVisualEffect(463);

    //Link effects
    effect eLink = EffectLinkEffects(eShield, eDur);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }

    //Stacking Spellpass, 2003-07-07, Georg
    RemoveEffectsFromSpell(oTarget, SPELL_DEATH_ARMOR);
    RemoveEffectsFromSpell(oTarget, SPELL_ELEMENTAL_SHIELD);
    RemoveEffectsFromSpell(oTarget, SPELL_MESTILS_ACID_SHEATH);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
}

