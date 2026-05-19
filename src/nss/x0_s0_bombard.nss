/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Bombardare.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);
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
    int nDamage;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_METEOR_SWARM);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eDam;
    location lTarget = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget)){
        if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF) == TRUE){
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay)){
                nDamage = d8(nCasterLvl*2);
                if (nMetaMagic == METAMAGIC_EMPOWER)
                   nDamage = nDamage + nDamage / 2;
                float fDamage = (IntToFloat(nDamage)/100.0)*75.0;
                nDamage = FloatToInt(fDamage);
                nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_ALL);
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING);
                if(nDamage > 0){
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
             }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}



