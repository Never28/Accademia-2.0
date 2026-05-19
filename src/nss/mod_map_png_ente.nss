void CreaMob(string sNomeMappa,int nRandom,int nRandom2,int nRandom3)
{
    // Teniamo il conto con un contatore
    int nContatore = 0;
    // Locazione della tappa.
    location lLocationTappa;
    // Nome della creatura
    string sCreature;
    string sNomeMappa1 = sNomeMappa;
    // La Creatura
    object oCreature;
    // Creiamo il nome della prima tappa -> es. Atla0
    string sFirstTappa = sNomeMappa + "ct" + IntToString(nContatore);
    // Vediamo se c'e' la tappa con quel nome.
    object oFirstTappa = GetObjectByTag(sFirstTappa);
    // Se esiste e finche' esistera' faremo il ciclo
    while(oFirstTappa != OBJECT_INVALID){
        // Prediamo la posizione della prima tappa
        lLocationTappa = GetLocation(oFirstTappa);
        if(sNomeMappa=="cit_bal_mur"||sNomeMappa=="cit_bal_gov"||sNomeMappa=="cit_bal_nob"||
        sNomeMappa=="cit_bal_pop"||sNomeMappa=="cit_bal_por")
            sNomeMappa1 = "cit_bal";
        // creiamo una stringa col nome della tappa + la lettera C e il numero random di possibilita
        sCreature = sNomeMappa1 + "c" + IntToString(Random(nRandom));
        // creiamo la nuova creatura nella locazione che prima abbiamo calcolato
        oCreature = CreateObject(OBJECT_TYPE_CREATURE,sCreature,lLocationTappa);
        // Salviamo la creatura creata nella tappa
        SetLocalObject(oFirstTappa,"tappapng",oCreature);
        //Incrementiamo il Contatore
        nContatore = nContatore + 1;
        // Nome seconda tappa -> es. Atla1
        sFirstTappa = sNomeMappa + "ct" + IntToString(nContatore);
        // Rivediamo se c'e'
        oFirstTappa = GetObjectByTag(sFirstTappa);
    }
    nContatore = 0;
    // Creiamo il nome della prima tappa -> es. Atla0
    sFirstTappa = sNomeMappa + "pt" + IntToString(nContatore);
    // Vediamo se c'e' la tappa con quel nome.
    oFirstTappa = GetObjectByTag(sFirstTappa);
    // Se esiste e finche' esistera' faremo il ciclo
    while(oFirstTappa != OBJECT_INVALID){
        // Prediamo la posizione della prima tappa
        lLocationTappa = GetLocation(oFirstTappa);
        if(sNomeMappa=="cit_bal_mur"||sNomeMappa=="cit_bal_gov"||sNomeMappa=="cit_bal_nob"||
        sNomeMappa=="cit_bal_pop"||sNomeMappa=="cit_bal_por")
            sNomeMappa1 = "cit_bal";
        // creiamo una stringa col nome della tappa + la lettera C e il numero random di possibilita
        sCreature = sNomeMappa1 + "p" + IntToString(Random(nRandom2));
        // creiamo la nuova creatura nella locazione che prima abbiamo calcolato
        oCreature = CreateObject(OBJECT_TYPE_CREATURE,sCreature,lLocationTappa);
        // Salviamo la creatura creata nella tappa
        SetLocalObject(oFirstTappa,"tappapng",oCreature);
        //Incrementiamo il Contatore
        nContatore = nContatore + 1;
        // Nome seconda tappa -> es. Atla1
        sFirstTappa = sNomeMappa + "pt" + IntToString(nContatore);
        // Rivediamo se c'e'
        oFirstTappa = GetObjectByTag(sFirstTappa);
    }
    nContatore = 0;
    // Creiamo il nome della prima tappa -> es. Atla0
    sFirstTappa = sNomeMappa + "at" + IntToString(nContatore);
    // Vediamo se c'e' la tappa con quel nome.
    oFirstTappa = GetObjectByTag(sFirstTappa);
    // Se esiste e finche' esistera' faremo il ciclo
    while(oFirstTappa != OBJECT_INVALID){
        // Prediamo la posizione della prima tappa
        lLocationTappa = GetLocation(oFirstTappa);
        if(sNomeMappa=="cit_bal_mur"||sNomeMappa=="cit_bal_gov"||sNomeMappa=="cit_bal_nob"||
        sNomeMappa=="cit_bal_pop"||sNomeMappa=="cit_bal_por")
            sNomeMappa1 = "cit_bal";
        // creiamo una stringa col nome della tappa + la lettera C e il numero random di possibilita
        sCreature = sNomeMappa1 + "a" + IntToString(Random(nRandom3));
        // creiamo la nuova creatura nella locazione che prima abbiamo calcolato
        oCreature = CreateObject(OBJECT_TYPE_CREATURE,sCreature,lLocationTappa);
        // Salviamo la creatura creata nella tappa
        SetLocalObject(oFirstTappa,"tappapng",oCreature);
        //Incrementiamo il Contatore
        nContatore = nContatore + 1;
        // Nome seconda tappa -> es. Atla1
        sFirstTappa = sNomeMappa + "at" + IntToString(nContatore);
        // Rivediamo se c'e'
        oFirstTappa = GetObjectByTag(sFirstTappa);
    }
}
void main()
{
    // la Mappa.
    object oArea = OBJECT_SELF;
    string sArea = GetTag(oArea);
    // Il giocatore che Entra.
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == TRUE && GetIsDM(oPC) == FALSE){
        SetLocalObject(oPC,"scriptpngexit",oArea);
        // Visualizziamo l'area
        ExploreAreaForPlayer(OBJECT_SELF,oPC,TRUE);
        // Vediamo i giocatori presenti prima della sua entrata e sommiamo il nuovo arrivato.
        int NumeroPC = GetLocalInt(oArea,"scriptpng");
        int NumeroPCNow = NumeroPC+1;
        // Mettiamo il valore al sicuro.
        SetLocalInt(oArea,"scriptpng",NumeroPCNow);
        // Ogni area fa partire lo script per utilizzero l'area come punto di riferimento se e' il primo player
        if(NumeroPCNow == 1){
            if (sArea=="cit_can")
                CreaMob(sArea,2,4,2);
            else if (sArea=="cit_ber")
                CreaMob(sArea,2,4,0);
            else if (sArea=="cit_nas")
                CreaMob(sArea,2,4,0);
            else if (sArea=="cit_loc_est")
                CreaMob(sArea,2,4,0);
            else if (sArea=="cit_bal_mur")
                CreaMob(sArea,4,4,2);
            else if (sArea=="cit_bal_gov")
                CreaMob(sArea,4,4,2);
            else if (sArea=="cit_bal_nob")
                CreaMob(sArea,4,4,2);
            else if (sArea=="cit_bal_pop")
                CreaMob(sArea,4,4,2);
            else if (sArea=="cit_bal_por")
                CreaMob(sArea,4,4,2);
        }
    }
}

