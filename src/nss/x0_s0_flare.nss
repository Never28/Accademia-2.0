/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Lampo.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nBonus = nCasterLevel/8;
    if(nBonus<1)
        nBonus = 1;
    int nDC = GetSpellSaveDC();
    int nClass = GetLastSpellCastClass();
    if(nClass == CLASS_TYPE_BARD){
        int nBard = GetLevelByClass(CLASS_TYPE_BARD,OBJECT_SELF);
        if(nBard >=21)
            nDC = nDC +5;
        else if(nBard >=15)
            nDC = nDC +3;
        else if(nBard >=10)
            nDC = nDC +2;
        else if(nBard >=5)
            nDC = nDC +1;
    }
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    if(!GetIsReactionTypeFriendly(oTarget)){
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 416));
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        if ((!MyResistSpell(OBJECT_SELF, oTarget)) &&  (MySavingThrow(SAVING_THROW_FORT, oTarget, nDC) == FALSE) ){
            effect eBad = EffectAttackDecrease(nBonus);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBad, oTarget, RoundsToSeconds(10));
        }
    }
}


