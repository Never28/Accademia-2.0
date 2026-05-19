/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 27-02-2011
*/

// Intralciare.

#include "x0_i0_spells"
#include "x2_inc_spellhook"

void AuraDiEntangle(object oPC,int nTime,location lLocation){
    int AuraDiEntangle_CURRENT = GetLocalInt(oPC,"AuraDiEntangle_CURRENT");
    if(AuraDiEntangle_CURRENT < nTime && AuraDiEntangle_CURRENT != 0){
        AuraDiEntangle_CURRENT = AuraDiEntangle_CURRENT + 1;
        int nDC = GetSpellSaveDC();
        int nClass = GetLastSpellCastClass();
        if(nClass == CLASS_TYPE_RANGER){
            int nRang = GetLevelByClass(CLASS_TYPE_RANGER,OBJECT_SELF);
            if(nRang >=21)
                nDC = nDC +7;
            else if(nRang >=17)
                nDC = nDC +5;
            else if(nRang >=14)
                nDC = nDC +4;
            else if(nRang >=11)
                nDC = nDC +3;
            else if(nRang >=8)
                nDC = nDC +2;
            else
                nDC = nDC +1;
        }
        if(GetHitDice(OBJECT_SELF)==40)
            nDC = nDC +5;
        else if(GetHitDice(OBJECT_SELF)>=31)
            nDC = nDC +3;
        else if(GetHitDice(OBJECT_SELF)>=21)
            nDC = nDC +2;
        else if(GetHitDice(OBJECT_SELF)>=11)
            nDC = nDC +1;
        effect eVis = EffectVisualEffect(VFX_DUR_ENTANGLE);
        effect eEntangle = EffectEntangle();
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,5.0,lLocation);
        while(GetIsObjectValid(oTarget)){
            if(GetIsDead(oTarget)==FALSE){
                if(!GetHasFeat(FEAT_WOODLAND_STRIDE, oTarget) &&(GetCreatureFlag(oTarget, CREATURE_VAR_IS_INCORPOREAL) != TRUE)){
                    if(MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC)==0 && MyResistSpell(oPC,oTarget)==0 && GetIsImmune(oTarget,IMMUNITY_TYPE_ENTANGLE)==FALSE){
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 6.0);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEntangle, oTarget, 6.0);
                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,5.0,lLocation);
        }
        SetLocalInt(oPC,"AuraDiEntangle_CURRENT",AuraDiEntangle_CURRENT);
        DelayCommand(6.0,AuraDiEntangle(oPC,nTime,lLocation));
    }
    else{
        DeleteLocalInt(oPC,"AuraDiEntangle_CURRENT");
        object oTargetAoE = GetNearestObjectToLocation(OBJECT_TYPE_AREA_OF_EFFECT,lLocation);
        string sAoE = GetTag(oTargetAoE);
        if(sAoE == "VFX_PER_ENTANGLE")
            DestroyObject(oTargetAoE);
        DeleteLocalFloat(oPC,"AuraDiEntangle_POSITION1");
        DeleteLocalFloat(oPC,"AuraDiEntangle_POSITION2");
        DeleteLocalFloat(oPC,"AuraDiEntangle_POSITION3");
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    if (!X2PreSpellCastCode())
        return;
    SignalEvent(oPC,EventSpellCastAt(oPC,SPELL_ENTANGLE));
    int AuraDiEntangle_CURRENT = GetLocalInt(oPC,"AuraDiEntangle_CURRENT");
    int nTime = GetCasterLevel(oPC)+3;
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
        nTime = nTime *2;
    location lLocation = GetSpellTargetLocation();
    float fTime = RoundsToSeconds(nTime);
    vector vSpell = GetPositionFromLocation(lLocation);
    if(AuraDiEntangle_CURRENT == 0){
        effect eAOE = EffectAreaOfEffect(AOE_PER_ENTANGLE,"fakespell","fakespell","fakespell");
        SetLocalFloat(oPC,"AuraDiEntangle_POSITION1",vSpell.x);
        SetLocalFloat(oPC,"AuraDiEntangle_POSITION2",vSpell.y);
        SetLocalFloat(oPC,"AuraDiEntangle_POSITION3",vSpell.z);
        SetLocalInt(oPC,"AuraDiEntangle_CURRENT",1);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
        AuraDiEntangle(oPC,nTime,lLocation);
    }
    else{
        if(AuraDiEntangle_CURRENT != 999999){
            SetLocalInt(oPC,"AuraDiEntangle_CURRENT",999999);
            effect eAOE = EffectAreaOfEffect(AOE_PER_ENTANGLE,"fakespell","fakespell","fakespell");
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
            DelayCommand(6.1,SetLocalFloat(oPC,"AuraDiEntangle_POSITION1",vSpell.x));
            DelayCommand(6.1,SetLocalFloat(oPC,"AuraDiEntangle_POSITION2",vSpell.y));
            DelayCommand(6.1,SetLocalFloat(oPC,"AuraDiEntangle_POSITION3",vSpell.z));
            DelayCommand(6.1,SetLocalInt(oPC,"AuraDiEntangle_CURRENT",1));
            DelayCommand(6.2,AuraDiEntangle(oPC,nTime,lLocation));
        }
    }
}

