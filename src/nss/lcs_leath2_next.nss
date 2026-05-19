#include "lcs_armr_include"

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    object oItem2 = GetItemInSlot(INVENTORY_SLOT_BELT,oPC);
    if(oItem2==OBJECT_INVALID){
    int nNewLine = lcs_GetNextValidColor(oItem, ITEM_APPR_ARMOR_COLOR_LEATHER2);

    lcs_ModifyColorandEquipNewArmor(oItem, ITEM_APPR_ARMOR_COLOR_LEATHER2, nNewLine);
    }
    else{
        SendMessageToPC(oPC,"Per piacere non indossare la cintura durante la modifica della veste");
    }
}
