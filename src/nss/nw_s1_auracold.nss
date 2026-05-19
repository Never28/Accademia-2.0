/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 26-02-2011
*/

// Aura di Freddo.

#include "x0_i0_spells"

void AuraDiFreddo(object oPC,int nTime){
    int AuraDiFreddo_CURRENT = GetLocalInt(oPC,"AuraDiFreddo_CURRENT");
    if(AuraDiFreddo_CURRENT != nTime && AuraDiFreddo_CURRENT != 0){
        AuraDiFreddo_CURRENT = AuraDiFreddo_CURRENT +1;
        effect eAOE = EffectVisualEffect(VFX_DUR_AURA_COLD);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, oPC, 6.0);
        int nAge = GetHitDice(oPC);
        int nSag = GetAbilityModifier(ABILITY_WISDOM,oPC);
        int nDamage;
        int nDC;
        int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,oPC);
        int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,oPC);
        nDruidLv = nMutaLv + nDruidLv;
        nMutaLv = nDruidLv/2;
        effect eDam;
        if (nMutaLv >= 1){
            nDamage = d4(nDruidLv*2);
            nDC = 10 + nSag + nMutaLv;
        }
        else{
            nDamage = d4(nAge*2);
            nDC = nAge+10;
        }
        float fDamage = (IntToFloat(nDamage)/100.0)*30.0;
        nDamage = FloatToInt(fDamage);
        effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
        while(GetIsObjectValid(oTarget)){
            if(GetIsEnemy(oTarget, oPC) && GetIsDead(oTarget) == FALSE){
                SignalEvent(oTarget, EventSpellCastAt(oPC, SPELLABILITY_AURA_COLD));
                if(MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC, SAVING_THROW_TYPE_COLD))
                    nDamage = nDamage / 2;
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_COLD);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
        }
        SetLocalInt(oPC,"AuraDiFreddo_CURRENT",AuraDiFreddo_CURRENT);
        DelayCommand(6.0,AuraDiFreddo(oPC,nTime));
    }
    else
        DeleteLocalInt(oPC,"AuraDiFreddo_CURRENT");
}

void main()
{
    object oPC = OBJECT_SELF;
    int AuraDiFreddo_CURRENT = GetLocalInt(oPC,"AuraDiFreddo_CURRENT");
    int nAge = GetLevelByClass(CLASS_TYPE_DRAGON,oPC);
    int nSag = GetAbilityModifier(ABILITY_WISDOM,oPC);
    int nTime;
    int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,oPC);
    int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,oPC);
    nDruidLv = nMutaLv + nDruidLv;
    nMutaLv = nDruidLv/2;
    effect eDam;
    if (nMutaLv >= 1)
        nTime = 10 + nSag + nMutaLv;
    else
        nTime = nAge + 10;
    if(AuraDiFreddo_CURRENT == 0){
        effect eAOE = EffectVisualEffect(VFX_DUR_AURA_COLD);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, OBJECT_SELF, 6.0);
        SetLocalInt(oPC,"AuraDiFreddo_CURRENT",1);
        AuraDiFreddo(oPC,nTime);
    }
}
