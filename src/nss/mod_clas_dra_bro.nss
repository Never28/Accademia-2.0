void main()
{
    object oPC = GetPCSpeaker();
    if(GetGoodEvilValue(oPC)>=50){
        CreateItemOnObject("mod_clas_drbro",oPC);
        ExecuteScript("mod_clas_poly_ju",oPC);
    }
    else
        SendMessageToPC(oPC,"Non puoi diventare discepolo del drago di bronzo perche' sei di allineamento malvagio");
}
