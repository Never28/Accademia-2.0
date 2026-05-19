/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Affogare.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDam = GetCurrentHitPoints(oTarget);
    int nDC = GetSpellSaveDC();
        if(GetHitDice(OBJECT_SELF)==40)
            nDC = nDC +5;
        else if(GetHitDice(OBJECT_SELF)>=31)
            nDC = nDC +3;
        else if(GetHitDice(OBJECT_SELF)>=21)
            nDC = nDC +2;
        else if(GetHitDice(OBJECT_SELF)>=11)
            nDC = nDC +1;
    effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);
    effect eDam;
    if(!GetIsReactionTypeFriendly(oTarget)){
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 437));
        if(!MyResistSpell(OBJECT_SELF, oTarget)){
            if ((GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT)
                &&(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
                &&(GetRacialType(oTarget) != RACIAL_TYPE_ELEMENTAL)){
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC)){
                    nDam = FloatToInt(nDam * 0.9);
                    eDam = EffectDamage(nDam, DAMAGE_TYPE_MAGICAL);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);

                }
            }
        }
    }
}





