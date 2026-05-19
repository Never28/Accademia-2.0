/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 26-02-2011
*/

// Aura di Morte.

#include "x0_i0_spells"
#include "x3_inc_string"

string sNomeCorretto(object oPC){
    string sName = StringReplace(GetPCPlayerName(oPC)," ","X");
    sName = StringReplace(sName,".","Y");
    sName = StringReplace(sName,"-","Z");
    sName = StringReplace(sName,"_","K");
    return sName;
}

void AuraDiMorte(object oPC, int nTime){
    int AuraDiMorte_CURRENT = GetLocalInt(oPC,"AuraDiMorte_CURRENT");
    if(AuraDiMorte_CURRENT != nTime && AuraDiMorte_CURRENT != 0){
        AuraDiMorte_CURRENT = AuraDiMorte_CURRENT +1;
        string AuraDiMorte_IMMUNI = GetLocalString(oPC,"AuraDiMorte_IMMUNI");
        effect eAOE = EffectVisualEffect(VFX_DUR_AURA_ODD);
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
        effect eDeath = EffectDeath();
        effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
        int nThrow;
        while(GetIsObjectValid(oTarget)){
            if(GetIsEnemy(oTarget, oPC) && GetIsDead(oTarget) == FALSE){
                if(GetIsPC(oTarget) == TRUE){
                    nControll = FindSubString(AuraDiMorte_IMMUNI,sNomeCorretto(oTarget));
                    if(nControll == -1){
                        nThrow = MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DEATH);
                        if(nThrow == 0 ){
                            if(GetIsImmune(oTarget,IMMUNITY_TYPE_DEATH) == FALSE){
                                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget);
                                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                            }
                            else
                                SetLocalString(oPC,"AuraDiMorte_IMMUNI",AuraDiMorte_IMMUNI+sNomeCorretto(oTarget)+" ");
                        }
                        else
                            SetLocalString(oPC,"AuraDiMorte_IMMUNI",AuraDiMorte_IMMUNI+sNomeCorretto(oTarget)+" ");
                    }
                }
                else{
                    sMorteMOB = GetLocalString(oTarget,"AuraDiMorte_SALVO");
                    nControll = FindSubString(sMorteMOB,sNomeCorretto(oPC));
                    if(nControll == -1){
                        nThrow = MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DEATH);
                        if(nThrow == 0){
                            if(GetIsImmune(oTarget,IMMUNITY_TYPE_DEATH)==FALSE){
                                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget);
                                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                            }
                            else
                                ActionDoCommand(SetLocalString(oTarget,"AuraDiMorte_SALVO",sMorteMOB+sNomeCorretto(oPC)+" "));
                        }
                        else
                            ActionDoCommand(SetLocalString(oTarget,"AuraDiMorte_SALVO",sMorteMOB+sNomeCorretto(oPC)+" "));
                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
        }
        SetLocalInt(oPC,"AuraDiMorte_CURRENT",AuraDiMorte_CURRENT);
        DelayCommand(6.0,AuraDiMorte(oPC,nTime));
    }
    else{
        DeleteLocalInt(oPC,"AuraDiMorte_CURRENT");
        DeleteLocalString(oPC,"AuraDiMorte_IMMUNI");
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    int AuraDiMorte_CURRENT = GetLocalInt(oPC,"AuraDiMorte_CURRENT");
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
    if(AuraDiMorte_CURRENT == 0){
        effect eAOE = EffectVisualEffect(VFX_DUR_AURA_ODD);
        SetLocalInt(oPC,"AuraDiMorte_CURRENT",1);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, OBJECT_SELF, 6.0);
        AuraDiMorte(oPC,nTime);
    }
}
