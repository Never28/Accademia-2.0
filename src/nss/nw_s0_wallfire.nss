/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 01-03-2011
*/

// Muro di Fuoco.

#include "x0_i0_spells"
#include "x2_inc_spellhook"

void AuraDiWallFire(object oPC,int nTime,location lLocation,int nCasterLvl,int nMetamagic){
    int AuraDiWallFire_CURRENT = GetLocalInt(oPC,"AuraDiWallFire_CURRENT");
    if(AuraDiWallFire_CURRENT < nTime && AuraDiWallFire_CURRENT != 0){
        AuraDiWallFire_CURRENT = AuraDiWallFire_CURRENT + 1;
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
                nSpec = 50;
                break;
        }
        int nDC = GetSpellSaveDC();
        int nDam = d4(nCasterLvl*2);
        if (nMetamagic == METAMAGIC_MAXIMIZE)
            nDam = 8*(nCasterLvl);
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
        SetLocalInt(oPC,"AuraDiWallFire_CURRENT",AuraDiWallFire_CURRENT);
        DelayCommand(6.0,AuraDiWallFire(oPC,nTime,lLocation,nCasterLvl,nMetamagic));
    }
    else{
        DeleteLocalInt(oPC,"AuraDiWallFire_CURRENT");
        object oTargetAoE = GetNearestObjectToLocation(OBJECT_TYPE_AREA_OF_EFFECT,lLocation);
        string sAoE = GetTag(oTargetAoE);
        if(sAoE == "VFX_PER_WALLFIRE")
            DestroyObject(oTargetAoE);
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    if (!X2PreSpellCastCode())
        return;
    SignalEvent(oPC,EventSpellCastAt(oPC,SPELL_WALL_OF_FIRE));
    int AuraDiWallFire_CURRENT = GetLocalInt(oPC,"AuraDiWallFire_CURRENT");
    int nTime = GetCasterLevel(oPC)+3;
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
        nTime = nTime *2;
    int nCasterLvl = GetCasterLevel(oPC);
    int nMetamagic = GetMetaMagicFeat();
    location lLocation = GetSpellTargetLocation();
    float fTime = RoundsToSeconds(nTime);
    if(AuraDiWallFire_CURRENT == 0){
        effect eAOE = EffectAreaOfEffect(AOE_PER_WALLFIRE,"fakespell","fakespell","fakespell");
        SetLocalInt(oPC,"AuraDiWallFire_CURRENT",1);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
        AuraDiWallFire(oPC,nTime,lLocation,nCasterLvl,nMetamagic);
    }
    else{
        if(AuraDiWallFire_CURRENT != 999999){
            SetLocalInt(oPC,"AuraDiWallFire_CURRENT",999999);
            effect eAOE = EffectAreaOfEffect(AOE_PER_WALLFIRE,"fakespell","fakespell","fakespell");
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
            DelayCommand(6.1,SetLocalInt(oPC,"AuraDiWallFire_CURRENT",1));
            DelayCommand(6.2,AuraDiWallFire(oPC,nTime,lLocation,nMetamagic,nCasterLvl));
        }
    }
}

