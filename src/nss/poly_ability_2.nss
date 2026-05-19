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
    object oPC = GetItemActivator();
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
                case 11:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_HOWL_CONFUSE);
                    break;
                case 14:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELL_MESTILS_ACID_BREATH);
                    break;
                case 16:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_PULSE_POISON);
                    break;
                case 21:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_AURA_FIRE);
                    break;
                case 22:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_AURA_COLD);
                    break;
                case 23:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_AURA_ELECTRICITY);
                    break;
                case 24:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_AURA_MENACE);
                    break;
                case 44:
                    ExecuteScript("poly_ability_ey2",oPC);
                    break;
                case 45:
                    ExecuteScript("poly_ability_dm2",oPC);
                    break;
                case 46:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_BOLT_WEB);
                    break;
                case 53:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_AURA_UNEARTHLY_VISAGE);
                    break;
                case 54:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_AURA_UNEARTHLY_VISAGE);
                    break;
                case 55:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_AURA_FIRE);
                    break;
                case 56:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_AURA_BLINDING);
                    break;
                case 57:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_PULSE_HOLY);
                    break;
                case 58:
                    ExecuteScript("poly_ability_avl",oPC);
                    break;
                case 60:
                    ExecuteScript("poly_ability_ho2",oPC);
                    break;
                case 61:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_PULSE_NEGATIVE);
                    break;
                case 62:
                    ExecuteScript("poly_ability_avd",oPC);
                    break;
                case 69:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_AURA_UNEARTHLY_VISAGE);
                    break;
                case 74:
                    ExecuteScript("poly_ability_gm1",oPC);
                    break;
                case 75:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_AURA_ELECTRICITY);
                    break;
                case 76:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_FEAR);
                    break;
                case 77:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_FEAR);
                    break;
                case 78:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_FEAR);
                    break;
                case 79:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_FEAR);
                    break;
                case 80:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_FEAR);
                    break;
                case 81:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_FEAR);
                    break;
                case 82:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_WEAKEN);
                    break;
                case 83:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_PARALYZE);
                    break;
                case 84:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_SLEEP);
                    break;
                case 85:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_SLOW);
                    break;
                case 86:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_FEAR);
                    break;
                case 87:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_FEAR);
                    break;
                case 88:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_FEAR);
                    break;
                default:
                    SendMessageToPC(oPC,"Nessuna Abilita nelle Abilita' 2 per questa Trasformazione");
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

