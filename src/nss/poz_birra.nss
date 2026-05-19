#include "x2_inc_switches"

effect eEffectRet(int nRandom){
    effect eEffectEnt;
    switch(nRandom){
        case 0:
            eEffectEnt = EffectACIncrease(2, AC_DODGE_BONUS, AC_VS_DAMAGE_TYPE_ALL);
            break;
        case 1:
            eEffectEnt = EffectACDecrease(2, AC_DODGE_BONUS, AC_VS_DAMAGE_TYPE_ALL);
            break;
        case 2:
            eEffectEnt = EffectAbilityIncrease(ABILITY_STRENGTH,2);
            break;
        case 3:
            eEffectEnt = EffectAbilityIncrease(ABILITY_WISDOM,2);
            break;
        case 4:
            eEffectEnt = EffectAbilityIncrease(ABILITY_INTELLIGENCE,2);
            break;
        case 5:
            eEffectEnt = EffectAbilityIncrease(ABILITY_DEXTERITY,2);
            break;
        case 6:
            eEffectEnt = EffectAbilityIncrease(ABILITY_CONSTITUTION,2);
            break;
        case 7:
            eEffectEnt = EffectAbilityIncrease(ABILITY_CHARISMA,2);
            break;
        case 8:
            eEffectEnt = EffectAbilityDecrease(ABILITY_STRENGTH,2);
            break;
        case 9:
            eEffectEnt = EffectAbilityDecrease(ABILITY_WISDOM,2);
            break;
        case 10:
            eEffectEnt = EffectAbilityDecrease(ABILITY_INTELLIGENCE,2);
            break;
        case 11:
            eEffectEnt = EffectAbilityDecrease(ABILITY_DEXTERITY,2);
            break;
        case 12:
            eEffectEnt = EffectAbilityDecrease(ABILITY_CONSTITUTION,2);
            break;
        case 13:
            eEffectEnt = EffectAbilityDecrease(ABILITY_CHARISMA,2);
            break;
        case 14:
            eEffectEnt = EffectAttackIncrease(2);
            break;
        case 15:
            eEffectEnt = EffectAttackDecrease(2);
            break;
    }
    return eEffectEnt;
}

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;
    object oSpellOrigin;
    object oSpellTarget;
    effect eEffect1,eEffect2,eEffect3,eEffect4;
    int nRandom,nBevuta;
        string sName;
    object oModule;
    int iSpell;
    int nResult = X2_EXECUTE_SCRIPT_END;

    switch (nEvent)
    {
        case X2_ITEM_EVENT_ONHITCAST:
            oItem  =  GetSpellCastItem();
            oPC = OBJECT_SELF;
            oSpellOrigin = OBJECT_SELF ;
            oSpellTarget = GetSpellTargetObject();
            break;

        case X2_ITEM_EVENT_ACTIVATE:
            oPC   = GetItemActivator();
            oItem = GetItemActivated();
            nBevuta = GetLocalInt(oPC,"b_1");
            nRandom = Random(16);
            if(nBevuta == 0){
                SetLocalInt(oPC,"b_1",1);
                eEffect1 = eEffectRet(nRandom);
                eEffect2 = eEffectRet(nRandom);
                eEffect3 = EffectVisualEffect(VFX_DUR_BARD_SONG);
                eEffect3 = EffectLinkEffects(eEffect1,eEffect3);
                eEffect3 = EffectLinkEffects(eEffect2,eEffect3);
                eEffect4 = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,eEffect3,oPC,60.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect4,oPC,1.0);
                DelayCommand(60.0,SetLocalInt(oPC,"b_1",0));
            }
            else
                SendMessageToPC(oPC,"Non puoi bere piu' di una volta ogni 60 secondi");
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

