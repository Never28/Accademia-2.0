/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 18-06-2009
*/

// Funzione per Attivare il Cambio Elemento

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
    int nElement;
    int nStatus;
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
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_FNF_NATURES_BALANCE),oPC);
            if(GetItemPossessedBy(oPC,"mod_clas_se1") != OBJECT_INVALID)
                nElement = 1;
            if(GetItemPossessedBy(oPC,"mod_clas_se2") != OBJECT_INVALID)
                nElement = 2;
            if(GetItemPossessedBy(oPC,"mod_clas_se3") != OBJECT_INVALID)
                nElement = 3;
            if(GetItemPossessedBy(oPC,"mod_clas_se4") != OBJECT_INVALID)
                nElement = 4;
            nStatus = GetLocalInt(oPC,"SapienteElementale");
            if(nStatus == 0){
                SetLocalInt(oPC,"SapienteElementale",nElement);
                SendMessageToPC(oPC,"Potere Elementale ATTIVATO!");
            }
            else{
                SetLocalInt(oPC,"SapienteElementale",0);
                SendMessageToPC(oPC,"Potere Elementale DISATTIVATO!");
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

