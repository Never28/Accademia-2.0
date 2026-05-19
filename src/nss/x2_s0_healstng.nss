/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Aculei guaritori.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage = 0;
    nDamage = d2(nCasterLvl*3);
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
        nDamage = 6 * (nCasterLvl);
    else if (nMetaMagic == METAMAGIC_EMPOWER)
         nDamage += nDamage / 2;
    int Aspect = GetAppearanceType(OBJECT_SELF);
    if(Aspect == APPEARANCE_TYPE_STINGER_CHIEFTAIN){
        int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
        int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
        int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
        nDruidLv = nMutaLv + nDruidLv;
        nMutaLv = nDruidLv/2;
        if (nMutaLv >= 1){
            nDamage = d4(nDruidLv*2);
            nDC = 10 + nSag + nMutaLv;
        }
    }
    else{
        nDC = GetSpellSaveDC();
        if(GetHitDice(OBJECT_SELF)==40)
            nDC = nDC +5;
        else if(GetHitDice(OBJECT_SELF)>=31)
            nDC = nDC +3;
        else if(GetHitDice(OBJECT_SELF)>=21)
            nDC = nDC +2;
        else if(GetHitDice(OBJECT_SELF)>=11)
            nDC = nDC +1;
        nCasterLvl=nCasterLvl/2;
    }
    float fDamage = (IntToFloat(nDamage)/100.0)*50.0;
    nDamage = FloatToInt(fDamage);
    effect eHeal = EffectHeal(nDamage);
    effect eVs = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eLink = EffectLinkEffects(eVs,eHeal);
    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eLink2 = EffectLinkEffects(eVis,eDamage);
    if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE){
        if(!GetIsReactionTypeFriendly(oTarget) &&
            GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD &&
            GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT &&
            !GetHasSpellEffect(SPELL_NEGATIVE_ENERGY_PROTECTION, oTarget)){
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            if(!MyResistSpell(OBJECT_SELF, oTarget)){
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_NEGATIVE)){
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink2, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, OBJECT_SELF);
                    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
                }
            }
        }
    }
}
