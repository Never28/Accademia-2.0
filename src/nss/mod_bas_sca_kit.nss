void main()
{
    object oPC = GetPCSpeaker();
    int nMO = GetGold(oPC);
    if(nMO <500){
        SendMessageToPC(oPC,"Non possiede abbastanza monete per comprare un Kit da Scambio");
    }
    else{
        TakeGoldFromCreature(500,oPC,TRUE);
        CreateItemOnObject("mod_bas_pg",oPC);
        CreateItemOnObject("mod_bas_item",oPC);
    }
}
