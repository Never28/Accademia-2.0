/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// La funzione quando un giocatore acquisisce un oggetto.

#include "x2_inc_switches"
#include "x3_inc_string"

void main()
{
    // Get item aquired
    object oItem = GetModuleItemAcquired();
    object oItem2;
    object oPC = GetModuleItemAcquiredBy();
    object oLostBy = GetModuleItemAcquiredFrom();
    object oPC2 = GetItemPossessor(oItem);
    string sObj1 = GetResRef(oItem);
    string sLeftObj1;
    string sLeftObj2;
    string sLeftObj3;
    string sLeftObj4;
        int nTotal = 0;
        if(GetTag(oItem)=="poz_bas_cure1"){
            object oItem2 = GetFirstItemInInventory(oPC);
            while(oItem2 != OBJECT_INVALID){
                if(GetTag(oItem2)=="poz_bas_cure1"&&oItem2!=oItem){
                    nTotal = nTotal + GetItemStackSize(oItem2);
                    DestroyObject(oItem2,0.0);
                }
                oItem2 = GetNextItemInInventory(oPC);
            }
            nTotal = nTotal + GetItemStackSize(oItem);
            if(nTotal > 10)
                nTotal = 10;
            SetItemStackSize(oItem,nTotal);
        }
        if(GetTag(oItem)=="poz_bas_ress1"){
            object oItem2 = GetFirstItemInInventory(oPC);
            while(oItem2 != OBJECT_INVALID){
                if(GetTag(oItem2)=="poz_bas_ress1"&&oItem2!=oItem)
                    DestroyObject(oItem2,0.0);
                oItem2 = GetNextItemInInventory(oPC);
            }
        }
        if(GetTag(oItem)=="poz_bas_rest1"){
            object oItem2 = GetFirstItemInInventory(oPC);
            while(oItem2 != OBJECT_INVALID){
                if(GetTag(oItem2)=="poz_bas_rest1"&&oItem2!=oItem){
                    DestroyObject(oItem2,0.0);
                    nTotal = nTotal + GetItemStackSize(oItem2);
                }
                oItem2 = GetNextItemInInventory(oPC);
            }
            nTotal = nTotal + GetItemStackSize(oItem);
            if(nTotal > 10)
                nTotal = 10;
            SetItemStackSize(oItem,nTotal);
        }
        if(GetTag(oItem)=="poz_birra"){
            object oItem2 = GetFirstItemInInventory(oPC);
            while(oItem2 != OBJECT_INVALID){
                if(GetTag(oItem2)=="poz_birra"&&oItem2!=oItem){
                    nTotal = nTotal + GetItemStackSize(oItem2);
                    DestroyObject(oItem2,0.0);
                }
                oItem2 = GetNextItemInInventory(oPC);
            }
            nTotal = nTotal + GetItemStackSize(oItem);
            if(nTotal > 10)
                nTotal = 10;
            SetItemStackSize(oItem,nTotal);
        }
        if(GetTag(oItem)=="poz_vino"){
            object oItem2 = GetFirstItemInInventory(oPC);
            while(oItem2 != OBJECT_INVALID){
                if(GetTag(oItem2)=="poz_vino"&&oItem2!=oItem){
                    nTotal = nTotal + GetItemStackSize(oItem2);
                    DestroyObject(oItem2,0.0);
                }
                oItem2 = GetNextItemInInventory(oPC);
            }
            nTotal = nTotal + GetItemStackSize(oItem);
            if(nTotal > 10)
                nTotal = 10;
            SetItemStackSize(oItem,nTotal);
        }


    if(oLostBy != OBJECT_INVALID){
        int nBaseItem = GetBaseItemType(oItem);
        sLeftObj1 = GetStringLeft(sObj1,5);
        sLeftObj2 = GetStringLeft(sObj1,3);
        sLeftObj3 = GetStringLeft(sObj1,7);
        if(sLeftObj1=="craft"||sLeftObj2=="set"||sLeftObj3=="crystal"||sLeftObj4=="weap_bas"||nBaseItem==BASE_ITEM_LARGEBOX||GetItemCursedFlag(oItem)==TRUE){
            {
                CopyItem(oItem,oPC,TRUE);
                DestroyObject(oItem,0.0);

            }

        }
    }
    else{
        sLeftObj1 = GetStringLeft(sObj1,6);
        string sName = GetName(oItem);
        if(sLeftObj1=="set_01"||sLeftObj1=="set_08"||sLeftObj1=="set_19"||sLeftObj1=="set_30"
        ||sLeftObj1=="set_34"||sLeftObj1=="set_49"||sLeftObj1=="set_61"||sLeftObj1=="set_73"){
            SetName(oItem,StringToRGBString(sName,STRING_COLOR_GREY));
        }
        else if(sLeftObj1=="set_05"||sLeftObj1=="set_06"||sLeftObj1=="set_07"||sLeftObj1=="set_15"||
        sLeftObj1=="set_14"||sLeftObj1=="set_29"||sLeftObj1=="set_39"||sLeftObj1=="set_41"
        ||sLeftObj1=="set_50"){
            SetName(oItem,StringToRGBString(sName,STRING_COLOR_GREEN));
        }
        else if(sLeftObj1=="set_02"||sLeftObj1=="set_03"||sLeftObj1=="set_04"||sLeftObj1=="set_27"||sLeftObj1=="set_33"){
            SetName(oItem,StringToRGBString(sName,STRING_COLOR_BLUE));
        }
        else if(sLeftObj1=="set_09"||sLeftObj1=="set_10"||sLeftObj1=="set_17"||sLeftObj1=="set_13"||sLeftObj1=="set_31"||sLeftObj1=="set_36"){
            SetName(oItem,StringToRGBString(sName,STRING_COLOR_RED));
        }
        else if(sLeftObj1=="set_11"||sLeftObj1=="set_12"||sLeftObj1=="set_18"||sLeftObj1=="set_32"){
            SetName(oItem,StringToRGBString(sName,STRING_COLOR_PURPLE));
        }
        else if(sLeftObj1=="set_23"||sLeftObj1=="set_24"||sLeftObj1=="set_22"||
        sLeftObj1=="set_25"||sLeftObj1=="set_35"||sLeftObj1=="set_37"||sLeftObj1=="set_38"
        ||sLeftObj1=="set_51"){
            SetName(oItem,StringToRGBString(sName,STRING_COLOR_BROWN));
        }
        else if(sLeftObj1=="set_20"||sLeftObj1=="set_16"||sLeftObj1=="set_26"||sLeftObj1=="set_28"
        ||sLeftObj1=="set_76"||sLeftObj1=="set_46"){
            SetName(oItem,StringToRGBString(sName,STRING_COLOR_LIGHTBLUE));
        }
        else if(sLeftObj1=="set_40"){
            SetName(oItem,StringToRGBString(sName,STRING_COLOR_PINK));
        }
        else if(sLeftObj1=="set_42"||sLeftObj1=="set_44"){
            SetName(oItem,StringToRGBString(sName,STRING_COLOR_PINK));
        }
        else if(sLeftObj1=="set_43"||sLeftObj1=="set_45"){
            SetName(oItem,StringToRGBString(sName,STRING_COLOR_PINK));
        }
    }
    // If oLostBy is invalid, we must have logged in - we are not
    // taking this from anyone
    if(!GetIsObjectValid(oLostBy) || oLostBy == oPC2)
    {
        // Is it a relog in or not?
        // It will be if oPC is invalid
        if(!GetIsObjectValid(oPC)){
            // It is a relog, we can use oPC2 as the person who
            // reloged in with this item to send the message to.
        }
        else{
            // Not a relog, a normal login, we can use oPC to send
            // a message to.
            // * Note: oPC2 is always valid to use
        }
    }
        if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE){
            SetUserDefinedItemEventNumber(X2_ITEM_EVENT_ACQUIRE);
            int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
            if (nRet == X2_EXECUTE_SCRIPT_END)
                return;
        }
}
