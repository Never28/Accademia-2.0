#include "lcs_trch_include"

void main()
{
    object oPC = GetPCSpeaker();
    object oItem2 = GetItemInSlot(INVENTORY_SLOT_BELT,oPC);
    if(oItem2==OBJECT_INVALID){
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    int nNewLine = lcs_GetNextValidTorchModel(oItem);

    lcs_ModifyandEquipNewTorch(oItem, nNewLine);
    }
    else{
        SendMessageToPC(oPC,"Per piacere non indossare la cintura durante la modifica della veste");
    }
}
