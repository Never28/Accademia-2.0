/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 01-03-2011
*/

// Nube Incendiaria.

#include "x0_i0_spells"
#include "x2_inc_spellhook"

void AuraDiIncendiary(object oPC,int nTime,location lLocation,int nCasterLvl,int nMetamagic){
    int AuraDiIncendiary_CURRENT = GetLocalInt(oPC,"AuraDiIncendiary_CURRENT");
    if(AuraDiIncendiary_CURRENT < nTime && AuraDiIncendiary_CURRENT != 0){
        AuraDiIncendiary_CURRENT = AuraDiIncendiary_CURRENT + 1;
        int nSave = SAVING_THROW_TYPE_FIRE;
        int nType = DAMAGE_TYPE_FIRE;
        int nSpec=0;
        int nElement = GetLocalInt(oPC,"SapienteElementale");
        switch(nElement){
            case 1:
                nType = DAMAGE_TYPE_BLUDGEONING;
                break;
            case 2:
                nType = DAMAGE_TYPE_COLD;
                break;
            case 3:
                nType = DAMAGE_TYPE_ELECTRICAL;
                break;
            case 4:
                nType = DAMAGE_TYPE_FIRE;
                nSpec = 90;
                break;
        }
        int nDC = GetSpellSaveDC();
        int nDam = d8(nCasterLvl*2);
        if (nMetamagic == METAMAGIC_MAXIMIZE)
            nDam = 16*(nCasterLvl);
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
        float fDamage = (IntToFloat(nDam+nSpec)/100.0)*65.0;
        nDam = FloatToInt(fDamage);
        effect eDam = EffectDamage(nDam, nType);
        effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,5.0,lLocation);
        while(GetIsObjectValid(oTarget)){
            if(GetIsDead(oTarget)==FALSE){
                if(MyResistSpell(oPC,oTarget)==0){
                    nDam = GetReflexAdjustedDamage(nDam, oTarget, nDC, nSave);
                    eDam = EffectDamage(nDam, nType);
                    if(nDam > 0){
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,5.0,lLocation);
        }
        SetLocalInt(oPC,"AuraDiIncendiary_CURRENT",AuraDiIncendiary_CURRENT);
        DelayCommand(6.0,AuraDiIncendiary(oPC,nTime,lLocation,nCasterLvl,nMetamagic));
    }
    else{
        DeleteLocalInt(oPC,"AuraDiIncendiary_CURRENT");
        object oTargetAoE = GetNearestObjectToLocation(OBJECT_TYPE_AREA_OF_EFFECT,lLocation);
        string sAoE = GetTag(oTargetAoE);
        if(sAoE == "VFX_PER_FOGFIRE")
            DestroyObject(oTargetAoE);
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    if (!X2PreSpellCastCode())
        return;
    SignalEvent(oPC,EventSpellCastAt(oPC,SPELL_INCENDIARY_CLOUD));
    int AuraDiIncendiary_CURRENT = GetLocalInt(oPC,"AuraDiIncendiary_CURRENT");
    int nTime = GetCasterLevel(oPC)+3;
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
        nTime = nTime *2;
    int nCasterLvl = GetCasterLevel(oPC);
    int nMetamagic = GetMetaMagicFeat();
    location lLocation = GetSpellTargetLocation();
    float fTime = RoundsToSeconds(nTime);
    if(AuraDiIncendiary_CURRENT == 0){
        effect eAOE = EffectAreaOfEffect(AOE_PER_FOGFIRE,"fakespell","fakespell","fakespell");
        SetLocalInt(oPC,"AuraDiIncendiary_CURRENT",1);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
        AuraDiIncendiary(oPC,nTime,lLocation,nCasterLvl,nMetamagic);
    }
    else{
        if(AuraDiIncendiary_CURRENT != 999999){
            SetLocalInt(oPC,"AuraDiIncendiary_CURRENT",999999);
            effect eAOE = EffectAreaOfEffect(AOE_PER_FOGFIRE,"fakespell","fakespell","fakespell");
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
            DelayCommand(6.1,SetLocalInt(oPC,"AuraDiIncendiary_CURRENT",1));
            DelayCommand(6.2,AuraDiIncendiary(oPC,nTime,lLocation,nMetamagic,nCasterLvl));
        }
    }
}

