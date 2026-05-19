void main()
{
    object oPC = GetPCSpeaker();
    if(GetGoodEvilValue(oPC)>=50){
        CreateItemOnObject("mod_clas_droro",oPC);
        ExecuteScript("mod_clas_poly_ju",oPC);
    }
    else
        SendMessageToPC(oPC,"Non puoi diventare discepolo del drago d'oro perche' sei di allineamento malvagio");
}
