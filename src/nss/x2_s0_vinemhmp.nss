/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 01-03-2011
*/

// Viticci Movimento.

#include "x0_i0_spells"
#include "x2_inc_spellhook"

void AuraDiVine2(object oPC,int nTime,location lLocation){
    int AuraDiVine2_CURRENT = GetLocalInt(oPC,"AuraDiVine2_CURRENT");
    if(AuraDiVine2_CURRENT < nTime && AuraDiVine2_CURRENT != 0){
        AuraDiVine2_CURRENT = AuraDiVine2_CURRENT + 1;
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
        effect eVis = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
        effect eSlow = EffectSlow();
        eSlow = EffectLinkEffects(eSlow,eVis);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,5.0,lLocation);
        while(GetIsObjectValid(oTarget)){
            if(GetIsDead(oTarget)==FALSE){
                if(MyResistSpell(oPC,oTarget)==0){
                    if(!GetHasFeat(FEAT_WOODLAND_STRIDE, oTarget) &&(GetCreatureFlag(oTarget, CREATURE_VAR_IS_INCORPOREAL) != TRUE)){
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oTarget, 6.0);
                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,5.0,lLocation);
        }
        SetLocalInt(oPC,"AuraDiVine2_CURRENT",AuraDiVine2_CURRENT);
        DelayCommand(6.0,AuraDiVine2(oPC,nTime,lLocation));
    }
    else{
        DeleteLocalInt(oPC,"AuraDiVine2_CURRENT");
        object oTargetAoE = GetNearestObjectToLocation(OBJECT_TYPE_AREA_OF_EFFECT,lLocation);
        string sAoE = GetTag(oTargetAoE);
        if(sAoE == "VFX_PER_ENTANGLE")
            DestroyObject(oTargetAoE);
        DeleteLocalFloat(oPC,"AuraDiVine2_POSITION1");
        DeleteLocalFloat(oPC,"AuraDiVine2_POSITION2");
        DeleteLocalFloat(oPC,"AuraDiVine2_POSITION3");
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    if (!X2PreSpellCastCode())
        return;
    SignalEvent(oPC,EventSpellCastAt(oPC,SPELL_VINE_MINE_HAMPER_MOVEMENT));
    int AuraDiVine2_CURRENT = GetLocalInt(oPC,"AuraDiVine2_CURRENT");
    int nTime = GetCasterLevel(oPC)+3;
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
        nTime = nTime *2;
    location lLocation = GetSpellTargetLocation();
    float fTime = RoundsToSeconds(nTime);
    vector vSpell = GetPositionFromLocation(lLocation);
    if(AuraDiVine2_CURRENT == 0){
        effect eAOE = EffectAreaOfEffect(AOE_PER_ENTANGLE,"fakespell","fakespell","fakespell");
        SetLocalFloat(oPC,"AuraDiVine2_POSITION1",vSpell.x);
        SetLocalFloat(oPC,"AuraDiVine2_POSITION2",vSpell.y);
        SetLocalFloat(oPC,"AuraDiVine2_POSITION3",vSpell.z);
        SetLocalInt(oPC,"AuraDiVine2_CURRENT",1);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
        AuraDiVine2(oPC,nTime,lLocation);
    }
    else{
        if(AuraDiVine2_CURRENT != 999999){
            SetLocalInt(oPC,"AuraDiVine2_CURRENT",999999);
            effect eAOE = EffectAreaOfEffect(AOE_PER_ENTANGLE,"fakespell","fakespell","fakespell");
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
            DelayCommand(6.1,SetLocalFloat(oPC,"AuraDiVine2_POSITION1",vSpell.x));
            DelayCommand(6.1,SetLocalFloat(oPC,"AuraDiVine2_POSITION2",vSpell.y));
            DelayCommand(6.1,SetLocalFloat(oPC,"AuraDiVine2_POSITION3",vSpell.z));
            DelayCommand(6.1,SetLocalInt(oPC,"AuraDiVine2_CURRENT",1));
            DelayCommand(6.2,AuraDiVine2(oPC,nTime,lLocation));
        }
    }
}

