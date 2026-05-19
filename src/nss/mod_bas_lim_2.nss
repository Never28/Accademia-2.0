#include "mod_bas_que_func"

void main()
{
    object oPC = GetClickingObject();
    object oGuard = GetObjectByTag("png_tra_gua_2");
    int nQuest = LetturaQuest(38,oPC);
    if(nQuest<=3&&GetIsDM(oPC)==FALSE)
        AssignCommand(oGuard,ActionSpeakString("Mi spiace "+GetName(oPC)+", ma agli studenti dell'accademia non è consentito uscire dalla foresta di Candlekeep. Ti servirà un lasciapassare come quello che ti è stato dato per uscire dalla biblioteca, per inoltrarti lungo la strada del leone. Torna da me quando riterrai di esserne all'altezza."));
    else{
        object oTap2 = GetWaypointByTag("WP_Versoforcannordest");
        AssignCommand(oPC,ActionJumpToObject(oTap2));
    }
}
