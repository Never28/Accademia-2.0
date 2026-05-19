/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 01-03-2011
*/

// Sciame di Insetti.
#include "mod_bad_dice"
#include "x0_i0_spells"
#include "x2_inc_spellhook"

void AuraDiCprDoom(object oPC,int nTime,location lLocation,int nCasterLvl,int nMetamagic){
    int AuraDiCprDoom_CURRENT = GetLocalInt(oPC,"AuraDiCprDoom_CURRENT");
    if(AuraDiCprDoom_CURRENT < nTime && AuraDiCprDoom_CURRENT != 0){
        AuraDiCprDoom_CURRENT = AuraDiCprDoom_CURRENT + 1;
        int nDC = GetSpellSaveDC();
        int nDam = nNumberRandom(7,nCasterLvl*2);
        if (nMetamagic == METAMAGIC_MAXIMIZE)
            nDam = 14*(nCasterLvl);
        if (nMetamagic == METAMAGIC_EMPOWER)
            nDam = nDam + (nDam/2);
        if(GetHitDice(oPC)==40)
            nDC = nDC +5;
        else if(GetHitDice(oPC)>=31)
            nDC = nDC +3;
        else if(GetHitDice(oPC)>=21)
            nDC = nDC +2;
        else if(GetHitDice(oPC)>=11)
            nDC = nDC +1;
        float fDamage = (IntToFloat(nDam)/100.0)*30.0;
        nDam = FloatToInt(fDamage);
        effect eDam = EffectDamage(nDam, DAMAGE_TYPE_PIERCING);
        effect eVis = EffectVisualEffect(VFX_COM_BLOOD_REG_RED);
        effect eSpeed = EffectMovementSpeedDecrease(50);
        effect eVis2 = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
        eSpeed = EffectLinkEffects(eSpeed, eVis2);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,6.7,lLocation);
        while(GetIsObjectValid(oTarget)){
            if(GetIsDead(oTarget)==FALSE){
                if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC)){
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSpeed, oTarget,6.0);
                }
                else
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSpeed, oTarget,6.0);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,6.7,lLocation);
        }
        SetLocalInt(oPC,"AuraDiCprDoom_CURRENT",AuraDiCprDoom_CURRENT);
        DelayCommand(6.0,AuraDiCprDoom(oPC,nTime,lLocation,nCasterLvl,nMetamagic));
    }
    else{
        DeleteLocalInt(oPC,"AuraDiCprDoom_CURRENT");
        object oTargetAoE = GetNearestObjectToLocation(OBJECT_TYPE_AREA_OF_EFFECT,lLocation);
        string sAoE = GetTag(oTargetAoE);
        if(sAoE == "VFX_PER_CREEPING_DOOM")
            DestroyObject(oTargetAoE);
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    if (!X2PreSpellCastCode())
        return;
    SignalEvent(oPC,EventSpellCastAt(oPC,SPELL_CREEPING_DOOM));
    int AuraDiCprDoom_CURRENT = GetLocalInt(oPC,"AuraDiCprDoom_CURRENT");
    int nTime = GetCasterLevel(oPC)+3;
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
        nTime = nTime *2;
    int nCasterLvl = GetCasterLevel(oPC);
    int nMetamagic = GetMetaMagicFeat();
    location lLocation = GetSpellTargetLocation();
    float fTime = RoundsToSeconds(nTime);
    if(AuraDiCprDoom_CURRENT == 0){
        effect eAOE = EffectAreaOfEffect(AOE_PER_CREEPING_DOOM,"fakespell","fakespell","fakespell");
        SetLocalInt(oPC,"AuraDiCprDoom_CURRENT",1);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
        AuraDiCprDoom(oPC,nTime,lLocation,nCasterLvl,nMetamagic);
    }
    else{
        if(AuraDiCprDoom_CURRENT != 999999){
            SetLocalInt(oPC,"AuraDiCprDoom_CURRENT",999999);
            effect eAOE = EffectAreaOfEffect(AOE_PER_CREEPING_DOOM,"fakespell","fakespell","fakespell");
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
            DelayCommand(6.1,SetLocalInt(oPC,"AuraDiCprDoom_CURRENT",1));
            DelayCommand(6.2,AuraDiCprDoom(oPC,nTime,lLocation,nCasterLvl,nMetamagic));
        }
    }
}

