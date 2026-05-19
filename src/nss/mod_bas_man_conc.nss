int StartingConditional()
{
        object oPC=GetPCSpeaker();

        object ArmaturaPC=GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC);

        if(ArmaturaPC == OBJECT_INVALID)
            return FALSE;
        return TRUE;
}
