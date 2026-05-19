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
    string sMessage10;
    int nRandom;
    if (sArea=="cit_can"){
        nRandom = Random(11);
        sMessage0="Ho sentito dire che Mard, alla locanda, cerca persone per indagare sulle mutilazioni di bestiame";
        sMessage1="Pare che Dian abbia grossi problemi coi topi in casa sua";
        sMessage2="Ho sentito dire che Elros, all'uscita dela Libreria, arruola soldati per sconfiggere Uruk";
        sMessage3="Pare che Thell, il pittore, stia cercando alla Libreria dei volontari per recuperare i quadri rubati dai Lizard";
        sMessage4="Pereppi non si arrende e vuole proprio riavere il suo bastone, magari trova qualcuno pronto ad aiutarlo";
        sMessage5="Un sacerdote, vicino al nostro cimitero cerca missionari per benedire la zona";
        sMessage6="Kromar arruola persone per sconfiggere le trib di Kiki-Jiki e Sek'Kuar";
        sMessage7="Un contadino in locanda sta cercando volontari per liberarsi di Skarnik e dei suoi goblin che razziano i raccolti";
        sMessage8="La povera Sabel in locanda vuole arruolare mercenari per vendicarsi del fratello ucciso da Aztarok, lo spietato Bugbear";
        sMessage9="Un povero cittadino vicino alla locanda ha la casa assediata da animali indemoniati";
        sMessage10="Al Tempio stanno cercando persone disposte a indagare sugli strani avvenimenti alle rovine della foresta di Candlekeep";
    }
    else if (sArea=="cit_ber"){
        nRandom = Random(6);
        sMessage0="Pare che il sindaco voglia porre fine all'invasione di viverne al bosco ammantato";
        sMessage1="C'e' una tipa losca in locanda, speriamo non porti guai. Pare voglia un favore per il suo Dio";
        sMessage2="Hai sentito? Si cercano volontari per mettere fine alla minaccia dei minotauri in citta'";
        sMessage3="Pare che al Tempio del Mattino i druidi stiano cercando un'antidoto allo sguardo dei basilischi.. Se solo qualcuno gli portasse le loro scaglie..";
        sMessage4="Un cantastorie alla locanda narra di lupi enormi nei dintorni della citta'..";
        sMessage5="Pare che nel deserto a nord di beregost ci sia un mago con enormi poteri..";
    }
    else if(sArea=="cit_nas"){
        nRandom = Random(5);
        sMessage0="Non vedo l'ora che qualcuno conci per le feste gli gnoll, non si riesce pi a vivere per colpa loro. In locanda pagano per vedere la testa di Ingot appesa in citta'.";
        sMessage1="Quel povero mago in locanda e' rimasto senza compagni per colpa della spedizione dagli Ogre. Ora pare cerchi volontari per completare cio' che hanno fallito.";
        sMessage2="Avete sentito del povero contadino nella nostra campagna? I Ragni gli hanno avvelenato tutto il bestiame, speriamo qualcuno lo aiuti";
        sMessage3="Pare che Gimli il capo minatore si sia rifugiato negli alloggi delle miniere. Qualcuno dovrebbe aiutarlo a liberare la zona dai Troll.";
        sMessage4="Roirry cerca persone per sconfiggere gli orsi che minacciano le provviste della citta'";
    }
    else if (sArea=="cit_loc_est"){
        nRandom = Random(5);
        sMessage0="Quello scorbutico Halfling vuole a tutti costi i suoi stivali indietro, ma non puo' recuperarseli da solo?";
        sMessage1="Qui in locanda per colpa dei banditi si sta andando a secco col vino, Tarens non potra' tenere aperto per molto di questo passo.";
        sMessage2="Macharto arruola soldati per sconfiggere Epxin e i suoi coboldi che non permettono scambi sicuri con Baldur's Gate";
        sMessage3="Hai sentito quella leggenda che narra che nelle profondita' di questa terra ci siano esseri uomo-scorpione con grossi poteri?";
        sMessage4="Periadoc cerca gente disponibile a riportare alla luce antichi vasi. Secondo lui sono dispersi nelle profondita' di una caverna a nord";
    }
    else if (sArea=="cit_bal_gov"||sArea=="cit_bal_nob"||sArea=="cit_bal_pop"||sArea=="cit_bal_mur"||sArea=="cit_bal_por"){
        nRandom = Random(9);
        sMessage0="Addeth, un ricco mercante, ha bisogno di persone disponibili a liberarlo dei druidi a Bosco Ammantato. Lo si puo' trovare nel Quartiere Nobile";
        sMessage1="Un devoto di Talos alla locanda cerca devoti per liberare la zona del ponte dai trogloditi";
        sMessage2="Una sacerdotessa di Mielikki, nella zona del porto, cerca avventurieri per estirpare il morbo della licantropia";
        sMessage3="Un emissario degli Arpisti, nella zona del porto, cerca avventurieri per elimare gli Yuan-ti che infestano la zona del faro";
        sMessage4="Il povero Wallen, a cui era stato ordinato di pulire le fogne, non puo' adempiere al suo lavoro perche' dice che queste siano popolate da strani esseri. Sara' sicuramente ben lieto di una mano, lo si trova nel Quartiere Nobile.";
        sMessage5="Thance appena fuori da Baldur's Gate sta cercando mercenari per estrarre la tossina dei Troll della Fanghiglia e ricavarne potenti armi.";
        sMessage6="Ci vorrebbe qualcuno che metta a tacere una volta per tutte Skalmad e i suoi Troll. Magari qualche prigioniero e' ancora vivo.. Se solo Baldur's avesse soldati da inviare..";
        sMessage7="Pare che un ricco mercante alla compagnia commerciale paghi molto bene per una mansione..";
        sMessage8="Appena fuori da Baldur's Gate ho notato un'Elfo Acquatico. E' difficile vederne uno, ma pare che abbiano grossi problemi coi Sahuagin.";
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
        case 10:
            SpeakString(sMessage9);
            break;
    }
}

void ChatTime(object oPNG){
    int nRandom = Random(50);
    if(nRandom == 1)
        MandaMex(oPNG);
    DelayCommand(6.0,ChatTime(oPNG));
}

void main()
{
    ChatTime(OBJECT_SELF);
}
