int LetturaQuest(int nQuest, object oPC);
void ScritturaQuest(string sNewStateQuest, int nQuest, object oPC);
void InizializzioneQuest(object oPC);
void CopiaStringa(object oPC);
void IncollaStringa(object oPC, string sTotalQuest);
void CopiaIncollaDatabase(object oPC);
void AggiornaDiario(object oPC);
int Conversione(string sConvert);
string RiConversione(int nConvert);

string RiConversione(int nConvert){
    if(nConvert==0)
        return "0";
    else if(nConvert==1)
        return "1";
    else if(nConvert==2)
        return "2";
    else if(nConvert==3)
        return "3";
    else if(nConvert==4)
        return "4";
    else if(nConvert==5)
        return "5";
    else if(nConvert==6)
        return "6";
    else if(nConvert==7)
        return "7";
    else if(nConvert==8)
        return "8";
    else if(nConvert==9)
        return "9";
    else if(nConvert==10)
        return "a";
    else if(nConvert==11)
        return "b";
    else if(nConvert==12)
        return "c";
    else if(nConvert==13)
        return "d";
    else if(nConvert==14)
        return "e";
    else if(nConvert==15)
        return "f";
    else if(nConvert==16)
        return "g";
    else if(nConvert==17)
        return "h";
    return "0";
}

int Conversione(string sConvert){
    if(sConvert=="0")
        return 0;
    else if(sConvert=="1")
        return 1;
    else if(sConvert=="2")
        return 2;
    else if(sConvert=="3")
        return 3;
    else if(sConvert=="4")
        return 4;
    else if(sConvert=="5")
        return 5;
    else if(sConvert=="6")
        return 6;
    else if(sConvert=="7")
        return 7;
    else if(sConvert=="8")
        return 8;
    else if(sConvert=="9")
        return 9;
    else if(sConvert=="a")
        return 10;
    else if(sConvert=="b")
        return 11;
    else if(sConvert=="c")
        return 12;
    else if(sConvert=="d")
        return 13;
    else if(sConvert=="e")
        return 14;
    else if(sConvert=="f")
        return 15;
    else if(sConvert=="g")
        return 16;
    else if(sConvert=="h")
        return 17;
    return 0;
}

int LetturaQuest(int nQuest, object oPC){
    string sTotalQuest = GetLocalString(oPC,"quest");
    int nLenght = GetStringLength(sTotalQuest);
    // SE LA QUEST E' LA PRIMA
    if(nQuest == 1){
        // E' SEMPRE L'ULTIMO ELEMENTO
        return Conversione(GetSubString(sTotalQuest,nLenght-1,1));
    }
    // SE LA QUEST E' GRANDE UGUALE ALLA STRINGA
    else if(nQuest == nLenght){
        // E' SEMPRE IL PRIMO ELEMENTO
        return Conversione(GetSubString(sTotalQuest,0,1));
    }
    // SE LA QUEST E' IN MEZZO ALLA STRINGA
    else if(nQuest < nLenght){
        return Conversione(GetSubString(sTotalQuest,nLenght-nQuest,1));
    }
    // SE LA QUEST E' MAGGIORE DELLA STRINGA (PRIMA VOLTA QUEST QUINDI)
    else if(nQuest > nLenght){
        int i;
        for(i=0;i<(nQuest-nLenght);i++){
            sTotalQuest = "0"+sTotalQuest;
        }
        SetLocalString(oPC,"quest",sTotalQuest);
        return 0;
    }
    return 0;
}

void ScritturaQuest(string sNewStateQuest, int nQuest, object oPC){
    string sTotalQuest = GetLocalString(oPC,"quest");
    int nLenght = GetStringLength(sTotalQuest);
    // SE LA QUEST E' LA PRIMA
    if(nQuest == 1 && nLenght > 1){
        // E' SEMPRE L'ULTIMO ELEMENTO
        string sOldStateQuest = GetSubString(sTotalQuest,0,nLenght-1);
        SetLocalString(oPC,"quest",sOldStateQuest+sNewStateQuest);
    }
    else if(nQuest == 1 && nLenght == 1){
        // E' SEMPRE L'ULTIMO ELEMENTO
        SetLocalString(oPC,"quest",sNewStateQuest);
    }
    // SE LA QUEST E' GRANDE UGUALE ALLA STRINGA
    else if(nQuest == nLenght){
        // E' SEMPRE IL PRIMO ELEMENTO
        string sOldStateQuest = GetSubString(sTotalQuest,1,nLenght-1);
        SetLocalString(oPC,"quest",sNewStateQuest+sOldStateQuest);
    }
    // SE LA QUEST E' IN MEZZO ALLA STRINGA
    else if(nQuest < nLenght){
        string sLeft = GetSubString(sTotalQuest,0,nLenght-nQuest);
        string sRight = GetSubString(sTotalQuest,nLenght-nQuest+1,nLenght-(nLenght-nQuest+1));
        SetLocalString(oPC,"quest",sLeft+sNewStateQuest+sRight);
    }
    return;
}

