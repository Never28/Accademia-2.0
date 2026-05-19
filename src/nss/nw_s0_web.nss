/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 27-02-2011
*/

// Ragnatela.

#include "x0_i0_spells"
#include "x2_inc_spellhook"

void AuraDiWeb(object oPC,int nTime,location lLocation){
    int AuraDiWeb_CURRENT = GetLocalInt(oPC,"AuraDiWeb_CURRENT");
    if(AuraDiWeb_CURRENT < nTime && AuraDiWeb_CURRENT != 0){
        AuraDiWeb_CURRENT = AuraDiWeb_CURRENT + 1;
        int nDC = GetSpellSaveDC();
        int nClass = GetLastSpellCastClass();
    if(nClass == CLASS_TYPE_RANGER){
        int nRang = GetLevelByClass(CLASS_TYPE_RANGER,OBJECT_SELF);
        if(nRang >=21)
            nDC = nDC +9;
        else if(nRang >=17)
            nDC = nDC +7;
        else if(nRang >=14)
            nDC = nDC +6;
        else if(nRang >=11)
            nDC = nDC +5;
        else if(nRang >=8)
            nDC = nDC +3;
        else
            nDC = nDC +2;
    }
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
        effect eVis = EffectVisualEffect(VFX_DUR_WEB);
        effect eEntangle = EffectEntangle();
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,6.7,lLocation);
        while(GetIsObjectValid(oTarget)){
            if(GetIsDead(oTarget)==FALSE){
                if(GetCreatureFlag(oTarget, CREATURE_VAR_IS_INCORPOREAL) != TRUE){
                    if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC) && MyResistSpell(oPC,oTarget)==0 && GetIsImmune(oTarget,IMMUNITY_TYPE_ENTANGLE)==FALSE){
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 6.0);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEntangle, oTarget, 6.0);
                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,6.7,lLocation);
        }
        SetLocalInt(oPC,"AuraDiWeb_CURRENT",AuraDiWeb_CURRENT);
        DelayCommand(6.0,AuraDiWeb(oPC,nTime,lLocation));
    }
    else{
        DeleteLocalInt(oPC,"AuraDiWeb_CURRENT");
        object oTargetAoE = GetNearestObjectToLocation(OBJECT_TYPE_AREA_OF_EFFECT,lLocation);
        string sAoE = GetTag(oTargetAoE);
        if(sAoE == "VFX_PER_WEB")
            DestroyObject(oTargetAoE);
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    if (!X2PreSpellCastCode())
        return;
    SignalEvent(oPC,EventSpellCastAt(oPC,SPELL_WEB));
    int AuraDiWeb_CURRENT = GetLocalInt(oPC,"AuraDiWeb_CURRENT");
    int nTime = GetCasterLevel(oPC)+3;
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
        nTime = nTime *2;
    location lLocation = GetSpellTargetLocation();
    float fTime = RoundsToSeconds(nTime);
    if(AuraDiWeb_CURRENT == 0){
        effect eAOE = EffectAreaOfEffect(AOE_PER_WEB,"fakespell","fakespell","fakespell");
        SetLocalInt(oPC,"AuraDiWeb_CURRENT",1);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
        AuraDiWeb(oPC,nTime,lLocation);
    }
    else{
        if(AuraDiWeb_CURRENT != 999999){
            SetLocalInt(oPC,"AuraDiWeb_CURRENT",999999);
            effect eAOE = EffectAreaOfEffect(AOE_PER_WEB,"fakespell","fakespell","fakespell");
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
            DelayCommand(6.1,SetLocalInt(oPC,"AuraDiWeb_CURRENT",1));
            DelayCommand(6.2,AuraDiWeb(oPC,nTime,lLocation));
        }
    }
}

