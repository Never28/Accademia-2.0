/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Sgretolare.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "X2_i0_spells"

void DoCrumble (int nDam, object oCaster, object oTarget);

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oCaster  = OBJECT_SELF;
    object oTarget  = GetSpellTargetObject();
    int  nCasterLvl = GetCasterLevel(oCaster);
    int  nType      = GetObjectType(oTarget);
    int  nRacial    = GetRacialType(oTarget);
    int  nMetaMagic = GetMetaMagicFeat();
    SignalEvent(oTarget, EventSpellCastAt(oCaster, GetSpellId()));
    effect eCrumb = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eCrumb, oTarget);
    if (nType != OBJECT_TYPE_CREATURE && nType !=  OBJECT_TYPE_PLACEABLE && nType != OBJECT_TYPE_DOOR )
        return;
    if (GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT  &&  GetLevelByClass(CLASS_TYPE_CONSTRUCT,oTarget) == 0)
        return;
        int nDamage= 0;
    nDamage = d6(nCasterLvl*2);
    nDamage = nDamage + d2(nCasterLvl);
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
        nDamage = 14*(nCasterLvl);
    if (nMetaMagic == METAMAGIC_EMPOWER)
        nDamage = nDamage + nDamage/2;
    float fDamage = (IntToFloat(nDamage)/100.0)*65.0;
    nDamage = FloatToInt(fDamage);
    if (nDamage>0)
        DelayCommand(0.1f,DoCrumble(nDamage, oCaster, oTarget));
}

void DoCrumble (int nDam, object oCaster, object oTarget)
{
    float  fDist = GetDistanceBetween(oCaster, oTarget);
    float  fDelay = fDist/(3.0 * log(fDist) + 2.0);
    effect eDam = EffectDamage(nDam, DAMAGE_TYPE_SONIC);
    effect eMissile = EffectVisualEffect(477);
    effect eCrumb = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eVis = EffectVisualEffect(135);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eCrumb, oTarget);
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
    DelayCommand(0.5f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget));
}
