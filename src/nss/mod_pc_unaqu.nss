/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// La funzione quando viene venduto un'item.

#include "x2_inc_switches"

void main()
{
     object oItem = GetModuleItemLost();
     int nBaseItem = GetBaseItemType(oItem);
     string sObj1 = GetResRef(oItem);
     string sLeftObj1 = GetStringLeft(sObj1,5);
     string sLeftObj2 = GetStringLeft(sObj1,3);
     string sLeftObj3 = GetStringLeft(sObj1,7);
     string sLeftObj4 = GetStringLeft(sObj1,8);
     if(sLeftObj1=="craft"||sLeftObj4=="weap_bas"||sLeftObj2=="set"||sLeftObj3=="crystal"||sLeftObj3=="weap_bas"||nBaseItem==BASE_ITEM_LARGEBOX){
        object oPC = GetModuleItemLostBy();
        object oArea = GetArea(oPC);
        object oItem2 = GetFirstObjectInArea(oArea);
        while(oItem2!=OBJECT_INVALID){
            if(oItem2==oItem){
                CopyItem(oItem,oPC,TRUE);
                DestroyObject(oItem,0.0);
            }
            oItem2 = GetNextObjectInArea(oArea);
        }
     }
     // * Generic Item Script Execution Code
     // * If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
     // * it will execute a script that has the same name as the item's tag
     // * inside this script you can manage scripts for all events by checking against
     // * GetUserDefinedItemEventNumber(). See x2_it_example.nss
     if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
     {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_UNACQUIRE);
        int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
           return;
        }

     }

}
