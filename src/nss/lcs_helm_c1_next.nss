#include "lcs_helm_include"

void main()
{
    object oPC = GetPCSpeaker();
    object oItem2 = GetItemInSlot(INVENTORY_SLOT_BELT,oPC);
    if(oItem2==OBJECT_INVALID){
    object oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
    int nNewLine = lcs_GetNextValidHelmColor(oItem, ITEM_APPR_ARMOR_COLOR_CLOTH1);

    lcs_ModifyColorandEquipNewHelm(oItem, ITEM_APPR_ARMOR_COLOR_CLOTH1, nNewLine);
    }
    else{
        SendMessageToPC(oPC,"Per piacere non indossare la cintura durante la modifica della veste");
    }
}
