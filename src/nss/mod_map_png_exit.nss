void SafeDestroyObject(object oObject, float fDelay)
{
    SetIsDestroyable(TRUE);
    if(GetPlotFlag(oObject)) { DelayCommand(0.0,SetPlotFlag(oObject, FALSE)); }
    if(GetImmortal(oObject)) { DelayCommand(0.0,SetImmortal(oObject, FALSE)); }
    if(!GetDroppableFlag(oObject)) { DelayCommand(0.0,SetDroppableFlag(oObject, TRUE)); }
    DestroyObject(oObject, fDelay);
}

void RimuoviMob(string sNomeMappa)
{
    // Teniamo il conto con un contatore
    int nContatore = 0;
    // la Creatura proprio
    object oCreature;
    // Creiamo il nome della prima tappa -> es. Atlat0
    string sFirstTappa = sNomeMappa + "at" + IntToString(nContatore);
    // Vediamo se c' la tappa con quel nome.
    object oFirstTappa = GetObjectByTag(sFirstTappa);
    // Se esiste e finche' esistera' faremo il ciclo
    while(oFirstTappa != OBJECT_INVALID){
        // Prendiamo la creatura nella tappa
        oCreature = GetLocalObject(oFirstTappa,"tappapng");
        DeleteLocalInt(oCreature, "tempovero");
        // Cancelliamo la creatura
        SafeDestroyObject(oCreature,0.0);
        // Cancelliamo il nome dalla tappa
        DeleteLocalString(oFirstTappa,"tappapng");
        //Incrementiamo il Contatore
        nContatore = nContatore + 1;
        // Nome seconda tappa -> es. Atlat1
        sFirstTappa = sNomeMappa + "at" + IntToString(nContatore);
        // Rivediamo se c'e'
        oFirstTappa = GetObjectByTag(sFirstTappa);
    }
    nContatore = 0;
    // Creiamo il nome della prima tappa -> es. Atlat0
    sFirstTappa = sNomeMappa + "ct" + IntToString(nContatore);
    // Vediamo se c' la tappa con quel nome.
    oFirstTappa = GetObjectByTag(sFirstTappa);
    // Se esiste e finche' esistera' faremo il ciclo
    while(oFirstTappa != OBJECT_INVALID){
        // Prendiamo la creatura nella tappa
        oCreature = GetLocalObject(oFirstTappa,"tappapng");
        DeleteLocalInt(oCreature, "tempovero");
        // Cancelliamo la creatura
        SafeDestroyObject(oCreature,0.0);
        // Cancelliamo il nome dalla tappa
        DeleteLocalString(oFirstTappa,"tappapng");
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
        DeleteLocalInt(oCreature, "tempovero");
        // Cancelliamo la creatura
        SafeDestroyObject(oCreature,0.0);
        // Cancelliamo il nome dalla tappa
        DeleteLocalString(oFirstTappa,"tappapng");
        //Incrementiamo il Contatore
        nContatore = nContatore + 1;
        // Nome seconda tappa -> es. Atlat1
        sFirstTappa = sNomeMappa + "pt" + IntToString(nContatore);
        // Rivediamo se c'e'
        oFirstTappa = GetObjectByTag(sFirstTappa);
    }
}

void main()
{
    // la Mappa.
    object oArea = OBJECT_SELF;
    // Il giocatore che Esce.
    object oPC = GetExitingObject();
    if(GetIsPC(oPC) == TRUE && GetIsDM(oPC) == FALSE){
        DeleteLocalObject(oPC,"scriptpngexit");
        // Vediamo i giocatori presenti prima della sua uscita e sottraiamo l'uscita.
        int NumeroPC = GetLocalInt(oArea,"scriptpng");
        int NumeroPCNow = NumeroPC-1;
        // Sottraiamo quello che esce.
        SetLocalInt(oArea,"scriptpng",NumeroPCNow);
        // Se il numero e' pari a zero facciamo partire lo script che cancella tutto quello che era stato creato nell'area
        if(NumeroPCNow == 0){
            string sArea = GetTag(oArea);
            RimuoviMob(sArea);
        }
    }
}
