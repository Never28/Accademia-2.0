/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 01-03-2011
*/

// Tempesta di Vendetta.

#include "mod_bad_dice"
#include "x0_i0_spells"
#include "x2_inc_spellhook"

void AuraDiStorm(object oPC,int nTime,location lLocation,int nCasterLvl,int nMetamagic){
    int AuraDiStorm_CURRENT = GetLocalInt(oPC,"AuraDiStorm_CURRENT");
    if(AuraDiStorm_CURRENT < nTime && AuraDiStorm_CURRENT != 0){
        AuraDiStorm_CURRENT = AuraDiStorm_CURRENT + 1;
        int nDC = GetSpellSaveDC();
        int nDam = nNumberRandom(9,nCasterLvl*2);
        if (nMetamagic == METAMAGIC_MAXIMIZE)
            nDam = 18*(nCasterLvl);
        if (nMetamagic == METAMAGIC_EMPOWER)
            nDam = nDam + (nDam/2);
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
        float fDamage = (IntToFloat(nDam)/100.0)*20.0;
        nDam = FloatToInt(fDamage);
        effect eAcid = EffectDamage(nDam/2, DAMAGE_TYPE_ACID);
        effect eElec = EffectDamage(nDam/2, DAMAGE_TYPE_ELECTRICAL);
        effect eStun = EffectStunned();
        effect eVisAcid = EffectVisualEffect(VFX_IMP_ACID_S);
        effect eVisElec = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
        effect eVisStun = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
        effect eLink = EffectLinkEffects(eStun, eVisStun);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,10.0,lLocation);
        while(GetIsObjectValid(oTarget)){
            if(GetIsDead(oTarget)==FALSE){
                if(GetIsEnemy(oTarget, oPC)){
                    if(MyResistSpell(oPC,oTarget)==0){
                        if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC)){
                            ApplyEffectToObject(DURATION_TYPE_INSTANT, eAcid, oTarget);
                            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisAcid, oTarget);
                            ApplyEffectToObject(DURATION_TYPE_INSTANT, eElec, oTarget);
                            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisElec, oTarget);
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget,6.0);
                        }
                        else{
                            ApplyEffectToObject(DURATION_TYPE_INSTANT, eAcid, oTarget);
                            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisAcid, oTarget);
                        }
                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,10.0,lLocation);
        }
        SetLocalInt(oPC,"AuraDiStorm_CURRENT",AuraDiStorm_CURRENT);
        DelayCommand(6.0,AuraDiStorm(oPC,nTime,lLocation,nCasterLvl,nMetamagic));
    }
    else{
        DeleteLocalInt(oPC,"AuraDiStorm_CURRENT");
        object oTargetAoE = GetNearestObjectToLocation(OBJECT_TYPE_AREA_OF_EFFECT,lLocation);
        string sAoE = GetTag(oTargetAoE);
        if(sAoE == "VFX_PER_STORM")
            DestroyObject(oTargetAoE);
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    if (!X2PreSpellCastCode())
        return;
    SignalEvent(oPC,EventSpellCastAt(oPC,SPELL_STORM_OF_VENGEANCE));
    int AuraDiStorm_CURRENT = GetLocalInt(oPC,"AuraDiStorm_CURRENT");
    int nTime = GetCasterLevel(oPC)+3;
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
        nTime = nTime *2;
    int nCasterLvl = GetCasterLevel(oPC);
    int nMetamagic = GetMetaMagicFeat();
    location lLocation = GetSpellTargetLocation();
    float fTime = RoundsToSeconds(nTime);
    if(AuraDiStorm_CURRENT == 0){
        effect eAOE = EffectAreaOfEffect(AOE_PER_STORM,"fakespell","fakespell","fakespell");
        SetLocalInt(oPC,"AuraDiStorm_CURRENT",1);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
        AuraDiStorm(oPC,nTime,lLocation,nCasterLvl,nMetamagic);
    }
    else{
        if(AuraDiStorm_CURRENT != 999999){
            SetLocalInt(oPC,"AuraDiStorm_CURRENT",999999);
            effect eAOE = EffectAreaOfEffect(AOE_PER_STORM,"fakespell","fakespell","fakespell");
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
            DelayCommand(6.1,SetLocalInt(oPC,"AuraDiStorm_CURRENT",1));
            DelayCommand(6.2,AuraDiStorm(oPC,nTime,lLocation,nCasterLvl,nMetamagic));
        }
    }
}

