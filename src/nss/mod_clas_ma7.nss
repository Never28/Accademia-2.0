/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 18-06-2009
*/

// Funzione per la Resurrezione contingente

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;
    object oSpellOrigin;
    object oSpellTarget;
    int EntangleCap;
    int iSpell;
    int nResult = X2_EXECUTE_SCRIPT_END;
    location lTarget;

    switch (nEvent){

        case X2_ITEM_EVENT_ONHITCAST:
            oItem  =  GetSpellCastItem();
            oPC = OBJECT_SELF;
            oSpellOrigin = OBJECT_SELF ;
            oSpellTarget = GetSpellTargetObject();
            break;

        case X2_ITEM_EVENT_ACTIVATE:
            oPC   = GetItemActivator();
            lTarget = GetSpellTargetLocation();
            EntangleCap = GetLocalInt(oPC,"ResurrezioneC");
            if(EntangleCap==0){
                SetLocalInt(oPC,"ResurrezioneC",1);
                SendMessageToPC(oPC,"Resurrezione Contingente Attivata");
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ExtraordinaryEffect(EffectVisualEffect(VFX_DUR_AURA_PULSE_CYAN_WHITE)),oPC,320.0);
                DelayCommand(320.0, SetLocalInt(oPC,"ResurrezioneC",0));
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

