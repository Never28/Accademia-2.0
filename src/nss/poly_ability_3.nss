/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 28-06-2009
*/

// Abilita 1 delle Trasformazioni.

#include "x2_inc_switches"

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
    object oPC = GetItemActivator();;
    object oItem;
    object oSpellOrigin;
    object oSpellTarget = GetItemActivatedTarget();
    string NamePC = GetTag(oPC);
    int iSpell;
    int nResult = X2_EXECUTE_SCRIPT_END;
    int nNumers = GetLocalInt(oPC,"poly_ability");
    location oSpellLocation = GetItemActivatedTargetLocation();

    switch (nEvent){

        case X2_ITEM_EVENT_ONHITCAST:
            oItem  =  GetSpellCastItem();
            oPC = OBJECT_SELF;
            oSpellOrigin = OBJECT_SELF ;
            oSpellTarget = GetSpellTargetObject();
            break;

        case X2_ITEM_EVENT_ACTIVATE:
            // Chi ha usato l'item
            oPC   = GetItemActivator();
            // l'item Attivato
            oItem = GetItemActivated();
            switch (nNumers){
                case 1:
                    break;
                case 2:
                    break;
                case 11:
                    ExecuteScript("poly_ability_tir",oPC);
                    break;
                case 16:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELL_MELFS_ACID_ARROW);
                    break;
                case 44:
                    ExecuteScript("poly_ability_ey3",oPC);
                    break;
                case 45:
                    ExecuteScript("poly_ability_dm3",oPC);
                    break;
                case 46:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELL_DARKVISION);
                    break;
                case 53:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELL_WEIRD);
                    break;
                case 54:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELL_WAIL_OF_THE_BANSHEE);
                    break;
                case 58:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_TURN_UNDEAD);
                    break;
                case 62:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_TURN_UNDEAD);
                    break;
                case 75:
                    ExecuteScript("poly_ability_ada",oPC);
                    break;
                case 81:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, 757);
                    break;
                case 87:
                    ExecuteScript("poly_ability_psh",oPC);
                    break;
                default:
                    SendMessageToPC(oPC,"Nessuna Abilita nelle Abilita' 3 per questa Trasformazione");
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

