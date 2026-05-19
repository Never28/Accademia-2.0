#include "lcs_shld_include"

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    int nNewLine = lcs_GetNextValidShieldColor(oItem);
    int nBaseItemType = GetBaseItemType(oItem);
    int nCurrentAppearance = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, 0);
    if(nBaseItemType == BASE_ITEM_LARGESHIELD){
        if(nCurrentAppearance <= 4)
            lcs_ModifyColorandEquipNewShield(oItem, nNewLine);
        else if(nCurrentAppearance == 5 && nNewLine >4)
            SpecialShieldEdition(oItem,nNewLine,nCurrentAppearance);
        else if(nCurrentAppearance == 6 && nNewLine >4)
            SpecialShieldEdition(oItem,nNewLine,nCurrentAppearance);
        else if(nCurrentAppearance == 7 && (nNewLine == 0||nNewLine>4))
            SpecialShieldEdition(oItem,nNewLine,nCurrentAppearance);
        else
            lcs_ModifyColorandEquipNewShield(oItem, nNewLine);
    }
    else
        lcs_ModifyColorandEquipNewShield(oItem, nNewLine);
}
