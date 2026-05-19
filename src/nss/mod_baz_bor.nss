void main()
{
    object oPC = GetPCSpeaker();
    int nMoney = GetGold(oPC);
    if(nMoney>=1000){
        CreateItemOnObject("mod_bor_cons",oPC);
        TakeGoldFromCreature(1000,oPC);
    }
    else
        SendMessageToPC(oPC,"Non hai abbastanza soldi, servono 1000 monete d'oro per una borsa conservante");
}
