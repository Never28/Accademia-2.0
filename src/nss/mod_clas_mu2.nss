/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 18-06-2009
*/

// Funzione per il Pietrificare di Massa.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

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
    int nResult;
    int nDuration;
    effect eAttack, eDamage, eSaving, eReduction,eVis,eVis2,eDur,eLink;
    int nAttackB,nDamageB,nSaveB,nDmgRedB,nDmgRedP,nLevel,nLevelB;
    object oItemAlcool,oItemAlcool1;
    int nItemAlcool;

    switch (nEvent){

        case X2_ITEM_EVENT_ONHITCAST:
            oItem  =  GetSpellCastItem();
            oPC = OBJECT_SELF;
            oSpellOrigin = OBJECT_SELF ;
            oSpellTarget = GetSpellTargetObject();
            break;

        case X2_ITEM_EVENT_ACTIVATE:
            oPC   = GetItemActivator();
            if(GetLocalInt(oPC,"nMKWrath")==0){
            oItemAlcool = GetItemPossessedBy(oPC,"poz_vino");
            oItemAlcool1 = GetItemPossessedBy(oPC,"poz_birra");
            if(oItemAlcool != OBJECT_INVALID){
                nDuration = 25 + GetAbilityModifier(ABILITY_WISDOM, oPC)+ GetLevelByClass(CLASS_TYPE_MONK,oPC);
                eVis = EffectVisualEffect(VFX_IMP_HEAD_FIRE);
                eVis = EffectLinkEffects(EffectVisualEffect(VFX_FNF_FIREBALL),eVis);
                eVis2 = SupernaturalEffect(EffectVisualEffect(VFX_DUR_AURA_RED));
                nAttackB = 3;
                nDamageB = DAMAGE_BONUS_5;
                nSaveB = 5;
                nDmgRedB = 5;
                nDmgRedP = DAMAGE_POWER_PLUS_ONE;
                nLevel = GetLevelByClass(CLASS_TYPE_MONK,oPC);
                nLevelB = (nLevel / 5);
                if (nLevelB <=0)
                    nLevelB =0;
                else{
                    nAttackB += (nLevelB*2);
                    nSaveB += (nLevelB*2);
                }
                if (nLevelB >5 ){
                    nDmgRedP = DAMAGE_POWER_PLUS_SEVEN;
                    nDmgRedB = 7*5;
                    nDamageB = DAMAGE_BONUS_20;
                }
                else if (nLevelB >4 ){
                    nDmgRedP = DAMAGE_POWER_PLUS_FIVE;
                    nDmgRedB = 5*5;
                    nDamageB = DAMAGE_BONUS_16;
                }
                else if (nLevelB >3){
                    nDmgRedP = DAMAGE_POWER_PLUS_FOUR;
                    nDmgRedB = 4*5;
                    nDamageB = DAMAGE_BONUS_14;
                }
                else if (nLevelB >2){
                    nDmgRedP = DAMAGE_POWER_PLUS_THREE;
                    nDmgRedB = 3*5;
                    nDamageB = DAMAGE_BONUS_11;
                }
                else if (nLevelB >1){
                    nDmgRedP = DAMAGE_POWER_PLUS_TWO;
                    nDmgRedB = 2*5;
                    nDamageB = DAMAGE_BONUS_8;
                }
                else if (nLevelB >0)
                    nDamageB = DAMAGE_BONUS_5;
                AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK,1.0));
                eAttack = EffectAttackIncrease(nAttackB,ATTACK_BONUS_MISC);
                eDamage = EffectDamageIncrease(nDamageB, DAMAGE_TYPE_FIRE);
                eSaving = EffectSavingThrowIncrease(SAVING_THROW_ALL,nSaveB, SAVING_THROW_TYPE_ALL);
                eReduction = EffectDamageReduction(nDmgRedB, nDmgRedP);
                eDur = EffectVisualEffect(VFX_DUR_AURA_PULSE_RED_BLACK);
                eLink = EffectLinkEffects(eAttack, eDamage);
                eLink = EffectLinkEffects(eSaving,eLink);
                eLink = EffectLinkEffects(eReduction,eLink);
                eLink = EffectLinkEffects(eDur,eLink);
                eLink = SupernaturalEffect(eLink);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, RoundsToSeconds(nDuration));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oPC, RoundsToSeconds(nDuration));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
                nItemAlcool = GetItemStackSize(oItemAlcool);
                nItemAlcool = nItemAlcool -1;
                if(nItemAlcool == 0)
                    DestroyObject(oItemAlcool);
                else
                    SetItemStackSize(oItemAlcool,nItemAlcool);
            }
            else if(oItemAlcool1 != OBJECT_INVALID){
                nDuration = 25 + GetAbilityModifier(ABILITY_WISDOM, oPC)+ GetLevelByClass(CLASS_TYPE_MONK,oPC);
                eVis = EffectVisualEffect(VFX_IMP_HEAD_FIRE);
                eVis = EffectLinkEffects(EffectVisualEffect(VFX_FNF_FIREBALL),eVis);
                eVis2 = SupernaturalEffect(EffectVisualEffect(VFX_DUR_AURA_MAGENTA));
                nAttackB = 3;
                nDamageB = DAMAGE_BONUS_5;
                nSaveB = 5;
                nDmgRedB = 5;
                nDmgRedP = DAMAGE_POWER_PLUS_ONE;
                nLevel = GetLevelByClass(CLASS_TYPE_MONK,oPC);
                nLevelB = (nLevel / 5);
                if (nLevelB <=0)
                    nLevelB =0;
                else{
                    nAttackB += (nLevelB*2);
                    nSaveB += (nLevelB*2);
                }
                if (nLevelB >5 ){
                    nDmgRedP = DAMAGE_POWER_PLUS_SEVEN;
                    nDmgRedB = 7*5;
                    nDamageB = DAMAGE_BONUS_20;
                }
                else if (nLevelB >4 ){
                    nDmgRedP = DAMAGE_POWER_PLUS_FIVE;
                    nDmgRedB = 5*5;
                    nDamageB = DAMAGE_BONUS_16;
                }
                else if (nLevelB >3){
                    nDmgRedP = DAMAGE_POWER_PLUS_FOUR;
                    nDmgRedB = 4*5;
                    nDamageB = DAMAGE_BONUS_14;
                }
                else if (nLevelB >2){
                    nDmgRedP = DAMAGE_POWER_PLUS_THREE;
                    nDmgRedB = 3*5;
                    nDamageB = DAMAGE_BONUS_11;
                }
                else if (nLevelB >1){
                    nDmgRedP = DAMAGE_POWER_PLUS_TWO;
                    nDmgRedB = 2*5;
                    nDamageB = DAMAGE_BONUS_8;
                }
                else if (nLevelB >0)
                    nDamageB = DAMAGE_BONUS_5;
                AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK,1.0));
                eAttack = EffectAttackIncrease(nAttackB,ATTACK_BONUS_MISC);
                eDamage = EffectDamageIncrease(nDamageB, DAMAGE_TYPE_FIRE);
                eSaving = EffectSavingThrowIncrease(SAVING_THROW_ALL,nSaveB, SAVING_THROW_TYPE_ALL);
                eReduction = EffectDamageReduction(nDmgRedB, nDmgRedP);
                eDur = EffectVisualEffect(VFX_DUR_AURA_PULSE_BLUE_BLACK);
                eLink = EffectLinkEffects(eAttack, eDamage);
                eLink = EffectLinkEffects(eSaving,eLink);
                eLink = EffectLinkEffects(eReduction,eLink);
                eLink = EffectLinkEffects(eDur,eLink);
                eLink = SupernaturalEffect(eLink);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, RoundsToSeconds(nDuration));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oPC, RoundsToSeconds(nDuration));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
                nItemAlcool = GetItemStackSize(oItemAlcool);
                nItemAlcool = nItemAlcool -1;
                if(nItemAlcool == 0)
                    DestroyObject(oItemAlcool1);
                else
                    SetItemStackSize(oItemAlcool1,nItemAlcool);
            }
            else{
                SendMessageToPC(oPC,"Ti servono alcoolici per effettuare l'abilita'");
            }
            SetLocalInt(oPC,"nMKWrath",1);
            DelayCommand(RoundsToSeconds(nDuration),SetLocalInt(oPC,"nBGWrath",0));
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

