/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 01-03-2011
*/

// Pres di Pietra.

#include "x0_i0_spells"
#include "x2_inc_spellhook"

void AuraDiStone(object oPC,int nTime,location lLocation,int nMetamagic){
    int AuraDiStone_CURRENT = GetLocalInt(oPC,"AuraDiStone_CURRENT");
    if(AuraDiStone_CURRENT < nTime && AuraDiStone_CURRENT != 0){
        AuraDiStone_CURRENT = AuraDiStone_CURRENT + 1;
        int nDC = GetSpellSaveDC();
        int nClass = GetLastSpellCastClass();
        if(GetHitDice(oPC)==40)
            nDC = nDC +5;
        else if(GetHitDice(oPC)>=31)
            nDC = nDC +3;
        else if(GetHitDice(oPC)>=21)
            nDC = nDC +2;
        else if(GetHitDice(oPC)>=11)
            nDC = nDC +1;
        effect eVis = EffectVisualEffect(VFX_DUR_STONEHOLD);
        effect ePara = EffectParalyze();
        ePara = EffectLinkEffects(ePara,eVis);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,10.0,lLocation);
        while(GetIsObjectValid(oTarget)){
            if(GetIsDead(oTarget)==FALSE){
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC) && MyResistSpell(oPC,oTarget)==0 && GetIsImmune(oTarget,IMMUNITY_TYPE_PARALYSIS)==FALSE)
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePara, oTarget, 6.0);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,10.0,lLocation);
        }
        SetLocalInt(oPC,"AuraDiStone_CURRENT",AuraDiStone_CURRENT);
        DelayCommand(6.0,AuraDiStone(oPC,nTime,lLocation,nMetamagic));
    }
    else{
        DeleteLocalInt(oPC,"AuraDiStone_CURRENT");
        object oTargetAoE = GetNearestObjectToLocation(OBJECT_TYPE_AREA_OF_EFFECT,lLocation);
        string sAoE = GetTag(oTargetAoE);
        if(sAoE == "VFX_PER_STONEHOLD")
            DestroyObject(oTargetAoE);
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    if (!X2PreSpellCastCode())
        return;
    SignalEvent(oPC,EventSpellCastAt(oPC,SPELL_STONEHOLD));
    int AuraDiStone_CURRENT = GetLocalInt(oPC,"AuraDiStone_CURRENT");
    int nTime = GetCasterLevel(oPC)+3;
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
        nTime = nTime *2;
    int nMetamagic = GetMetaMagicFeat();
    location lLocation = GetSpellTargetLocation();
    float fTime = RoundsToSeconds(nTime);
    if(AuraDiStone_CURRENT == 0){
        effect eAOE = EffectAreaOfEffect(AOE_PER_STONEHOLD,"fakespell","fakespell","fakespell");
        SetLocalInt(oPC,"AuraDiStone_CURRENT",1);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
        AuraDiStone(oPC,nTime,lLocation,nMetamagic);
    }
    else{
        if(AuraDiStone_CURRENT != 999999){
            SetLocalInt(oPC,"AuraDiStone_CURRENT",999999);
            effect eAOE = EffectAreaOfEffect(AOE_PER_STONEHOLD,"fakespell","fakespell","fakespell");
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
            DelayCommand(6.1,SetLocalInt(oPC,"AuraDiStone_CURRENT",1));
            DelayCommand(6.2,AuraDiStone(oPC,nTime,lLocation,nMetamagic));
        }
    }
}
