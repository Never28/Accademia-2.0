#include "lcs_armr_include"

void main()
{
    object oPC = GetPCSpeaker();
    object oItem2 = GetItemInSlot(INVENTORY_SLOT_BELT,oPC);
    if(oItem2==OBJECT_INVALID){
        object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
        int nNewLine = lcs_GetNextValidArmor2DALine(oItem, ITEM_APPR_ARMOR_MODEL_LFOREARM);
        lcs_ModifyTwiceandEquipNewArmor(oItem, ITEM_APPR_ARMOR_MODEL_LFOREARM, ITEM_APPR_ARMOR_MODEL_RFOREARM, nNewLine);
    }
    else{
        SendMessageToPC(oPC,"Per piacere non indossare la cintura durante la modifica della veste");
    }
}
