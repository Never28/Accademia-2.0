/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 18-06-2009
*/

// Funzione per il Pietrificare di Massa.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void CastSpell(object oPC, object oSpellTarget, location oSpellLocation, int nSpell)
{
    if(oSpellTarget!=OBJECT_INVALID)
        AssignCommand(oPC,ActionCastSpellAtObject(nSpell, oSpellTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    else
        AssignCommand(oPC,ActionCastSpellAtLocation(nSpell, oSpellLocation, METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
}


void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC = GetItemActivator();
    object oItem;
    object oSpellOrigin;
    object oSpellTarget = GetItemActivatedTarget();
    string NamePC = GetTag(oPC);
    int iSpell;
    int nResult = X2_EXECUTE_SCRIPT_END;
    int nNumers = GetLocalInt(oPC,"poly_ability");
    location oSpellLocation = GetItemActivatedTargetLocation();
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
            oItemAlcool = GetItemPossessedBy(oPC,"poz_vino");
            oItemAlcool1 = GetItemPossessedBy(oPC,"poz_birra");
            if(oItemAlcool != OBJECT_INVALID){
                AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK,1.0));
                CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_FIRE);
                nItemAlcool = GetItemStackSize(oItemAlcool);
                nItemAlcool = nItemAlcool -1;
                if(nItemAlcool == 0)
                    DestroyObject(oItemAlcool);
                else
                    SetItemStackSize(oItemAlcool,nItemAlcool);
            }
            else if(oItemAlcool1 != OBJECT_INVALID){
                AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK,1.0));
                CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_FIRE);
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

