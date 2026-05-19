void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"mod_bas_tele");
    DestroyObject(oItem,0.0);
    CreateItemOnObject("mod_bas_tele_t",oPC);
}
