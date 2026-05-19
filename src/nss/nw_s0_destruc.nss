/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 13-07-2009
*/

// Funzione per gli Disintegrare.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "mod_bad_dice"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    effect eDeath = EffectDeath();
    effect eDam;
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    effect eVis = EffectVisualEffect(234);
    if(!GetIsReactionTypeFriendly(oTarget)){
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DESTRUCTION));
        if(!MyResistSpell(OBJECT_SELF, oTarget)){
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC))
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget);
            else{
                nDamage = nNumberRandom(7,nCasterLvl*2);
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    nDamage = 14*(nCasterLvl);
                else if (nMetaMagic == METAMAGIC_EMPOWER)
                    nDamage = nDamage + (nDamage/2);
                float fDamage = (IntToFloat(nDamage)/100.0)*30.0;
                nDamage = FloatToInt(fDamage);
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            }
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }
}
