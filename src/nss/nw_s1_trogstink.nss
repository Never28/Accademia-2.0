/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 26-02-2011
*/

// Aura di Troglodita.

#include "x0_i0_spells"

void AuraDiTroglo(object oPC, int nTime){
    int AuraDiTroglo_CURRENT = GetLocalInt(oPC,"AuraDiTroglo_CURRENT");
    if(AuraDiTroglo_CURRENT != nTime && AuraDiTroglo_CURRENT != 0){
        AuraDiTroglo_CURRENT = AuraDiTroglo_CURRENT +1;
        string AuraDiTroglo_IMMUNI = GetLocalString(oPC,"AuraDiTroglo_IMMUNI");
        int nAge = GetHitDice(oPC);
        int nSag = GetAbilityModifier(ABILITY_WISDOM,oPC);
        int nDamage;
        int nDC;
        int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,oPC);
        int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,oPC);
        nDruidLv = nMutaLv + nDruidLv;
        nMutaLv = nDruidLv/2;
        effect eDam;
        if (nMutaLv >= 1){
            nDC = 10 + nSag + nMutaLv;
        }
        else{
            nDC = nAge+10;
        }
        int nControll = -1;
        string sMorteMOB;
        effect eDeath = EffectAbilityDecrease(ABILITY_STRENGTH, d12(1));
        eDeath = ExtraordinaryEffect(eDeath);
        effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
        effect eVis2 = EffectVisualEffect(VFX_IMP_FORTITUDE_SAVING_THROW_USE);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
        int nThrow;
        while(GetIsObjectValid(oTarget)){
            if(GetIsEnemy(oTarget, oPC) && GetIsDead(oTarget) == FALSE){
                if(GetIsPC(oTarget) == TRUE){
                    nControll = FindSubString(AuraDiTroglo_IMMUNI,GetName(oTarget)+GetPCPlayerName(oTarget));
                    if(nControll == -1){
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
                        nThrow = MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_POISON);
                        if(nThrow == 0 ){
                            if(GetIsImmune(oTarget,IMMUNITY_TYPE_POISON) == FALSE){
                                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDeath, oTarget);
                                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                            }
                            else
                                SetLocalString(oPC,"AuraDiTroglo_IMMUNI",AuraDiTroglo_IMMUNI+GetName(oTarget)+GetPCPlayerName(oTarget)+" ");
                        }
                        else
                            SetLocalString(oPC,"AuraDiTroglo_IMMUNI",AuraDiTroglo_IMMUNI+GetName(oTarget)+GetPCPlayerName(oTarget)+" ");
                    }
                }
                else{
                    sMorteMOB = GetLocalString(oTarget,"AuraDiTroglo_SALVO");
                    nControll = FindSubString(sMorteMOB,GetName(oPC)+GetPCPlayerName(oPC));
                    if(nControll == -1){
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
                        nThrow = MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_POISON);
                        if(nThrow == 0){
                            if(GetIsImmune(oTarget,IMMUNITY_TYPE_POISON)==FALSE){
                                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDeath, oTarget);
                                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                            }
                            else
                                ActionDoCommand(SetLocalString(oTarget,"AuraDiTroglo_SALVO",sMorteMOB+GetName(oPC)+GetPCPlayerName(oPC)+" "));
                        }
                        else
                            ActionDoCommand(SetLocalString(oTarget,"AuraDiTroglo_SALVO",sMorteMOB+GetName(oPC)+GetPCPlayerName(oPC)+" "));
                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
        }
        SetLocalInt(oPC,"AuraDiTroglo_CURRENT",AuraDiTroglo_CURRENT);
        DelayCommand(6.0,AuraDiTroglo(oPC,nTime));
    }
    else{
        DeleteLocalInt(oPC,"AuraDiTroglo_CURRENT");
        DeleteLocalString(oPC,"AuraDiTroglo_IMMUNI");
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    int AuraDiTroglo_CURRENT = GetLocalInt(oPC,"AuraDiTroglo_CURRENT");
    int nAge = GetLevelByClass(CLASS_TYPE_DRAGON,oPC);
    int nSag = GetAbilityModifier(ABILITY_WISDOM,oPC);
    int nTime;
    int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,oPC);
    int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,oPC);
    nDruidLv = nMutaLv + nDruidLv;
    nMutaLv = nDruidLv/2;
    effect eDam;
    if (nMutaLv >= 1)
        nTime = 10 + nSag + nMutaLv;
    else
        nTime = nAge + 10;
    if(AuraDiTroglo_CURRENT == 0){
        effect eAOE = SupernaturalEffect(EffectAreaOfEffect(AOE_MOB_TROGLODYTE_STENCH,"fakespell","fakespell","fakespell"));
        SetLocalInt(oPC,"AuraDiTroglo_CURRENT",1);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAOE, OBJECT_SELF);
        AuraDiTroglo(oPC,nTime);
    }
}

