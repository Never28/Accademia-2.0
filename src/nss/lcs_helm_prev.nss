#include "lcs_helm_include"

void main()
{
    object oPC = GetPCSpeaker();
    object oItem2 = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC);
    if(oItem2==OBJECT_INVALID){
    object oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
    int nNewLine = lcs_GetPreviousValidHelmModel(oItem);

    lcs_ModifyandEquipNewHelm(oItem, nNewLine);
    }
    else{
        SendMessageToPC(oPC,"Per piacere non indossare l'anello destro (se non sapete qual'e' cavateli entrambi) durante la modifica dell'elmo");
    }
}
