/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// Funzione per dare la statuetta druidica.

void main()
{
    object oPC = GetPCSpeaker();
    if(GetGoodEvilValue(oPC)<=50){
        CreateItemOnObject("mod_deity_mephi",oPC);
        ExecuteScript("mod_clas_poly_ju",oPC);
    }
    else
        SendMessageToPC(oPC,"Non puoi diventare druido di Talona perche' sei di allineamento buono");
}

