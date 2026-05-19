/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 10-08-2009
*/

// Funzione per Frusta Infuocata.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    int nDamage = d2(nCasterLevel*2);
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
        nDamage = 4 * (nCasterLevel);
    else if (nMetaMagic == METAMAGIC_EMPOWER)
        nDamage = nDamage + (nDamage/2);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    effect eRay = EffectBeam(VFX_BEAM_FIRE_LASH, OBJECT_SELF, BODY_NODE_HAND);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
    if(!GetIsReactionTypeFriendly(oTarget)){
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FLAME_LASH));
        if (!MyResistSpell(OBJECT_SELF, oTarget, 1.0)){
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_FIRE);
            effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
            if(nDamage > 0){
                DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            }
        }
    }
}
