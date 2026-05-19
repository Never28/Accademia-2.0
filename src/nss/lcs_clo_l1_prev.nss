#include "lcs_clo_include"

void main()
{
    object oPC = GetPCSpeaker();
    object oItem2 = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
    if(oItem2==OBJECT_INVALID){
    object oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);
    int nNewLine = lcs_GetPreviousValidCloakColor(oItem, ITEM_APPR_ARMOR_COLOR_LEATHER1);

    lcs_ModifyColorandEquipNewCloak(oItem, ITEM_APPR_ARMOR_COLOR_LEATHER1, nNewLine);
     }
    else{
        SendMessageToPC(oPC,"Per piacere non indossare i bracciali durante la modifica del mantello");
    }
}
