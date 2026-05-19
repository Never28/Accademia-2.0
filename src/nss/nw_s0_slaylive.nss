/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 10-08-2009
*/

// Funzione per Uccidi Viventi.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "mod_bad_dice"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDamage;
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
    effect eVis2 = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
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
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SLAY_LIVING));
            if(!MyResistSpell(OBJECT_SELF, oTarget)){
                if(TouchAttackMelee(oTarget)){
                    if  (!MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_DEATH)){
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oTarget);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    }
                    else{
                        nDamage = nNumberRandom(5,nCasterLevel*2);
                        if (nMetaMagic == METAMAGIC_MAXIMIZE)
                            nDamage = 10 * nCasterLevel;
                        if (nMetaMagic == METAMAGIC_EMPOWER)
                            nDamage = nDamage + (nDamage/2);
                        float fDamage = (IntToFloat(nDamage)/100.0)*30.0;
                        nDamage = FloatToInt(fDamage);
                        eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                    }
                }
            }
        }
}
