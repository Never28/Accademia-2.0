/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 16-06-2009
*/

// La funzione quando si attiva un oggetto e permette di lanciare uno script col nome dell'oggetto attivato.

#include "x2_inc_switches"

void main()
{
    object oItem = GetItemActivated();
    object oPC=OBJECT_SELF;
    object oTarget = GetItemActivatedTarget();
    int nType = GetBaseItemType(oItem);
    SendMessageToPC(oPC,"PARTITO");
    if(nType == BASE_ITEM_SHURIKEN || nType == BASE_ITEM_DART || nType == BASE_ITEM_THROWINGAXE ||
    nType == BASE_ITEM_BULLET || nType == BASE_ITEM_ARROW || nType == BASE_ITEM_BOLT)
        ExecuteScript("mod_fre_ant_spa", oPC);
    location lLocal = GetItemActivatedTargetLocation();
    if (GetStringLeft(GetTag(oItem), 5) == "dmfi_" ||
    GetStringLeft(GetTag(oItem), 8) == "hlslang_")
    {
        SetLocalObject(OBJECT_SELF, "dmfi_item", oItem);
        SetLocalObject(OBJECT_SELF, "dmfi_target", oTarget);
        SetLocalLocation(OBJECT_SELF, "dmfi_location", lLocal);
        ExecuteScript("dmfi_activate", oPC);
        return;
    }
    if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE){
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_ACTIVATE);
        int nRet = ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
            return;
    }
}
