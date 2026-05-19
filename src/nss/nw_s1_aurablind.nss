/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 26-02-2011
*/

// Aura di Accecamento.

#include "x0_i0_spells"
#include "x3_inc_string"

string sNomeCorretto(object oPC){
    string sName = StringReplace(GetPCPlayerName(oPC)," ","X");
    sName = StringReplace(sName,".","Y");
    sName = StringReplace(sName,"-","Z");
    sName = StringReplace(sName,"_","K");
    return sName;
}

void AuraDiAcceca(object oPC, int nTime,int nRound){
    int AuraDiAcceca_CURRENT = GetLocalInt(oPC,"AuraDiAcceca_CURRENT");
    if(AuraDiAcceca_CURRENT != nTime && AuraDiAcceca_CURRENT != 0){
        AuraDiAcceca_CURRENT = AuraDiAcceca_CURRENT +1;
        string AuraDiAcceca_IMMUNI = GetLocalString(oPC,"AuraDiAcceca_IMMUNI");
        effect eAOE = EffectVisualEffect(VFX_DUR_AURA_SILENCE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, oPC, 6.0);
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
        effect eDeath = EffectBlindness();
        effect eVis = EffectVisualEffect(VFX_IMP_BREACH);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
        int nThrow;
        while(GetIsObjectValid(oTarget)){
            if(GetIsEnemy(oTarget, oPC) && GetIsDead(oTarget) == FALSE){
                if(GetIsPC(oTarget) == TRUE){
                    nControll = FindSubString(AuraDiAcceca_IMMUNI,sNomeCorretto(oTarget));
                    if(nControll == -1){
                        nThrow = MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS);
                        if(nThrow == 0 ){
                            if(GetIsImmune(oTarget,IMMUNITY_TYPE_DEATH)==FALSE){
                                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDeath, oTarget,RoundsToSeconds(nRound));
                                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget);
                            }
                            else
                                SetLocalString(oPC,"AuraDiAcceca_IMMUNI",AuraDiAcceca_IMMUNI+sNomeCorretto(oTarget)+" ");
                        }
                        else
                            SetLocalString(oPC,"AuraDiAcceca_IMMUNI",AuraDiAcceca_IMMUNI+sNomeCorretto(oTarget)+" ");
                    }
                }
                else{
                    sMorteMOB = GetLocalString(oTarget,"AuraDiAcceca_SALVO");
                    nControll = FindSubString(sMorteMOB,sNomeCorretto(oPC));
                    if(nControll == -1){
                        nThrow = MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_DEATH);
                        if(nThrow ==0 ){
                            if(GetIsImmune(oTarget,IMMUNITY_TYPE_DEATH)==FALSE){
                                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDeath, oTarget,RoundsToSeconds(nRound));
                                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                                break;
                            }
                            else
                                ActionDoCommand(SetLocalString(oTarget,"AuraDiAcceca_SALVO",sMorteMOB+sNomeCorretto(oPC)+" "));
                        }
                        else
                            ActionDoCommand(SetLocalString(oTarget,"AuraDiAcceca_SALVO",sMorteMOB+sNomeCorretto(oPC)+" "));
                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
        }
        SetLocalInt(oPC,"AuraDiAcceca_CURRENT",AuraDiAcceca_CURRENT);
        DelayCommand(6.0,AuraDiAcceca(oPC,nTime,nRound));
    }
    else{
        DeleteLocalInt(oPC,"AuraDiAcceca_CURRENT");
        DeleteLocalString(oPC,"AuraDiAcceca_IMMUNI");
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    int AuraDiAcceca_CURRENT = GetLocalInt(oPC,"AuraDiAcceca_CURRENT");
    int nAge = GetLevelByClass(CLASS_TYPE_DRAGON,oPC);
    int nSag = GetAbilityModifier(ABILITY_WISDOM,oPC);
    int nTime;
    int nRound;
    int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,oPC);
    int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,oPC);
    nDruidLv = nMutaLv + nDruidLv;
    nMutaLv = nDruidLv/2;
    effect eDam;
    if (nMutaLv >= 1){
        nTime = 10 + nSag + nMutaLv;
        nRound = nDruidLv;
    }
    else{
        nTime = nAge + 10;
        nRound = nAge;
    }
    if(AuraDiAcceca_CURRENT == 0){
        effect eAOE = EffectVisualEffect(VFX_DUR_AURA_SILENCE);
        SetLocalInt(oPC,"AuraDiAcceca_CURRENT",1);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, OBJECT_SELF, 6.0);
        AuraDiAcceca(oPC,nTime,nRound);
    }
}
