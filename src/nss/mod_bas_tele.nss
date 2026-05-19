/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 18-06-2009
*/

// Funzione della Mappa di navigazione.

#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;
    object oSpellOrigin;
    object oSpellTarget;
    object oArea;
    string NameoArea,s3Area;
    int iSpell;
    int nResult = X2_EXECUTE_SCRIPT_END;

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
            oArea = GetArea(oPC);
            NameoArea = GetTag(oArea);
            s3Area = GetStringLeft(NameoArea,3);
            if(s3Area == "vil")
                SendMessageToPC(oPC,"Non puoi usare il teletrasporto in questa zona");
            else if(NameoArea=="mod_start"|| NameoArea=="mod_drake_lev"|| NameoArea=="mod_elemental"
            || NameoArea=="mod_stanza"|| NameoArea=="mod_sogno"||NameoArea=="mod_inferno"
            || NameoArea=="mod_deity_druid"|| NameoArea=="dun_che_mag"||GetStringLeft(NameoArea,3) == "tut")
                SendMessageToPC(oPC,"Non puoi usare il teletrasporto in questa zona");
            else
                AssignCommand(oPC,ActionStartConversation(oPC,"mod_bas_tele",TRUE));
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

