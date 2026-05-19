/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 26-02-2011
*/

// Aura di Paura.

#include "x0_i0_spells"
#include "x3_inc_string"

string sNomeCorretto(object oPC){
    string sName = StringReplace(GetPCPlayerName(oPC)," ","X");
    sName = StringReplace(sName,".","Y");
    sName = StringReplace(sName,"-","Z");
    sName = StringReplace(sName,"_","K");
    return sName;
}

void AuraDiFear(object oPC, int nTime,int nRound){
    int AuraDiFear_CURRENT = GetLocalInt(oPC,"AuraDiFear_CURRENT");
    if(AuraDiFear_CURRENT != nTime && AuraDiFear_CURRENT != 0){
        AuraDiFear_CURRENT = AuraDiFear_CURRENT +1;
        string AuraDiFear_IMMUNI = GetLocalString(oPC,"AuraDiFear_IMMUNI");
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
        effect eFear = EffectFrightened();
        effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
        int nThrow;
        while(GetIsObjectValid(oTarget)){
            if(GetIsEnemy(oTarget, oPC) && GetIsDead(oTarget) == FALSE){
                if(GetIsPC(oTarget) == TRUE){
                    nControll = FindSubString(AuraDiFear_IMMUNI,sNomeCorretto(oTarget));
                    if(nControll == -1){
                        nThrow = MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_FEAR);
                        if(nThrow == 0 ){
                            if(GetIsImmune(oTarget,IMMUNITY_TYPE_FEAR)==FALSE){
                                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFear, oTarget,RoundsToSeconds(nRound));
                                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget,RoundsToSeconds(nRound));
                            }
                            else
                                SetLocalString(oPC,"AuraDiFear_IMMUNI",AuraDiFear_IMMUNI+sNomeCorretto(oTarget)+" ");
                        }
                        else
                            SetLocalString(oPC,"AuraDiFear_IMMUNI",AuraDiFear_IMMUNI+sNomeCorretto(oTarget)+" ");
                    }
                }
                else{
                    sMorteMOB = GetLocalString(oTarget,"AuraDiFear_SALVO");
                    nControll = FindSubString(sMorteMOB,sNomeCorretto(oPC));
                    if(nControll == -1){
                        nThrow = MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_FEAR);
                        if(nThrow ==0 ){
                            if(GetIsImmune(oTarget,IMMUNITY_TYPE_FEAR)==FALSE){
                                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFear, oTarget,RoundsToSeconds(nRound));
                                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget,RoundsToSeconds(nRound));
                            }
                            else
                                ActionDoCommand(SetLocalString(oTarget,"AuraDiFear_SALVO",sMorteMOB+sNomeCorretto(oPC)+" "));
                        }
                        else
                            ActionDoCommand(SetLocalString(oTarget,"AuraDiFear_SALVO",sMorteMOB+sNomeCorretto(oPC)+" "));
                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
        }
        SetLocalInt(oPC,"AuraDiFear_CURRENT",AuraDiFear_CURRENT);
        DelayCommand(6.0,AuraDiFear(oPC,nTime,nRound));
    }
    else{
        DeleteLocalInt(oPC,"AuraDiFear_CURRENT");
        DeleteLocalString(oPC,"AuraDiFear_IMMUNI");
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    int AuraDiFear_CURRENT = GetLocalInt(oPC,"AuraDiFear_CURRENT");
    int nAge = GetHitDice(oPC);
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
    if(AuraDiFear_CURRENT == 0){
        effect eAOE = EffectVisualEffect(VFX_DUR_AURA_SILENCE);
        SetLocalInt(oPC,"AuraDiFear_CURRENT",1);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, OBJECT_SELF, 6.0);
        AuraDiFear(oPC,nTime,nRound);
    }
}