void InizializzioneQuest(object oPC){
    SetCampaignString("accademia_new","quest","0",oPC);
}

void CopiaStringa(object oPC){
    string sTotalQuest = GetCampaignString("accademia_new","quest",oPC);
    SetLocalString(oPC,"quest",sTotalQuest);
}

void IncollaStringa(object oPC, string sTotalQuest){
    SetCampaignString("accademia_new","quest",sTotalQuest,oPC);
}

void CopiaIncollaDatabase(object oPC){
    int nQuest1 = GetCampaignInt("ACCADEMIA","quest_1",oPC);
    int nQuest2 = GetCampaignInt("ACCADEMIA","quest_2",oPC);
    int nQuest3 = GetCampaignInt("ACCADEMIA","quest_3",oPC);
    int nQuest4 = GetCampaignInt("ACCADEMIA","quest_4",oPC);
    int nQuest5 = GetCampaignInt("ACCADEMIA","quest_5",oPC);
    int nQuest6 = GetCampaignInt("ACCADEMIA","quest_6",oPC);
    int nQuest7 = GetCampaignInt("ACCADEMIA","quest_7",oPC);
    int nQuest8 = GetCampaignInt("ACCADEMIA","quest_8",oPC);
    int nQuest9 = GetCampaignInt("ACCADEMIA","quest_9",oPC);
    int nQuest10 = GetCampaignInt("ACCADEMIA","quest_10",oPC);
    int nQuest11 = GetCampaignInt("ACCADEMIA","quest_11",oPC);
    int nQuest12 = GetCampaignInt("ACCADEMIA","quest_12",oPC);
    int nQuest13 = GetCampaignInt("ACCADEMIA","quest_13",oPC);
    int nQuest14 = GetCampaignInt("ACCADEMIA","quest_14",oPC);
    int nQuest15 = GetCampaignInt("ACCADEMIA","quest_15",oPC);
    int nQuest16 = GetCampaignInt("ACCADEMIA","quest_16",oPC);
    int nQuest17 = GetCampaignInt("ACCADEMIA","quest_17",oPC);
    int nQuest18 = GetCampaignInt("ACCADEMIA","quest_18",oPC);
    int nQuest19 = GetCampaignInt("ACCADEMIA","quest_19",oPC);
    int nQuest20 = GetCampaignInt("ACCADEMIA","quest_20",oPC);
    int nQuest21 = GetCampaignInt("ACCADEMIA","quest_21",oPC);
    int nQuest22 = GetCampaignInt("ACCADEMIA","quest_22",oPC);
    int nQuest23 = GetCampaignInt("ACCADEMIA","quest_23",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_1",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_2",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_3",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_4",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_5",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_6",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_7",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_8",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_9",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_10",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_11",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_12",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_13",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_14",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_15",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_16",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_17",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_18",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_19",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_20",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_21",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_22",oPC);
    DeleteCampaignVariable("ACCADEMIA","quest_23",oPC);
    DeleteCampaignVariable("ACCADEMIA","inizio",oPC);
    string sNewString = RiConversione(nQuest23)+RiConversione(nQuest22)+RiConversione(nQuest21)+RiConversione(nQuest20)+
    RiConversione(nQuest19)+RiConversione(nQuest18)+RiConversione(nQuest17)+RiConversione(nQuest16)+RiConversione(nQuest15)+
    RiConversione(nQuest14)+RiConversione(nQuest13)+RiConversione(nQuest12)+RiConversione(nQuest11)+RiConversione(nQuest10)+
    RiConversione(nQuest9)+RiConversione(nQuest8)+RiConversione(nQuest7)+RiConversione(nQuest6)+RiConversione(nQuest5)+
    RiConversione(nQuest4)+RiConversione(nQuest3)+RiConversione(nQuest2)+RiConversione(nQuest1);
    SetCampaignString("accademia_new","quest",sNewString,oPC);
}

void AggiornaDiario(object oPC){
    string sTotalQuest = GetLocalString(oPC,"quest");
    int nLenght = GetStringLength(sTotalQuest);
    int i;
    int nConvert;
    for(i=1;i<=nLenght;i++){
        nConvert = Conversione(GetSubString(sTotalQuest,i-1,1));
        if(nConvert!=0)
            AddJournalQuestEntry("quest_"+IntToString(nLenght-(i-1)),nConvert,oPC,FALSE);
    }
}
