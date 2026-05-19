void _CopyProps(object oOld, object oNew)
{
    if (GetIsObjectValid(oOld) && GetIsObjectValid(oNew))
    {
        itemproperty ip = GetFirstItemProperty(oOld);
        while (GetIsItemPropertyValid(ip))
        {
            AddItemProperty(DURATION_TYPE_PERMANENT,ip,oNew);

            ip = GetNextItemProperty(oOld);
        }
    }
}

int lcs_GetNextValidShieldModel(object oItem)
{
    int nCurrentAppearance = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, 0);
    int nAppearance = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_COLOR, 0);

    int nBaseItemType = GetBaseItemType(oItem);
    if(nCurrentAppearance == 4 && nBaseItemType == BASE_ITEM_SMALLSHIELD)
        return 1;
    else if(nCurrentAppearance == 5 && nBaseItemType == BASE_ITEM_TOWERSHIELD)
        return 1;
    else if(nCurrentAppearance ==  7 &&nBaseItemType == BASE_ITEM_LARGESHIELD)
        return 1;
    else
        return nCurrentAppearance + 1;
}

int lcs_GetPreviousValidShieldModel(object oItem)
{
    int nCurrentAppearance = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, 0);
    int nAppearance = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_COLOR, 0);
    int nBaseItemType = GetBaseItemType(oItem);
    if(nCurrentAppearance == 1 && nBaseItemType == BASE_ITEM_SMALLSHIELD)
        return 4;
    else if(nCurrentAppearance == 1 && nBaseItemType == BASE_ITEM_TOWERSHIELD)
        return 5;
    else if(nCurrentAppearance ==  1 &&nBaseItemType == BASE_ITEM_LARGESHIELD)
        return 7;
    else
        return nCurrentAppearance - 1;
}

int lcs_GetNextValidShieldColor(object oItem)
{
    int nAppearance = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_COLOR, 0);
    int nCurrentAppearance = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, 0);
    int nBaseItemType = GetBaseItemType(oItem);
    if(nBaseItemType == BASE_ITEM_SMALLSHIELD){
        if(nAppearance == 3)
            nAppearance = 1;
        else
            nAppearance = nAppearance + 1;
    }
    else if(nBaseItemType == BASE_ITEM_TOWERSHIELD){
        if(nCurrentAppearance <= 4 && nAppearance == 3)
            nAppearance = 1;
        else if(nCurrentAppearance == 5 && nAppearance == 4)
            nAppearance = 1;
        else
            nAppearance = nAppearance + 1;
    }
    else if(nBaseItemType == BASE_ITEM_LARGESHIELD){
        if(nCurrentAppearance <= 4 && nAppearance == 3)
            nAppearance = 1;
        else if(nCurrentAppearance == 5 && nAppearance == 6)
            nAppearance = 1;
        else if(nCurrentAppearance ==6 && nAppearance == 9)
            nAppearance = 1;
        else if(nCurrentAppearance ==7 && nAppearance == 5)
            nAppearance = 0;
        else
            nAppearance = nAppearance + 1;
    }
    return nAppearance;
}

int lcs_GetPreviousValidShieldColor(object oItem)
{
    int nAppearance = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_COLOR, 0);
    int nCurrentAppearance = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, 0);
    int nBaseItemType = GetBaseItemType(oItem);
    if(nBaseItemType == BASE_ITEM_SMALLSHIELD){
        if(nAppearance == 1)
            nAppearance = 3;
        else
            nAppearance = nAppearance -1;
    }
    else if(nBaseItemType == BASE_ITEM_TOWERSHIELD){
        if(nCurrentAppearance <= 3 && nAppearance == 1)
            nAppearance = 3;
        else if(nCurrentAppearance == 5 && nAppearance == 1)
            nAppearance = 4;
        else
            nAppearance = nAppearance -1;
    }
    else if(nBaseItemType == BASE_ITEM_LARGESHIELD){
        if(nCurrentAppearance <= 4 && nAppearance == 1)
            nAppearance = 3;
        else if(nCurrentAppearance == 5 && nAppearance == 1)
            nAppearance = 6;
        else if(nCurrentAppearance == 6 && nAppearance == 1)
            nAppearance = 9;
        else if(nCurrentAppearance == 7 && nAppearance == 0)
            nAppearance = 5;
        else
            nAppearance = nAppearance -1;
    }
    return nAppearance;
}

void lcs_ModifyandEquipNewShield(object oItem, int nAppearance)
{
    object oPC = GetItemPossessor(oItem);
    object oNewItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, 0, nAppearance);
    DestroyObject(oItem);
    SetCommandable(TRUE, oPC);
    AssignCommand(oPC, ActionEquipItem(oNewItem, INVENTORY_SLOT_LEFTHAND));
}

void lcs_ModifyColorandEquipNewShield(object oItem, int nAppearance)
{
    object oPC = GetItemPossessor(oItem);
    object oNewItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_WEAPON_COLOR, 0, nAppearance);
    DestroyObject(oItem);
    SetCommandable(TRUE, oPC);
    AssignCommand(oPC, ActionEquipItem(oNewItem, INVENTORY_SLOT_LEFTHAND));
}

void SpecialShieldEdition(object oItem,int nAppearance,int nAppearance2)
{
    object oPC = GetItemPossessor(oItem);
    string oTag = "mod_bas_sh_"+IntToString(nAppearance2)+IntToString(nAppearance);
    string NameoItem = GetName(oItem);
    string oTagOld = GetTag(oItem);
    object NewItem = CreateItemOnObject(oTag,oPC,1,oTagOld);
    _CopyProps(oItem,NewItem);
    SetName(NewItem,NameoItem);
    SetIdentified(NewItem,GetIdentified(oItem));
    DestroyObject(oItem);
    AssignCommand(oPC,ClearAllActions(TRUE));
    DelayCommand(1.00,AssignCommand(oPC,ActionEquipItem(NewItem, INVENTORY_SLOT_LEFTHAND)));
}
