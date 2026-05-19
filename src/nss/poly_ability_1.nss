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
                case 6:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_RAGE_3);
                    break;
                case 7:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_RAGE_3);
                    break;
                case 8:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_HOWL_CONFUSE);
                    break;
                case 10:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_RAGE_3);
                    break;
                case 11:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_RAGE_3);
                    break;
                case 14:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_RAGE_3);
                    break;
                case 15:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_BOLT_WEB);
                    break;
                case 16:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_BOLT_WEB);
                    break;
                case 17:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_PULSE_FIRE);
                    break;
                case 18:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_PULSE_DROWN);
                    break;
                case 19:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_PULSE_WHIRLWIND);
                    break;
                case 20:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, 775);
                    break;
                case 21:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_PULSE_FIRE);
                    break;
                case 22:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_PULSE_DROWN);
                    break;
                case 23:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_PULSE_WHIRLWIND);
                    break;
                case 24:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, 775);
                    break;
                case 25:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_FIRE);
                    break;
                case 26:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_LIGHTNING);
                    break;
                case 27:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_ACID);
                    break;
                case 28:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_GAS);
                    break;
                case 29:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_COLD);
                    break;
                case 30:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_FIRE);
                    break;
                case 31:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_LIGHTNING);
                    break;
                case 32:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_COLD);
                    break;
                case 33:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_FIRE);
                    break;
                case 34:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_ACID);
                    break;
                case 36:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELL_HEALING_STING);
                    break;
                case 37:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_RAGE_3);
                    break;
                case 38:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_PULSE_FIRE);
                    break;
                case 39:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_PULSE_COLD);
                    break;
                case 40:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELL_QUILLFIRE);
                    break;
                case 41:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_GAZE_PETRIFY);
                    break;
                case 42:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_GAZE_FEAR);
                    break;
                case 43:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_MANTICORE_SPIKES);
                    break;
                case 44:
                    ExecuteScript("poly_ability_ey1",oPC);
                    break;
                case 45:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_MINDBLAST);
                    break;
                case 46:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELL_DARKNESS);
                    break;
                case 49:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_BOLT_LEVEL_DRAIN);
                    break;
                case 50:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_TYRANT_FOG_MIST);
                    break;
                case 51:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_CONE_DISEASE);
                    break;
                case 52:
                    ExecuteScript("poly_ability_and",oPC);
                    break;
                case 53:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_MINDBLAST);
                    break;
                case 54:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELL_BIGBYS_CLENCHED_FIST);
                    break;
                case 55:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELL_FLAME_ARROW);
                    break;
                case 56:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_HOWL_CONFUSE);
                    break;
                case 57:
                    ExecuteScript("poly_ability_ven",oPC);
                    break;
                case 58:
                    ExecuteScript("poly_ability_pla",oPC);
                    break;
                case 60:
                   ExecuteScript("poly_ability_ho1",oPC);
                    break;
                case 61:
                    ExecuteScript("poly_ability_bal",oPC);
                    break;
                case 62:
                    ExecuteScript("poly_ability_pla",oPC);
                    break;
                case 63:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_BOLT_FIRE);
                    break;
                case 64:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_BOLT_ACID);
                    break;
                case 65:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_BOLT_LIGHTNING);
                    break;
                case 66:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_BOLT_COLD);
                    break;
                case 67:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_BOLT_FIRE);
                    break;
                case 68:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_BOLT_FIRE);
                    break;
                case 69:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_BOLT_FIRE);
                    break;
                case 71:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_GOLEM_BREATH_GAS);
                    break;
                case 72:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_BOLT_DEATH);
                    break;
                case 73:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_BOLT_DEATH);
                    break;
                case 74:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, 775);
                    break;
                case 75:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, 775);
                    break;
                case 76:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_FIRE);
                    break;
                case 77:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_ACID);
                    break;
                case 78:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_LIGHTNING);
                    break;
                case 79:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_COLD);
                    break;
                case 80:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_GAS);
                    break;
                case 81:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_NEGATIVE);
                    break;
                case 82:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_FIRE);
                    break;
                case 83:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_COLD);
                    break;
                case 84:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_FIRE);
                    break;
                case 85:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_ACID);
                    break;
                case 86:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_DRAGON_BREATH_LIGHTNING);
                    break;
                case 87:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, 771);
                    break;
                case 88:
                    CastSpell(oPC, oSpellTarget, oSpellLocation, SPELLABILITY_BREATH_PETRIFY);
                    break;
                default:
                    SendMessageToPC(oPC,"Nessuna Abilita nelle Abilita' 1 per questa Trasformazione");
                    break;
            }
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

