#include "lcs_shld_include"

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    int nNewLine = lcs_GetNextValidShieldModel(oItem);
    object oNewItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_WEAPON_COLOR, 0, 1);
    DestroyObject(oItem);
    lcs_ModifyandEquipNewShield(oNewItem, nNewLine);
}
