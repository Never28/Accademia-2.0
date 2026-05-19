/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 01-03-2011
*/

// Barriera di Lame.

#include "x0_i0_spells"
#include "x2_inc_spellhook"

void AuraDiLame(object oPC,int nTime,location lLocation,int nCasterLvl,int nMetamagic){
    int AuraDiLame_CURRENT = GetLocalInt(oPC,"AuraDiLame_CURRENT");
    if(AuraDiLame_CURRENT < nTime && AuraDiLame_CURRENT != 0){
        AuraDiLame_CURRENT = AuraDiLame_CURRENT + 1;
        int nDC = GetSpellSaveDC();
        int nDam = d6(nCasterLvl*2);
        if (nMetamagic == METAMAGIC_MAXIMIZE)
            nDam = 12*(nCasterLvl);
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
        effect eVis = EffectVisualEffect(VFX_COM_BLOOD_LRG_RED);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,5.0,lLocation);
        while(GetIsObjectValid(oTarget)){
            if(GetIsDead(oTarget)==FALSE){
                if(MyResistSpell(oPC,oTarget)==0){
                    nDam = GetReflexAdjustedDamage(nDam, oTarget, nDC);
                    effect eDam = EffectDamage(nDam, DAMAGE_TYPE_SLASHING);
                    if(nDam > 0){
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,5.0,lLocation);
        }
        SetLocalInt(oPC,"AuraDiLame_CURRENT",AuraDiLame_CURRENT);
        DelayCommand(6.0,AuraDiLame(oPC,nTime,lLocation,nCasterLvl,nMetamagic));
    }
    else{
        DeleteLocalInt(oPC,"AuraDiLame_CURRENT");
        object oTargetAoE = GetNearestObjectToLocation(OBJECT_TYPE_AREA_OF_EFFECT,lLocation);
        string sAoE = GetTag(oTargetAoE);
        if(sAoE == "VFX_PER_WALLBLADE")
            DestroyObject(oTargetAoE);
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    if (!X2PreSpellCastCode())
        return;
    SignalEvent(oPC,EventSpellCastAt(oPC,SPELL_BLADE_BARRIER));
    int AuraDiLame_CURRENT = GetLocalInt(oPC,"AuraDiLame_CURRENT");
    int nTime = GetCasterLevel(oPC)+3;
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
        nTime = nTime *2;
    int nCasterLvl = GetCasterLevel(oPC);
    int nMetamagic = GetMetaMagicFeat();
    location lLocation = GetSpellTargetLocation();
    float fTime = RoundsToSeconds(nTime);
    if(AuraDiLame_CURRENT == 0){
        effect eAOE = EffectAreaOfEffect(AOE_PER_WALLBLADE,"fakespell","fakespell","fakespell");
        SetLocalInt(oPC,"AuraDiLame_CURRENT",1);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
        AuraDiLame(oPC,nTime,lLocation,nCasterLvl,nMetamagic);
    }
    else{
        if(AuraDiLame_CURRENT != 999999){
            SetLocalInt(oPC,"AuraDiLame_CURRENT",999999);
            effect eAOE = EffectAreaOfEffect(AOE_PER_WALLBLADE,"fakespell","fakespell","fakespell");
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
            DelayCommand(6.1,SetLocalInt(oPC,"AuraDiLame_CURRENT",1));
            DelayCommand(6.2,AuraDiLame(oPC,nTime,lLocation,nCasterLvl,nMetamagic));
        }
    }
}

