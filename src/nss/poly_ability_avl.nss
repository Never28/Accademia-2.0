/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 13-03-2011
*/

// Funzione per l'ira divina della guardia nera.

#include "x2_inc_switches"

void AuraDiMutaG(object oPC,int nTime,int nLevelB, int nDam,int nDmgRedB){
    int AuraDiMutaG_CURRENT = GetLocalInt(oPC,"AuraDiMutaG_CURRENT");
    if(AuraDiMutaG_CURRENT != nTime && AuraDiMutaG_CURRENT != 0){
        AuraDiMutaG_CURRENT = AuraDiMutaG_CURRENT +1;
        effect eAOE = EffectVisualEffect(VFX_DUR_AURA_GREEN_LIGHT);
        effect eAttack = EffectAttackIncrease(nLevelB,ATTACK_BONUS_MISC);
        effect eDamage = EffectDamageIncrease(nDam, DAMAGE_TYPE_POSITIVE);
        effect eSaving = EffectSavingThrowIncrease(SAVING_THROW_ALL,nLevelB, SAVING_THROW_TYPE_ALL);
        effect eReduction = EffectDamageReduction(nDmgRedB, DAMAGE_POWER_PLUS_TWENTY);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eLink = EffectLinkEffects(eAttack, eDamage);
        eLink = EffectLinkEffects(eSaving,eLink);
        eLink = EffectLinkEffects(eReduction,eLink);
        eLink = EffectLinkEffects(eDur,eLink);
        eLink = SupernaturalEffect(eLink);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, 6.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, oPC, 6.0);
        SetLocalInt(oPC,"AuraDiMutaG_CURRENT",AuraDiMutaG_CURRENT);
        DelayCommand(6.0,AuraDiMutaG(oPC,nTime,nLevelB,nDam,nDmgRedB));
    }
    else
        DeleteLocalInt(oPC,"AuraDiMutaG_CURRENT");
}

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC = OBJECT_SELF;
    object oItem;
    object oSpellOrigin;
    object oSpellTarget;
    object oArea;
    string NameoArea;
    int iSpell;
    int nDam = DAMAGE_BONUS_1;
    int nResult = X2_EXECUTE_SCRIPT_END;
    int nTime;
    effect eAttack, eDamage, eSaving, eReduction,eVis,eVis2,eDur,eLink,eAOE;
    int nAttackB,nDamageB,nSaveB,nDmgRedB,nDmgRedP,nLevel,nLevelB,AbilityBlack_CURRENT;
            AbilityBlack_CURRENT = GetLocalInt(oPC,"AuraDiMutaG_CURRENT");
            if(AbilityBlack_CURRENT == 0){
                nTime = 25 + GetAbilityModifier(ABILITY_WISDOM, oPC)+ GetLevelByClass(CLASS_TYPE_SHIFTER,oPC);
                nLevel = 30;
                if(nLevel==1||nLevel==2)
                    nDam = DAMAGE_BONUS_1;
                else if(nLevel==3||nLevel==4)
                    nDam = DAMAGE_BONUS_2;
                else if(nLevel==5||nLevel==6)
                    nDam = DAMAGE_BONUS_3;
                else if(nLevel==7||nLevel==8)
                    nDam = DAMAGE_BONUS_4;
                else if(nLevel==9||nLevel==10)
                    nDam = DAMAGE_BONUS_5;
                else if(nLevel==11||nLevel==12)
                    nDam = DAMAGE_BONUS_6;
                else if(nLevel==13||nLevel==14)
                    nDam = DAMAGE_BONUS_7;
                else if(nLevel==15||nLevel==16)
                    nDam = DAMAGE_BONUS_8;
                else if(nLevel==17||nLevel==18)
                    nDam = DAMAGE_BONUS_9;
                else if(nLevel==19||nLevel==20)
                    nDam = DAMAGE_BONUS_10;
                else if(nLevel==21||nLevel==22)
                    nDam = DAMAGE_BONUS_11;
                else if(nLevel==23||nLevel==24)
                    nDam = DAMAGE_BONUS_12;
                else if(nLevel==25||nLevel==26)
                    nDam = DAMAGE_BONUS_13;
                else if(nLevel==27||nLevel==28)
                    nDam = DAMAGE_BONUS_14;
                else if(nLevel==29||nLevel==30)
                    nDam = DAMAGE_BONUS_15;
        else if(nLevel==31||nLevel==32)
            nDam = DAMAGE_BONUS_16;
        else if(nLevel==23||nLevel==34)
            nDam = DAMAGE_BONUS_17;
        else if(nLevel==35||nLevel==36)
            nDam = DAMAGE_BONUS_18;
        else if(nLevel==37||nLevel==38)
            nDam = DAMAGE_BONUS_19;
        else if(nLevel==39||nLevel==40)
                nLevelB = (nLevel / 3);
                eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
                eVis = EffectLinkEffects(EffectVisualEffect(VFX_FNF_LOS_HOLY_30),eVis);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
                SetLocalInt(oPC,"AuraDiMutaG_CURRENT",1);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, OBJECT_SELF, 6.0);
                nDmgRedB = 12;
                AuraDiMutaG(oPC,nTime,nLevelB,nDam,nDmgRedB);
            }
}
