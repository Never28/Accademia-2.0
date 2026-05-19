/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 01-03-2011
*/

// Crescita di Spine.

#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "mod_bad_dice"

void AuraDiSpike(object oPC,int nTime,location lLocation,int nCasterLvl,int nMetamagic){
    int AuraDiSpike_CURRENT = GetLocalInt(oPC,"AuraDiSpike_CURRENT");
    if(AuraDiSpike_CURRENT < nTime && AuraDiSpike_CURRENT != 0){
        AuraDiSpike_CURRENT = AuraDiSpike_CURRENT + 1;
        int nDC = GetSpellSaveDC();
        int nDam = nNumberRandom(3,nCasterLvl*2);
        if (nMetamagic == METAMAGIC_MAXIMIZE)
            nDam = 6*(nCasterLvl);
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
        float fDamage = (IntToFloat(nDam)/100.0)*65.0;
        nDam = FloatToInt(fDamage);
        effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,5.0,lLocation);
        while(GetIsObjectValid(oTarget)){
            if(GetIsDead(oTarget)==FALSE){
                if(MyResistSpell(oPC,oTarget)==0){
                    nDam = GetReflexAdjustedDamage(nDam, oTarget, nDC);
                    effect eDam = EffectDamage(nDam, DAMAGE_TYPE_PIERCING);
                    if(nDam > 0){
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,5.0,lLocation);
        }
        SetLocalInt(oPC,"AuraDiSpike_CURRENT",AuraDiSpike_CURRENT);
        DelayCommand(6.0,AuraDiSpike(oPC,nTime,lLocation,nCasterLvl,nMetamagic));
    }
    else{
        DeleteLocalInt(oPC,"AuraDiSpike_CURRENT");
        object oTargetAoE = GetNearestObjectToLocation(OBJECT_TYPE_AREA_OF_EFFECT,lLocation);
        string sAoE = GetTag(oTargetAoE);
        if(sAoE == "VFX_PER_ENTANGLE")
            DestroyObject(oTargetAoE);
        DeleteLocalFloat(oPC,"AuraDiSpike_POSITION1");
        DeleteLocalFloat(oPC,"AuraDiSpike_POSITION2");
        DeleteLocalFloat(oPC,"AuraDiSpike_POSITION3");
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    if (!X2PreSpellCastCode())
        return;
    SignalEvent(oPC,EventSpellCastAt(oPC,SPELL_SPIKE_GROWTH));
    int AuraDiSpike_CURRENT = GetLocalInt(oPC,"AuraDiSpike_CURRENT");
    int nTime = GetCasterLevel(oPC)+3;
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
        nTime = nTime *2;
    int nCasterLvl = GetCasterLevel(oPC);
    int nMetamagic = GetMetaMagicFeat();
    location lLocation = GetSpellTargetLocation();
    float fTime = RoundsToSeconds(nTime);
    vector vSpell = GetPositionFromLocation(lLocation);
    if(AuraDiSpike_CURRENT == 0){
        effect eAOE = EffectAreaOfEffect(AOE_PER_ENTANGLE,"fakespell","fakespell","fakespell");
        SetLocalFloat(oPC,"AuraDiSpike_POSITION1",vSpell.x);
        SetLocalFloat(oPC,"AuraDiSpike_POSITION2",vSpell.y);
        SetLocalFloat(oPC,"AuraDiSpike_POSITION3",vSpell.z);
        SetLocalInt(oPC,"AuraDiSpike_CURRENT",1);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, GetSpellTargetLocation(), RoundsToSeconds(nTime));
        AuraDiSpike(oPC,nTime,GetSpellTargetLocation(),nCasterLvl,nMetamagic);
    }
    else{
        if(AuraDiSpike_CURRENT != 999999){
            SetLocalInt(oPC,"AuraDiSpike_CURRENT",999999);
            effect eAOE = EffectAreaOfEffect(AOE_PER_ENTANGLE,"fakespell","fakespell","fakespell");
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
            DelayCommand(6.1,SetLocalFloat(oPC,"AuraDiSpike_POSITION1",vSpell.x));
            DelayCommand(6.1,SetLocalFloat(oPC,"AuraDiSpike_POSITION2",vSpell.y));
            DelayCommand(6.1,SetLocalFloat(oPC,"AuraDiSpike_POSITION3",vSpell.z));
            DelayCommand(6.1,SetLocalInt(oPC,"AuraDiSpike_CURRENT",1));
            DelayCommand(6.2,AuraDiSpike(oPC,nTime,lLocation,nCasterLvl,nMetamagic));
        }
    }
}

