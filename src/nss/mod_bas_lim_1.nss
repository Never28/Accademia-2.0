#include "mod_bas_que_func"

void main()
{
    object oPC = GetClickingObject();
    object oGuard = GetObjectByTag("png_tra_gua_1");
    int nQuest = LetturaQuest(38,oPC);
    if(nQuest<=2&&GetIsDM(oPC)==FALSE)
        AssignCommand(oGuard,ActionSpeakString("Mi spiace "+GetName(oPC)+" ma non sei ancora pronto per affrontare cio' che permea la foresta di Candlekeep. Parla con me quando avrai dato prova della tua forza aiutando chi ha bisogno in citta', cosi' che possa donarti un lasciapassare"));
    else{
        object oTap2 = GetWaypointByTag("WP_IngressoestdiCandlekeep");
        AssignCommand(oPC,ActionJumpToObject(oTap2));
    }
}
