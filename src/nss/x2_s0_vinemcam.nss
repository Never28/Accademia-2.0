/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 01-03-2011
*/

// Viticci Cammuffare.

#include "x0_i0_spells"
#include "x2_inc_spellhook"

void AuraDiVine3(object oPC,int nTime,location lLocation,int nCasterLvl){
    int AuraDiVine3_CURRENT = GetLocalInt(oPC,"AuraDiVine3_CURRENT");
    if(AuraDiVine3_CURRENT < nTime && AuraDiVine3_CURRENT != 0){
        AuraDiVine3_CURRENT = AuraDiVine3_CURRENT + 1;
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
        int Bonus = nCasterLvl/5;
        effect eVis = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eSkill = EffectSkillIncrease(SKILL_HIDE, Bonus);
        effect eLink = EffectLinkEffects(eDur, eSkill);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,5.0,lLocation);
        while(GetIsObjectValid(oTarget)){
            if(GetIsDead(oTarget)==FALSE){
                if(GetIsEnemy(oTarget,oPC)==FALSE){
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, 6.0);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget, 6.0);
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,5.0,lLocation);
        }
        SetLocalInt(oPC,"AuraDiVine3_CURRENT",AuraDiVine3_CURRENT);
        DelayCommand(6.0,AuraDiVine3(oPC,nTime,lLocation,nCasterLvl));
    }
    else{
        DeleteLocalInt(oPC,"AuraDiVine3_CURRENT");
        object oTargetAoE = GetNearestObjectToLocation(OBJECT_TYPE_AREA_OF_EFFECT,lLocation);
        string sAoE = GetTag(oTargetAoE);
        if(sAoE == "VFX_PER_ENTANGLE")
            DestroyObject(oTargetAoE);
        DeleteLocalFloat(oPC,"AuraDiVine3_POSITION1");
        DeleteLocalFloat(oPC,"AuraDiVine3_POSITION2");
        DeleteLocalFloat(oPC,"AuraDiVine3_POSITION3");
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    if (!X2PreSpellCastCode())
        return;
    SignalEvent(oPC,EventSpellCastAt(oPC,SPELL_VINE_MINE_CAMOUFLAGE));
    int AuraDiVine3_CURRENT = GetLocalInt(oPC,"AuraDiVine3_CURRENT");
    int nTime = GetCasterLevel(oPC)+3;
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
        nTime = nTime *2;
    int nCasterLvl = GetCasterLevel(oPC);
    location lLocation = GetSpellTargetLocation();
    float fTime = RoundsToSeconds(nTime);
    vector vSpell = GetPositionFromLocation(lLocation);
    if(AuraDiVine3_CURRENT == 0){
        effect eAOE = EffectAreaOfEffect(AOE_PER_ENTANGLE,"fakespell","fakespell","fakespell");
        SetLocalFloat(oPC,"AuraDiVine3_POSITION1",vSpell.x);
        SetLocalFloat(oPC,"AuraDiVine3_POSITION2",vSpell.y);
        SetLocalFloat(oPC,"AuraDiVine3_POSITION3",vSpell.z);
        SetLocalInt(oPC,"AuraDiVine3_CURRENT",1);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
        AuraDiVine3(oPC,nTime,lLocation,nCasterLvl);
    }
    else{
        if(AuraDiVine3_CURRENT != 999999){
            SetLocalInt(oPC,"AuraDiVine3_CURRENT",999999);
            effect eAOE = EffectAreaOfEffect(AOE_PER_ENTANGLE,"fakespell","fakespell","fakespell");
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
            DelayCommand(6.1,SetLocalFloat(oPC,"AuraDiVine3_POSITION1",vSpell.x));
            DelayCommand(6.1,SetLocalFloat(oPC,"AuraDiVine3_POSITION2",vSpell.y));
            DelayCommand(6.1,SetLocalFloat(oPC,"AuraDiVine3_POSITION3",vSpell.z));
            DelayCommand(6.1,SetLocalInt(oPC,"AuraDiVine3_CURRENT",1));
            DelayCommand(6.2,AuraDiVine3(oPC,nTime,lLocation,nCasterLvl));
        }
    }
}

