void main()
{
    object oPC = GetPCSpeaker();
    if(GetGoodEvilValue(oPC)>=50){
        CreateItemOnObject("mod_clas_drram",oPC);
        ExecuteScript("mod_clas_poly_ju",oPC);
    }
    else
        SendMessageToPC(oPC,"Non puoi diventare discepolo del drago rame perche' sei di allineamento malbagio");
}
