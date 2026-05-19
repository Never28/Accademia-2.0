int lcs_GetNextValidCloakModel(object oItem)
{
    int nCurrentAppearance = GetItemAppearance(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0);
    if(nCurrentAppearance == 16)
    {
        return 0;
    }
    else
    {
        return nCurrentAppearance + 1;
    }
    return 1;
}

int lcs_GetPreviousValidCloakModel(object oItem)
{
    int nCurrentAppearance = GetItemAppearance(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0);
    if(nCurrentAppearance == 0)
    {
        return 16;
    }
    else
    {
        return nCurrentAppearance - 1;
    }
}

int lcs_GetNextValidCloakColor(object oItem, int nPart)
{
    int nAppearance = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, nPart);
    if(nAppearance == 175)
    {
        nAppearance = 0;
    }
    else
    {
        nAppearance = nAppearance + 1;
    }
    return nAppearance;
}

int lcs_GetPreviousValidCloakColor(object oItem, int nPart)
{
    int nAppearance = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, nPart);
    if(nAppearance == 0)
    {
        nAppearance = 175;
    }
    else
    {
        nAppearance = nAppearance - 1;
    }
    return nAppearance;
}

void lcs_ModifyandEquipNewCloak(object oItem, int nAppearance)
{
    object oPC = GetItemPossessor(oItem);
    object oNewItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nAppearance);
    DestroyObject(oItem);
    SetCommandable(TRUE, oPC);
    AssignCommand(oPC, ActionEquipItem(oNewItem, INVENTORY_SLOT_CLOAK));
}

void lcs_ModifyColorandEquipNewCloak(object oItem, int nPart, int nAppearance)
{
    object oPC = GetItemPossessor(oItem);
    object oNewItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, nPart, nAppearance);
    DestroyObject(oItem);
    SetCommandable(TRUE, oPC);
    AssignCommand(oPC, ActionEquipItem(oNewItem, INVENTORY_SLOT_CLOAK));
}
