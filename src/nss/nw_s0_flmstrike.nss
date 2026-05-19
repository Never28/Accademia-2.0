/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 10-08-2009
*/

// Funzione per Esplosione di Fuoco.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget;
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nDamage, nDamage2;
    int nMetaMagic = GetMetaMagicFeat();
    effect eStrike = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    effect eHoly;
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    effect eFire;
    int nClass = GetLastSpellCastClass();
    nDamage =  d4(nCasterLvl*2);
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
        nDamage = 8 * nCasterLvl;
    if (nMetaMagic == METAMAGIC_EMPOWER)
        nDamage = nDamage + (nDamage/2);
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation(), FALSE, OBJECT_TYPE_CREATURE|OBJECT_TYPE_PLACEABLE|OBJECT_TYPE_DOOR);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStrike, GetSpellTargetLocation());
        while ( GetIsObjectValid(oTarget) ){
            if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF)){
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FLAME_STRIKE));
                float fDamage = (IntToFloat(nDamage)/100.0)*75.0;
                nDamage = FloatToInt(fDamage);
                nDamage=nDamage/2;
                if (!MyResistSpell(OBJECT_SELF, oTarget, 0.6)){
                    nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_FIRE);
                    eHoly =  EffectDamage(nDamage,DAMAGE_TYPE_DIVINE);
                    DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHoly, oTarget));
                    eFire =  EffectDamage(nDamage,DAMAGE_TYPE_FIRE);
                    DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                    DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
            }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM,GetSpellTargetLocation(), FALSE, OBJECT_TYPE_CREATURE|OBJECT_TYPE_PLACEABLE|OBJECT_TYPE_DOOR);
        }
}
