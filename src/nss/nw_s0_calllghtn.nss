/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Invocare il Fulmine.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "mod_bad_dice"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    float fDelay;
    effect eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    effect eDam;
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    location lTarget = GetSpellTargetLocation();
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget)){
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF)){
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CALL_LIGHTNING));
            fDelay = GetRandomDelay(0.4, 1.75);
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay)){
                nDamage;
                nDamage = nNumberRandom(3,nCasterLvl*2);
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    nDamage = 6 * (nCasterLvl);
                else if (nMetaMagic == METAMAGIC_EMPOWER)
                   nDamage = nDamage + nDamage / 2;
                float fDamage = (IntToFloat(nDamage)/100.0)*50.0;
                nDamage = FloatToInt(fDamage);
                nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_ELECTRICITY);
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
                if(nDamage > 0){
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
             }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}
