/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// La funzione quando esce un giocatore dal server.

#include "mod_bas_que_func"

void SafeDestroyObject(object oObject, float fDelay)
{
    SetIsDestroyable(TRUE);
    if(GetPlotFlag(oObject)) { DelayCommand(0.0,SetPlotFlag(oObject, FALSE)); }
    if(GetImmortal(oObject)) { DelayCommand(0.0,SetImmortal(oObject, FALSE)); }
    if(!GetDroppableFlag(oObject)) { DelayCommand(0.0,SetDroppableFlag(oObject, TRUE)); }
    DestroyObject(oObject, fDelay);
}

void RimuoviTrap(object oArea)
{
    object oTarget = GetFirstObjectInArea(oArea);
    while(oTarget!=OBJECT_INVALID){
        if(GetObjectType(oTarget)==OBJECT_TYPE_AREA_OF_EFFECT||(GetObjectType(oTarget)==OBJECT_TYPE_PLACEABLE&&GetLocalInt(oTarget,"not_trap")==0))
            SafeDestroyObject(oTarget,0.0);
        oTarget =GetNextObjectInArea(oArea);
    }

}

void RimuoviMob(string sNomeMappa)
{
    // Teniamo il conto con un contatore
    int nContatore = 0;
    // Creiamo il nome della prima tappa -> es. Atlat0
    string sFirstTappa = sNomeMappa + "ct" + IntToString(nContatore);
    // la Creatura proprio
    object oCreature;
    // Vediamo se c' la tappa con quel nome.
    object oFirstTappa = GetObjectByTag(sFirstTappa);
    // Se esiste e finche' esistera' faremo il ciclo
    while(oFirstTappa != OBJECT_INVALID){
        // Prendiamo la creatura nella tappa
        oCreature = GetLocalObject(oFirstTappa,"tappapng");
        // Cancelliamo la creatura
        SafeDestroyObject(oCreature,0.0);
        // Cancelliamo il nome dalla tappa
        DeleteLocalObject(oFirstTappa,"tappapng");
        //Incrementiamo il Contatore
        nContatore = nContatore + 1;
        // Nome seconda tappa -> es. Atlat1
        sFirstTappa = sNomeMappa + "ct" + IntToString(nContatore);
        // Rivediamo se c'e'
        oFirstTappa = GetObjectByTag(sFirstTappa);
    }
    nContatore = 0;
    // Creiamo il nome della prima tappa -> es. Atlat0
    sFirstTappa = sNomeMappa + "pt" + IntToString(nContatore);
    // Vediamo se c' la tappa con quel nome.
    oFirstTappa = GetObjectByTag(sFirstTappa);
    // Se esiste e finche' esistera' faremo il ciclo
    while(oFirstTappa != OBJECT_INVALID){
        // Prendiamo la creatura nella tappa
        oCreature = GetLocalObject(oFirstTappa,"tappapng");
        // Cancelliamo la creatura
        SafeDestroyObject(oCreature,0.0);
        // Cancelliamo il nome dalla tappa
        DeleteLocalObject(oFirstTappa,"tappapng");
        //Incrementiamo il Contatore
        nContatore = nContatore + 1;
        // Nome seconda tappa -> es. Atlat1
        sFirstTappa = sNomeMappa + "pt" + IntToString(nContatore);
        // Rivediamo se c'e'
        oFirstTappa = GetObjectByTag(sFirstTappa);
    }
    nContatore = 0;
    // Creiamo il nome della prima tappa -> es. Atlat0
    sFirstTappa = sNomeMappa + "at" + IntToString(nContatore);
    // Vediamo se c' la tappa con quel nome.
    oFirstTappa = GetObjectByTag(sFirstTappa);
    // Se esiste e finche' esistera' faremo il ciclo
    while(oFirstTappa != OBJECT_INVALID){
        // Prendiamo la creatura nella tappa
        oCreature = GetLocalObject(oFirstTappa,"tappapng");
        // Cancelliamo la creatura
        SafeDestroyObject(oCreature,0.0);
        // Cancelliamo il nome dalla tappa
        DeleteLocalObject(oFirstTappa,"tappapng");
        //Incrementiamo il Contatore
        nContatore = nContatore + 1;
        // Nome seconda tappa -> es. Atlat1
        sFirstTappa = sNomeMappa + "at" + IntToString(nContatore);
        // Rivediamo se c'e'
        oFirstTappa = GetObjectByTag(sFirstTappa);
    }
}

