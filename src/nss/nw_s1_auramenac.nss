/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 26-02-2011
*/

// Aura di Minaccia/Elementale della Terra.

#include "x0_i0_spells"

void AuraDiTerra(object oPC,int nTime){
    int AuraDiTerra_CURRENT = GetLocalInt(oPC,"AuraDiTerra_CURRENT");
    if(AuraDiTerra_CURRENT != nTime && AuraDiTerra_CURRENT != 0){
        AuraDiTerra_CURRENT = AuraDiTerra_CURRENT +1;
        effect eAOE = EffectVisualEffect(VFX_DUR_AURA_POISON);
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
        if(GetAppearanceType(oPC)==APPEARANCE_TYPE_ELEMENTAL_EARTH_ELDER){
            float fDamage = (IntToFloat(nDamage)/100.0)*30.0;
            nDamage = FloatToInt(fDamage);
            effect eVis = EffectVisualEffect(VFX_IMP_SPIKE_TRAP);
            object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
            while(GetIsObjectValid(oTarget)){
                if(GetIsEnemy(oTarget, oPC) && GetIsDead(oTarget) == FALSE){
                    SignalEvent(oTarget, EventSpellCastAt(oPC, SPELLABILITY_AURA_MENACE));
                    if(MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC, SAVING_THROW_TYPE_ACID))
                        nDamage = nDamage / 2;
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                }
                oTarget = GetNextObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
            }
        }
        else if(GetAppearanceType(oPC)==APPEARANCE_TYPE_TROLL){
            float fDamage = (IntToFloat(nDamage)/100.0)*30.0;
            nDamage = FloatToInt(fDamage);
            effect eVis = EffectVisualEffect(VFX_IMP_ACID_L);
            object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
            while(GetIsObjectValid(oTarget)){
                if(GetIsEnemy(oTarget, oPC) && GetIsDead(oTarget) == FALSE){
                    SignalEvent(oTarget, EventSpellCastAt(oPC, SPELLABILITY_AURA_MENACE));
                    if(MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC, SAVING_THROW_TYPE_ACID))
                        nDamage = nDamage / 2;
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                }
                oTarget = GetNextObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
            }
        }
        else{
            effect eVis = EffectVisualEffect(VFX_IMP_DOOM);
            effect eLink = CreateDoomEffectsLink();
            object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
            while(GetIsObjectValid(oTarget)){
                if(GetIsEnemy(oTarget, oPC) && GetIsDead(oTarget) == FALSE){
                    SignalEvent(oTarget, EventSpellCastAt(oPC, SPELLABILITY_AURA_MENACE));
                    if (!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC)){
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink , oTarget, 6.0);
                    }
                }
                oTarget = GetNextObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
            }
        }
        SetLocalInt(oPC,"AuraDiTerra_CURRENT",AuraDiTerra_CURRENT);
        DelayCommand(6.0,AuraDiTerra(oPC,nTime));
    }
    else
        DeleteLocalInt(oPC,"AuraDiTerra_CURRENT");
}

void main()
{
    object oPC = OBJECT_SELF;
    int AuraDiTerra_CURRENT = GetLocalInt(oPC,"AuraDiTerra_CURRENT");
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
    if(AuraDiTerra_CURRENT == 0){
        effect eAOE = EffectVisualEffect(VFX_DUR_AURA_POISON);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, OBJECT_SELF, 6.0);
        SetLocalInt(oPC,"AuraDiTerra_CURRENT",1);
        AuraDiTerra(oPC,nTime);
    }
}
