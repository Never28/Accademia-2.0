#include "lcs_clo_include"

void main()
{
    object oPC = GetPCSpeaker();
    object oItem2 = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
    if(oItem2==OBJECT_INVALID){
    object oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);
    int nNewLine = lcs_GetNextValidCloakModel(oItem);
    object oNewItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, 1);
    DestroyObject(oItem);
    lcs_ModifyandEquipNewCloak(oNewItem, nNewLine);
    }
    else{
        SendMessageToPC(oPC,"Per piacere non indossare i bracciali durante la modifica del mantello");
    }
}