void main()
{
    // Il giocatore che sta uscendo.
    object oPC = GetExitingObject();
    object oPCAgg = GetFirstPC();
    int nCont = 0;
    while(oPCAgg!=OBJECT_INVALID){
        nCont = 1;
        oPCAgg = GetNextPC();
    }
    if(nCont == 0){
        object oModule = GetModule();
        int nGildaBuoni1 = GetLocalInt(oModule,"gb1");
        int nGildaBuoni2 = GetLocalInt(oModule,"gb2");
        int nGildaBuoni3 = GetLocalInt(oModule,"gb3");
        int nGildaBuoni4 = GetLocalInt(oModule,"gb4");
        int nGildaBuoni5 = GetLocalInt(oModule,"gb5");
        int nGildaBuoni6 = GetLocalInt(oModule,"gb6");
        int nGildaBuoni7 = GetLocalInt(oModule,"gb7");
        int nGildaBuoni8 = GetLocalInt(oModule,"gb8");
        int nGildaBuoni9 = GetLocalInt(oModule,"gb9");
        int nGildaCattivi1 = GetLocalInt(oModule,"gm1");
        int nGildaCattivi2 = GetLocalInt(oModule,"gm2");
        int nGildaCattivi3 = GetLocalInt(oModule,"gm3");
        int nGildaCattivi4 = GetLocalInt(oModule,"gm4");
        int nGildaCattivi5 = GetLocalInt(oModule,"gm5");
        int nGildaCattivi6 = GetLocalInt(oModule,"gm6");
        int nGildaCattivi7 = GetLocalInt(oModule,"gm7");
        int nGildaCattivi8 = GetLocalInt(oModule,"gm8");
        int nGildaCattivi9 = GetLocalInt(oModule,"gm9");
        SetCampaignInt("accademia_gilde","gb1",nGildaBuoni1);
        SetCampaignInt("accademia_gilde","gb2",nGildaBuoni2);
        SetCampaignInt("accademia_gilde","gb3",nGildaBuoni3);
        SetCampaignInt("accademia_gilde","gb4",nGildaBuoni4);
        SetCampaignInt("accademia_gilde","gb5",nGildaBuoni5);
        SetCampaignInt("accademia_gilde","gb6",nGildaBuoni6);
        SetCampaignInt("accademia_gilde","gb7",nGildaBuoni7);
        SetCampaignInt("accademia_gilde","gb8",nGildaBuoni8);
        SetCampaignInt("accademia_gilde","gb9",nGildaBuoni9);
        SetCampaignInt("accademia_gilde","gm1",nGildaCattivi1);
        SetCampaignInt("accademia_gilde","gm2",nGildaCattivi2);
        SetCampaignInt("accademia_gilde","gm3",nGildaCattivi3);
        SetCampaignInt("accademia_gilde","gm4",nGildaCattivi4);
        SetCampaignInt("accademia_gilde","gm5",nGildaCattivi5);
        SetCampaignInt("accademia_gilde","gm6",nGildaCattivi6);
        SetCampaignInt("accademia_gilde","gm7",nGildaCattivi7);
        SetCampaignInt("accademia_gilde","gm8",nGildaCattivi8);
        SetCampaignInt("accademia_gilde","gm9",nGildaCattivi9);
    }
    // Area di chi sta uscendo
    object oArea = GetLocalObject(oPC,"scriptpngexit");
    // Controlliamo sia un giocatore o un DM
    if(oArea != OBJECT_INVALID){
        // Vediamo i giocatori presenti prima della sua uscita e sottraiamo l'uscita.
        int NumeroPC = GetLocalInt(oArea,"scriptpng");
        int NumeroPCNow = NumeroPC-1;
        // Sottraiamo quello che esce.
        SetLocalInt(oArea,"scriptpng",NumeroPCNow);
        // Se il numero e' pari a zero facciamo partire lo script che cancella tutto quello che era stato creato nell'area
        if(NumeroPCNow == 0){
            string sArea = GetTag(oArea);
            RimuoviMob(sArea);
            DeleteLocalObject(oPC,"scriptpngexit");
        }
    }
    oArea = GetLocalObject(oPC,"script_rodon_exit");
    if(oArea != OBJECT_INVALID){
        // Vediamo i giocatori presenti prima della sua uscita e sottraiamo l'uscita.
        int NumeroPC = GetLocalInt(oArea,"script_rodon");
        int NumeroPCNow = NumeroPC-1;
        // Sottraiamo quello che esce.
        SetLocalInt(oArea,"script_rodon",NumeroPCNow);
        // Se il numero e' pari a zero facciamo partire lo script che cancella tutto quello che era stato creato nell'area
        if(NumeroPCNow == 0){
            RimuoviTrap(oArea);
            DeleteLocalObject(oPC,"script_rodon_exit");
        }
    }
    // I Danni attuali che il giocatore ha.
    int DanniAttuali = GetMaxHitPoints(oPC)-GetCurrentHitPoints(oPC);
    // Il nome del giocatore.
    string Nome = GetName(oPC);
    // I punti esperienza del giocatore.
    string XP = IntToString(GetXP(oPC));
    // Chiamiamo una variabile come la fusione tra Nome e i suoi Punti Esperienza.
    string danni = Nome+XP;
    // Se i danni del giocatore sono maggiori di 0 allora settiamo una variabile per tenerne traccia.
    if(DanniAttuali!=0)
        SetLocalInt(GetModule(),danni,DanniAttuali);
}
