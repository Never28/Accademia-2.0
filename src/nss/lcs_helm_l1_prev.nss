#include "lcs_helm_include"

void main()
{
    object oPC = GetPCSpeaker();
    object oItem2 = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC);
    if(oItem2==OBJECT_INVALID){
    object oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
    int nNewLine = lcs_GetPreviousValidHelmColor(oItem, ITEM_APPR_ARMOR_COLOR_LEATHER1);

    lcs_ModifyColorandEquipNewHelm(oItem, ITEM_APPR_ARMOR_COLOR_LEATHER1, nNewLine);
    }
    else{
        SendMessageToPC(oPC,"Per piacere non indossare l'anello destro (se non sapete qual'e' cavateli entrambi) durante la modifica dell'elmo");
    }
}
