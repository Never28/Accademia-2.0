/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// La funzione per quando viene tolta un'arma dall'inventario.

#include "x2_inc_switches"
#include "x2_inc_intweapon"
#include "x3_inc_horse"
#include "mod_pc_equip_fun"

void main()
{
    object oItem = GetPCItemLastUnequipped();
    object oPC   = GetPCItemLastUnequippedBy();
    int nRangedType = GetBaseItemType(oItem);
    string sRefVeste;
    UnControllSet(oPC,oItem);
    if(nRangedType==BASE_ITEM_BOLT){
        DestroyObject(oItem,0.0);
    }
    else if(nRangedType==BASE_ITEM_ARROW){
        DestroyObject(oItem,0.0);
    }
    else if(nRangedType==BASE_ITEM_BULLET){
        DestroyObject(oItem,0.0);
    }
    else if(nRangedType==BASE_ITEM_LONGBOW||nRangedType==BASE_ITEM_SHORTBOW){
        object oItem1 = GetItemInSlot(INVENTORY_SLOT_ARROWS,oPC);
        DestroyObject(oItem1,0.0);
    }
    else if(nRangedType==BASE_ITEM_SLING){
        object oItem1 = GetItemInSlot(INVENTORY_SLOT_BULLETS,oPC);
        DestroyObject(oItem1,0.0);
    }
    else if(nRangedType==BASE_ITEM_HEAVYCROSSBOW){
        object oItem1 = GetItemInSlot(INVENTORY_SLOT_BOLTS,oPC);
        DestroyObject(oItem1,0.0);
    }
    if(sRefVeste == "loot_spia"){
        DestroyObject(oItem,0.0);
        SetLocalInt(oPC,"spiacammuffamento",0);
    }
    // -------------------------------------------------------------------------
    //  Intelligent Weapon System
    // -------------------------------------------------------------------------
    if (IPGetIsIntelligentWeapon(oItem))
    {
            IWSetIntelligentWeaponEquipped(oPC,OBJECT_INVALID);
            IWPlayRandomUnequipComment(oPC,oItem);
    }

    // -------------------------------------------------------------------------
    // Mounted benefits control
    // -------------------------------------------------------------------------
    if (GetWeaponRanged(oItem))
    {
        DeleteLocalInt(oPC,"bX3_M_ARCHERY");
        HORSE_SupportAdjustMountedArcheryPenalty(oPC);
    }

    // -------------------------------------------------------------------------
    // Generic Item Script Execution Code
    // If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
    // it will execute a script that has the same name as the item's tag
    // inside this script you can manage scripts for all events by checking against
    // GetUserDefinedItemEventNumber(). See x2_it_example.nss
    // -------------------------------------------------------------------------
    if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
    {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_UNEQUIP);
        int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
           return;
        }
    }
}
