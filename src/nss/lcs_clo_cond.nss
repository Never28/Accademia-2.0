int StartingConditional()
{
    int iResult;

    object oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK);


    iResult = GetIsObjectValid(oItem);
    return iResult;
}
