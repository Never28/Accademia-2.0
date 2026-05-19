/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 18-06-2009
*/

// Funzione per Sfidare la morte

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;
    object oSpellOrigin;
    object oSpellTarget;
    int iSpell;
    int nResult = X2_EXECUTE_SCRIPT_END;
    location lTarget;
    int EntangleCap;
    switch (nEvent){

        case X2_ITEM_EVENT_ONHITCAST:
            oItem  =  GetSpellCastItem();
            oPC = OBJECT_SELF;
            oSpellOrigin = OBJECT_SELF ;
            oSpellTarget = GetSpellTargetObject();
            break;

        case X2_ITEM_EVENT_ACTIVATE:
            oPC   = GetItemActivator();
            EntangleCap = GetLocalInt(oPC,"DeathChall");
            if(EntangleCap==0){
                SetLocalInt(oPC,"DeathChall",1);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID,100),oPC,12.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING,100),oPC,12.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD,100),oPC,12.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDamageImmunityIncrease(DAMAGE_TYPE_DIVINE,100),oPC,12.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL,100),oPC,12.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE,100),oPC,12.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDamageImmunityIncrease(DAMAGE_TYPE_MAGICAL,100),oPC,12.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE,100),oPC,12.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING,100),oPC,12.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDamageImmunityIncrease(DAMAGE_TYPE_POSITIVE,100),oPC,12.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING,100),oPC,12.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC,100),oPC,12.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectImmunity(IMMUNITY_TYPE_DEATH),oPC,12.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSpellImmunity(SPELL_FLESH_TO_STONE),oPC,12.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSpellImmunity(SPELL_IMPLOSION),oPC,12.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_DEATH),oPC);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ExtraordinaryEffect(EffectVisualEffect(VFX_DUR_AURA_PULSE_MAGENTA_GREEN)),oPC,12.0);
                DelayCommand(320.0, SetLocalInt(oPC,"DeathChall",0));
            }
            else
                SendMessageToPC(OBJECT_SELF,"Questa magia e' lanciabile solo una volta ogni 5 Minuti");
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

