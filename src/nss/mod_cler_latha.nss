/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// Funzione per dare la statuetta di Lathander.

void main()
{
    object oPC = GetPCSpeaker();
    int nCleric = GetLevelByClass(CLASS_TYPE_CLERIC,oPC);
    if(GetGoodEvilValue(oPC)>=50 && nCleric >= 10){
        CreateItemOnObject("mod_deity_latha",oPC);
    }
    else
        SendMessageToPC(oPC,"Non puoi Chierico di Lathander perche' sei di allineamento malvagio o sei di livello troppo basso");
}

