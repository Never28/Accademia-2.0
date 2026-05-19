/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Terremoto.
#include "mod_bad_dice"
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
    int nDamage=0;
    float fDelay;
    float nSize =  RADIUS_SIZE_COLOSSAL;
    effect eExplode = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eDam;
    effect eShake = EffectVisualEffect(356);
    location lTarget = GetSpellTargetLocation();
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShake, OBJECT_SELF, RoundsToSeconds(6));
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, nSize, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget)){
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF)){
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_EARTHQUAKE));
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            nDamage = nNumberRandom(9,nCasterLvl*2);
            float fDamage = (IntToFloat(nDamage)/100.0)*75.0;
            nDamage = FloatToInt(fDamage);
            if (oTarget != oCaster)
                nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_ALL);
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING);
            if( (nDamage > 0) && (oTarget != oCaster)){
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, nSize, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}





