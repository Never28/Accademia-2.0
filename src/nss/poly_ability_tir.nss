/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 29-06-2009
*/

// Tigre Leggendaria abilita 2

#include "NW_I0_SPELLS"

void AuraDiTigre(object oPC,int nTime,int nLevelB, int nDam,int nDmgRedB){
    int AuraDiTigre_CURRENT = GetLocalInt(oPC,"AuraDiTigre_CURRENT");
    if(AuraDiTigre_CURRENT < nTime && AuraDiTigre_CURRENT != 0){
        AuraDiTigre_CURRENT = AuraDiTigre_CURRENT +1;
        effect eAOE = EffectVisualEffect(VFX_DUR_AURA_GREEN_LIGHT);
        effect eAttack = EffectAttackIncrease(nLevelB,ATTACK_BONUS_MISC);
        effect eDamage = EffectDamageIncrease(nDam, DAMAGE_TYPE_ACID);
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
        SetLocalInt(oPC,"AuraDiTigre_CURRENT",AuraDiTigre_CURRENT);
        DelayCommand(6.0,AuraDiTigre(oPC,nTime,nLevelB,nDam,nDmgRedB));
    }
    else
        DeleteLocalInt(oPC,"AuraDiTigre_CURRENT");
}

void main()
{
    //Declare major variables
    object oPC = OBJECT_SELF;
    int nDam;
    int AbilityTigre_CURRENT = GetLocalInt(oPC,"AuraDiTigre_CURRENT");
    if(AbilityTigre_CURRENT == 0){
        int nTime = 25 + GetAbilityModifier(ABILITY_CHARISMA, oPC)+ GetLevelByClass(CLASS_TYPE_DRUID,oPC) ;
        int nLevel = GetLevelByClass(CLASS_TYPE_DRUID,oPC);
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
            nDam = DAMAGE_BONUS_20;
        int nLevelB = (nLevel / 4);
        effect eAOE;
        effect eVis = EffectVisualEffect(VFX_IMP_HEAD_EVIL);
        eVis = EffectLinkEffects(EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY),eVis);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
        SetLocalInt(oPC,"AuraDiTigre_CURRENT",1);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, OBJECT_SELF, 6.0);
        int nDmgRedB = (GetLevelByClass(CLASS_TYPE_DRUID,oPC))/10;
        if(nDmgRedB == 0)
            nDmgRedB = 3;
        AuraDiTigre(oPC,nTime,nLevelB,nDam,nDmgRedB);
    }
}


