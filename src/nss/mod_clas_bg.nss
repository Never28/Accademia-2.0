/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 13-03-2011
*/

// Funzione per l'ira divina della guardia nera.

#include "x2_inc_switches"

void AuraDiBlack(object oPC,int nTime,int nLevelB, int nDam,int nDmgRedB){
    int AuraDiBlack_CURRENT = GetLocalInt(oPC,"AuraDiBlack_CURRENT");
    if(AuraDiBlack_CURRENT < nTime && AuraDiBlack_CURRENT != 0){
        AuraDiBlack_CURRENT = AuraDiBlack_CURRENT +1;
        effect eAOE = EffectVisualEffect(VFX_DUR_AURA_RED_DARK);
        effect eAttack = EffectAttackIncrease(nLevelB,ATTACK_BONUS_MISC);
        effect eDamage = EffectDamageIncrease(nDam, DAMAGE_TYPE_NEGATIVE);
        effect eSaving = EffectSavingThrowIncrease(SAVING_THROW_ALL,nLevelB, SAVING_THROW_TYPE_ALL);
        effect eReduction = EffectDamageReduction(nDmgRedB, DAMAGE_POWER_PLUS_TWENTY);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
        effect eLink = EffectLinkEffects(eAttack, eDamage);
        eLink = EffectLinkEffects(eSaving,eLink);
        eLink = EffectLinkEffects(eReduction,eLink);
        eLink = EffectLinkEffects(eDur,eLink);
        eLink = SupernaturalEffect(eLink);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, 6.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, oPC, 6.0);
        SetLocalInt(oPC,"AuraDiBlack_CURRENT",AuraDiBlack_CURRENT);
        DelayCommand(6.0,AuraDiBlack(oPC,nTime,nLevelB,nDam,nDmgRedB));
    }
    else
        DeleteLocalInt(oPC,"AuraDiBlack_CURRENT");
}

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;
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

    switch (nEvent){

        case X2_ITEM_EVENT_ONHITCAST:
            oItem  =  GetSpellCastItem();
            oPC = OBJECT_SELF;
            oSpellOrigin = OBJECT_SELF ;
            oSpellTarget = GetSpellTargetObject();
            break;

        case X2_ITEM_EVENT_ACTIVATE:
            oPC   = GetItemActivator();
            oItem = GetItemActivated();
            AbilityBlack_CURRENT = GetLocalInt(oPC,"AuraDiBlack_CURRENT");
            if(AbilityBlack_CURRENT == 0){
                nTime = 25 + GetAbilityModifier(ABILITY_CHARISMA, oPC)+ GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) ;
                nLevel = GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC);
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
                nLevelB = (nLevel / 3);
                eVis = EffectVisualEffect(VFX_IMP_HEAD_EVIL);
                eVis = EffectLinkEffects(EffectVisualEffect(VFX_FNF_LOS_EVIL_30),eVis);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
                SetLocalInt(oPC,"AuraDiBlack_CURRENT",1);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, OBJECT_SELF, 6.0);
                nDmgRedB = (GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC))/10;
                if(nDmgRedB == 0){
                    nDmgRedB = 3;
                }
                AuraDiBlack(oPC,nTime,nLevelB,nDam,nDmgRedB);
            }

            break;

        case X2_ITEM_EVENT_EQUIP:

            oPC = GetPCItemLastEquippedBy();
            oItem = GetPCItemLastEquipped();
            break;

        case X2_ITEM_EVENT_UNEQUIP:
            oPC    = GetPCItemLastUnequippedBy();
            oItem  = GetPCItemLastUnequipped();
            break;

        case X2_ITEM_EVENT_ACQUIRE:
            oPC = GetModuleItemAcquiredBy();
            oItem  = GetModuleItemAcquired();
            break;

        case X2_ITEM_EVENT_UNACQUIRE:
            oPC = GetModuleItemLostBy();
            oItem  = GetModuleItemLost();
            break;

       case X2_ITEM_EVENT_SPELLCAST_AT:
            oPC = OBJECT_SELF;
            oItem  = GetSpellTargetObject();
            iSpell = GetSpellId();
            nResult = X2_EXECUTE_SCRIPT_CONTINUE;
            break;
    }
    SetExecutedScriptReturnValue(nResult);
}

