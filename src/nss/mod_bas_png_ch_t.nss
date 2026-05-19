void MandaMex(object oCreature){
    string sArea=GetTag(GetArea(oCreature));
    string sMessage0;
    string sMessage1;
    string sMessage2;
    string sMessage3;
    string sMessage4;
    string sMessage5;
    string sMessage6;
    string sMessage7;
    string sMessage8;
    string sMessage9;
    int nRandom;
    if(sArea=="rim_citta_tavern"){
        nRandom = Random(3);
        sMessage2="Un brindisi alla salute!";
        sMessage3="Forse dovrei smetterla di bere cosi tanto";
        sMessage4="Quindici uomini sulla cassa del morto, Yo ho ho e una bottiglia di rum..";
    }
    switch(nRandom){
        case 0:
            SpeakString(sMessage0);
            break;
        case 1:
            SpeakString(sMessage1);
            break;
        case 2:
            SpeakString(sMessage2);
            break;
        case 3:
            SpeakString(sMessage3);
            break;
        case 4:
            SpeakString(sMessage4);
            break;
        case 5:
            SpeakString(sMessage5);
            break;
        case 6:
            SpeakString(sMessage6);
            break;
        case 7:
            SpeakString(sMessage7);
            break;
        case 8:
            SpeakString(sMessage8);
            break;
        case 9:
            SpeakString(sMessage9);
            break;
    }
}

void main()
{
    //Valore della variabile tempo Reale
    int nTempoVero = GetLocalInt(OBJECT_SELF, "tempovero");
    int nTempoRandom;

    //controllo che la variabile ntempo non sia a zero
    if (nTempoVero == 0){
        //Tempo Random
        nTempoRandom = 20 + Random(200);
        DelayCommand(RoundsToSeconds(nTempoRandom)-1,SetLocalInt(OBJECT_SELF,"tempovero",0));
        DelayCommand(RoundsToSeconds(nTempoRandom)-1,MandaMex(OBJECT_SELF));
    }
    //Incremento della variabile tempo Reale
    nTempoVero = nTempoVero + 1;

    //Salvataggio variabile tempo Reale
    SetLocalInt(OBJECT_SELF,"tempovero",nTempoVero);

    ActionRandomWalk();
}
